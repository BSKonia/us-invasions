from fastapi import FastAPI, Query, HTTPException, Header, Depends
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Optional
import os
import httpx
import json
from google import genai
from dotenv import load_dotenv

load_dotenv()

app = FastAPI(title="USInterventions Dashboard API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], 
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

SUPABASE_URL = os.getenv("SUPABASE_URL", "https://ckmoeexhnmzyajfphssa.supabase.co")
SUPABASE_KEY = os.getenv("SUPABASE_KEY", "sb_publishable_MEpINIGSIvN2C2KRaPsL0Q_Q4aWh12h")
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")

if GEMINI_API_KEY:
    client_genai = genai.Client(api_key=GEMINI_API_KEY)
else:
    client_genai = None

# ================================
# INTERVENCIONES
# ================================
@app.get("/api/interventions")
async def get_interventions(
    start_year: int = Query(1850, description="Año de inicio"),
    end_year: int = Query(2026, description="Año de fin"),
    type_id: Optional[str] = Query(None, description="Filtrar por tipo de intervención")
):
    headers = {
        "apikey": SUPABASE_KEY,
        "Authorization": f"Bearer {SUPABASE_KEY}",
        "Content-Type": "application/json"
    }
    url = f"{SUPABASE_URL}/rest/v1/interventions"
    
    query_params = [
        ("select", "*,intervention_types(*),evidence_sources(*)"),
        ("start_year", f"gte.{start_year}"),
        ("start_year", f"lte.{end_year}")
    ]
    if type_id:
        query_params.append(("type_id", f"eq.{type_id}"))

    from urllib.parse import urlencode
    query_string = urlencode(query_params)

    async with httpx.AsyncClient() as client:
        response = await client.get(f"{url}?{query_string}", headers=headers)
    
    data = response.json()
    if response.status_code != 200:
        return {"type": "FeatureCollection", "features": [], "error": data}
        
    features = []
    if isinstance(data, list):
        for item in data:
            lat = item.get("latitude")
            lng = item.get("longitude")
            if lat is None or lng is None:
                continue
                
            feature = {
                "type": "Feature",
                "geometry": {
                    "type": "Point",
                    "coordinates": [float(lng), float(lat)]
                },
                "properties": {
                    "id": item["id"],
                    "title": item["title"],
                    "country_name": item["country_name"],
                    "start_year": item["start_year"],
                    "end_year": item["end_year"],
                    "description": item["description"],
                    "color_code": item.get("intervention_types", {}).get("color_code", "#ff0000") if item.get("intervention_types") else "#ff0000",
                    "type_name": item.get("intervention_types", {}).get("name", "Desconocido") if item.get("intervention_types") else "Desconocido",
                    "icon": get_icon(item.get("intervention_types", {}).get("name", "") if item.get("intervention_types") else ""),
                    "tags": json.dumps(generate_tags(item)),
                    "sources": item.get("evidence_sources", []),
                    "has_ai_summary": item.get("ai_summary") is not None
                }
            }
            features.append(feature)
        
    return {"type": "FeatureCollection", "features": features}

# ================================
# INTELIGENCIA ARTIFICIAL (Caché)
# ================================
@app.get("/api/interventions/{intervention_id}/summary")
async def get_intervention_ai_summary(intervention_id: str):
    headers = {
        "apikey": SUPABASE_KEY,
        "Authorization": f"Bearer {SUPABASE_KEY}",
        "Content-Type": "application/json",
        "Prefer": "return=representation"
    }
    
    async with httpx.AsyncClient() as client:
        # 1. Comprobar si ya existe en la caché (Base de datos)
        res = await client.get(
            f"{SUPABASE_URL}/rest/v1/interventions?id=eq.{intervention_id}&select=ai_summary,title,country_name,start_year",
            headers=headers
        )
        data = res.json()
        
        if not data:
            raise HTTPException(status_code=404, detail="Intervención no encontrada")
            
        intervention = data[0]
        
        # 1.1 Si existe el resumen, devolverlo instantáneamente
        if intervention.get("ai_summary"):
            return {"summary": intervention["ai_summary"], "cached": True}
            
        # 2. Si NO existe y tenemos Gemini configurado, generarlo
        if not client_genai:
            raise HTTPException(status_code=500, detail="Gemini API no está configurada en el servidor")

        prompt = f"""
Actúa como un experto en historia política y militar objetiva.
Genera un resumen de 3 párrafos sobre la siguiente intervención histórica: "{intervention.get('title')}" ocurrida en {intervention.get('country_name')} (Año de inicio: {intervention.get('start_year')}).

Sigue estrictamente esta estructura:
1. Causas principales (Contexto histórico y motivos de la intervención).
2. Desarrollo del evento (Datos clave, operaciones relevantes, duración).
3. Consecuencias geopolíticas y civiles.

Tono: Formal, académico y neutral.
Idioma: Español.
Formato: Markdown (usa negritas para nombres y fechas clave). No pongas el título, solo los párrafos.
"""
        
        try:
            # Llamada a la IA
            ai_response = client_genai.models.generate_content(
                model='gemini-2.5-flash',
                contents=prompt
            )
            generated_text = ai_response.text
            
            # 3. Guardar en caché (Actualizar la base de datos)
            patch_res = await client.patch(
                f"{SUPABASE_URL}/rest/v1/interventions?id=eq.{intervention_id}",
                headers=headers,
                json={"ai_summary": generated_text}
            )
            
            return {"summary": generated_text, "cached": False}
        except Exception as e:
            raise HTTPException(status_code=500, detail=f"Error al generar con IA: {str(e)}")

# ================================
# SISTEMA SOCIAL: COMENTARIOS
# ================================
class CommentCreate(BaseModel):
    content: str

@app.get("/api/interventions/{intervention_id}/comments")
async def get_comments(intervention_id: str):
    headers = {"apikey": SUPABASE_KEY, "Authorization": f"Bearer {SUPABASE_KEY}"}
    async with httpx.AsyncClient() as client:
        res = await client.get(
            f"{SUPABASE_URL}/rest/v1/intervention_comments?intervention_id=eq.{intervention_id}&order=created_at.desc",
            headers=headers
        )
        return res.json()

@app.post("/api/interventions/{intervention_id}/comments")
async def add_comment(intervention_id: str, comment: CommentCreate, authorization: str = Header(None)):
    if not authorization:
        raise HTTPException(status_code=401, detail="Usuario no autenticado")
        
    # Usamos el token del usuario (JWT) para que las políticas RLS de Supabase funcionen
    headers = {
        "apikey": SUPABASE_KEY,
        "Authorization": authorization, # JWT del frontend
        "Content-Type": "application/json",
        "Prefer": "return=representation"
    }
    
    async with httpx.AsyncClient() as client:
        # Primero necesitamos saber quién es el usuario llamando al endpoint de Auth de Supabase
        user_res = await client.get(f"{SUPABASE_URL}/auth/v1/user", headers=headers)
        if user_res.status_code != 200:
            raise HTTPException(status_code=401, detail="Token inválido")
            
        user_id = user_res.json().get("id")
        
        res = await client.post(
            f"{SUPABASE_URL}/rest/v1/intervention_comments",
            headers=headers,
            json={
                "intervention_id": intervention_id,
                "user_id": user_id,
                "content": comment.content
            }
        )
        return res.json()

# ================================
# SISTEMA SOCIAL: VOTOS (TripAdvisor)
# ================================
class VoteCreate(BaseModel):
    category: str
    score: int

@app.get("/api/interventions/{intervention_id}/votes")
async def get_votes(intervention_id: str):
    headers = {"apikey": SUPABASE_KEY, "Authorization": f"Bearer {SUPABASE_KEY}"}
    async with httpx.AsyncClient() as client:
        res = await client.get(
            f"{SUPABASE_URL}/rest/v1/intervention_votes?intervention_id=eq.{intervention_id}",
            headers=headers
        )
        
        data = res.json()
        if not data or not isinstance(data, list):
            return {"averages": {}, "total_votes": 0, "raw": []}

        stats = {}
        for vote in data:
            cat = vote["category"]
            if cat not in stats:
                stats[cat] = {"total_score": 0, "count": 0}
            stats[cat]["total_score"] += vote["score"]
            stats[cat]["count"] += 1
            
        averages = {cat: round(v["total_score"] / v["count"], 1) for cat, v in stats.items()}
        return {"averages": averages, "total_votes": len(data), "raw": data}

@app.post("/api/interventions/{intervention_id}/votes")
async def add_vote(intervention_id: str, vote: VoteCreate, authorization: str = Header(None)):
    if not authorization:
        raise HTTPException(status_code=401, detail="Usuario no autenticado")
        
    if vote.score < 1 or vote.score > 5:
        raise HTTPException(status_code=400, detail="Puntuación debe estar entre 1 y 5")

    headers = {
        "apikey": SUPABASE_KEY,
        "Authorization": authorization,
        "Content-Type": "application/json",
        "Prefer": "return=representation,resolution=merge-duplicates"
    }
    
    async with httpx.AsyncClient() as client:
        user_res = await client.get(f"{SUPABASE_URL}/auth/v1/user", headers=headers)
        if user_res.status_code != 200:
            raise HTTPException(status_code=401, detail="Token inválido")
            
        user_id = user_res.json().get("id")
        
        res = await client.post(
            f"{SUPABASE_URL}/rest/v1/intervention_votes",
            headers=headers,
            json={
                "intervention_id": intervention_id,
                "user_id": user_id,
                "category": vote.category,
                "score": vote.score
            }
        )
        return res.json()

# ================================
# HELPERS
# ================================
def get_icon(type_name):
    type_name = type_name.lower()
    if "golpe" in type_name: return "🎯"
    if "bombardeo" in type_name or "ataque" in type_name: return "💣"
    if "ocupación" in type_name or "militar" in type_name: return "🛡️"
    if "injerencia" in type_name or "política" in type_name: return "🤝"
    return "📍"

def generate_tags(item):
    tags = [f"#{item['country_name'].replace(' ', '')}"]
    year = item['start_year']
    if 1947 <= year <= 1991:
        tags.append("#GuerraFría")
    elif year > 2001:
        tags.append("#WarOnTerror")
        
    type_name = item.get("intervention_types", {}).get("name", "").lower()
    if "cia" in str(item.get("description", "")).lower() or "injerencia" in type_name:
        tags.append("#CovertOps")
    return tags
