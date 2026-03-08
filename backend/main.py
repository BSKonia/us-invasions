from fastapi import FastAPI, Query
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Optional
import os
import httpx
import json
from dotenv import load_dotenv

load_dotenv()

app = FastAPI(title="Conflictly Dashboard API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], 
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

SUPABASE_URL = os.getenv("SUPABASE_URL", "https://ckmoeexhnmzyajfphssa.supabase.co")
SUPABASE_KEY = os.getenv("SUPABASE_KEY", "sb_publishable_MEpINIGSIvN2C2KRaPsL0Q_Q4aWh12h")

@app.get("/api/interventions")
async def get_interventions(
    start_year: int = Query(1850, description="Año de inicio"),
    end_year: int = Query(2026, description="Año de fin"),
    type_id: Optional[str] = Query(None, description="Filtrar por tipo de intervención")
):
    # Consulta a Supabase vía API REST directa para evitar problemas de validación del cliente
    headers = {
        "apikey": SUPABASE_KEY,
        "Authorization": f"Bearer {SUPABASE_KEY}",
        "Content-Type": "application/json"
    }
    
    url = f"{SUPABASE_URL}/rest/v1/interventions"
    params = {
        "select": "*,intervention_types(*),evidence_sources(*)",
        "start_year": f"gte.{start_year}",
        "start_year": f"lte.{end_year}" # El backend de supabase procesará la intersección si enviamos los rangos correctamente,
    }
    
    if type_id:
        params["type_id"] = f"eq.{type_id}"

    # Supabase PostgREST permite múltiples filtros del mismo campo si usamos sintaxis como: start_year=gte.1850&start_year=lte.2026
    # En httpx podemos pasar una lista de tuplas para permitir claves duplicadas en los parámetros
    query_params = [
        ("select", "*,intervention_types(*),evidence_sources(*)"),
        ("start_year", f"gte.{start_year}"),
        ("start_year", f"lte.{end_year}")
    ]
    if type_id:
        query_params.append(("type_id", f"eq.{type_id}"))

    # Convertir list of tuples a string para httpx o dictionary
    # Un dictionary sobreescribe claves duplicadas, así que mejor urlencode manualmente
    from urllib.parse import urlencode
    query_string = urlencode(query_params)

    async with httpx.AsyncClient() as client:
        response = await client.get(f"{url}?{query_string}", headers=headers)
    
    data = response.json()
    
    if response.status_code != 200:
        return {"type": "FeatureCollection", "features": [], "error": data}
        
    features = []
    # Dependiendo de si la tabla está vacía o hubo error
    if isinstance(data, list):
        for item in data:
            # Check for coordinates
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
                    "sources": item.get("evidence_sources", [])
                }
            }
            features.append(feature)
        
    return {
        "type": "FeatureCollection",
        "features": features
    }

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
