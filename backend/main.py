from fastapi import FastAPI, Query, HTTPException, Header, Depends
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Optional
import os
import re
import httpx
import json
import asyncio
from google import genai
from google.genai import types
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
# Fuentes de referencia académicas (SIEMPRE disponibles, verificadas)
# ================================
REFERENCE_SOURCES = [
    {
        "source_name": "Evergreen State College (Zoltan Grossman)",
        "date": "1798-2024",
        "headline": "A Century of U.S. Military Interventions: From Wounded Knee to Libya",
        "url": "https://sites.evergreen.edu/zoltan/interventions/",
        "snippet": "Lista académica exhaustiva de todas las intervenciones militares de EE.UU. desde 1890 hasta la actualidad, compilada por el profesor Zoltan Grossman."
    },
    {
        "source_name": "Global Policy Forum",
        "date": "1798-2023",
        "headline": "US Interventions from 1798 to the Present",
        "url": "https://archive.globalpolicy.org/us-westward-expansion/26024-us-interventions.html",
        "snippet": "Archivo histórico del Global Policy Forum con el registro completo de intervenciones estadounidenses desde la expansión territorial de 1798."
    },
    {
        "source_name": "Harvard DRCLAS (ReVista)",
        "date": "Artículo académico",
        "headline": "United States Interventions in Latin America and Beyond",
        "url": "https://revista.drclas.harvard.edu/united-states-interventions/",
        "snippet": "Análisis académico de Harvard sobre el patrón histórico de intervenciones de Estados Unidos, con enfoque en América Latina y sus consecuencias geopolíticas."
    },
]

# ================================
# Generador de URLs de búsqueda en prensa (SIEMPRE funcionan)
# ================================
PRESS_SEARCH_TEMPLATES = [
    {
        "source_name": "The New York Times",
        "base_url": "https://www.nytimes.com/search?query=",
        "snippet_tpl": "Archivo de artículos del New York Times sobre {title}. Búsqueda en la hemeroteca digital del NYT."
    },
    {
        "source_name": "BBC News",
        "base_url": "https://www.bbc.co.uk/search?q=",
        "snippet_tpl": "Cobertura de la BBC sobre {title}. Resultados de búsqueda en el archivo digital de BBC News."
    },
    {
        "source_name": "The Guardian",
        "base_url": "https://www.theguardian.com/search?q=",
        "snippet_tpl": "Reportajes y análisis de The Guardian sobre {title}. Archivo periodístico con cobertura internacional."
    },
    {
        "source_name": "Reuters",
        "base_url": "https://www.reuters.com/search/news?query=",
        "snippet_tpl": "Despachos de la agencia Reuters sobre {title}. Cobertura informativa de referencia mundial."
    },
    {
        "source_name": "AP News",
        "base_url": "https://apnews.com/search?q=",
        "snippet_tpl": "Noticias de Associated Press sobre {title}. Archivo de la principal agencia de noticias de EE.UU."
    },
]

# Diccionario para traducir términos españoles comunes en títulos/tipos a inglés
_ES_TO_EN = {
    "golpe de estado": "coup",
    "bombardeo": "bombing",
    "ocupación militar": "military occupation",
    "ocupacion militar": "military occupation",
    "injerencia política": "political interference",
    "injerencia politica": "political interference",
    "operación naval": "naval operation",
    "operacion naval": "naval operation",
    "operación encubierta": "covert operation",
    "operacion encubierta": "covert operation",
    "intervención militar": "military intervention",
    "intervencion militar": "military intervention",
    "intervención": "intervention",
    "intervencion": "intervention",
    "invasión": "invasion",
    "invasion": "invasion",
    "guerra": "war",
    "apoyo": "support",
    "derrocamiento": "overthrow",
    "bloqueo": "blockade",
    "ocupación": "occupation",
    "ocupacion": "occupation",
    "contra": "against",
    "acciones ww1": "World War 1",
    "acciones ww2": "World War 2",
}

# Preposiciones/artículos españoles que sobran en keywords inglesas
_ES_STOPWORDS = {"en", "de", "del", "la", "las", "el", "los", "y", "por", "una", "un", "al"}

def _translate_to_english(text: str) -> str:
    """Traduce términos españoles conocidos a inglés para mejorar búsquedas en prensa anglosajona."""
    result = text
    # Reemplazar frases completas primero (más largas primero para evitar reemplazos parciales)
    for es_term, en_term in sorted(_ES_TO_EN.items(), key=lambda x: -len(x[0])):
        result = re.sub(re.escape(es_term), en_term, result, flags=re.IGNORECASE)
    # Eliminar preposiciones/artículos españoles sueltos que queden
    words = result.split()
    words = [w for w in words if w.lower() not in _ES_STOPWORDS]
    return " ".join(words)


def generate_press_search_sources(title: str, country: str, year) -> list:
    """Genera URLs de búsqueda en archivos de prensa para una intervención.
    Estas URLs SIEMPRE funcionan porque apuntan a páginas de búsqueda, no a artículos concretos.
    Las keywords se construyen EN INGLÉS para que NYT, BBC, Reuters etc. devuelvan resultados."""
    from urllib.parse import quote_plus
    
    # Traducir el título a inglés si contiene términos en español
    en_title = _translate_to_english(title)
    
    # Evitar redundancia: si el país ya aparece en el título, no repetirlo
    if country.lower() in en_title.lower():
        keywords = f"US {en_title} {year}"
    else:
        keywords = f"US {country} {en_title} {year}"
    
    # Limpiar espacios múltiples
    keywords = " ".join(keywords.split())
    encoded = quote_plus(keywords)
    
    sources = []
    for tpl in PRESS_SEARCH_TEMPLATES:
        sources.append({
            "source_name": tpl["source_name"],
            "date": str(year),
            "headline": f"Búsqueda: \"{en_title}\" — {country} ({year})",
            "url": f"{tpl['base_url']}{encoded}",
            "snippet": tpl["snippet_tpl"].format(title=f"{en_title} — {country} ({year})")
        })
    return sources

# ================================
# INTERVENCIONES
# ================================
@app.get("/api/interventions")
async def get_interventions(
    start_year: int = Query(1795, description="Año de inicio"),
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


@app.delete("/api/interventions/ai_sources/cache")
async def clear_all_ai_sources_cache():
    """Limpia la caché de ai_sources de TODAS las intervenciones para forzar regeneración con el nuevo prompt."""
    headers = {
        "apikey": SUPABASE_KEY,
        "Authorization": f"Bearer {SUPABASE_KEY}",
        "Content-Type": "application/json",
        "Prefer": "return=representation"
    }
    async with httpx.AsyncClient() as client:
        # Set ai_sources to null for all interventions that have cached sources
        res = await client.patch(
            f"{SUPABASE_URL}/rest/v1/interventions?ai_sources=not.is.null",
            headers=headers,
            json={"ai_sources": None}
        )
        if res.status_code in [200, 204]:
            return {"message": "Caché de fuentes IA limpiada correctamente", "cleared": True}
        raise HTTPException(status_code=res.status_code, detail=f"No se pudo limpiar la caché: {res.text}")


# ================================
# Verificación de URLs
# ================================
async def verify_url(http_client: httpx.AsyncClient, url: str) -> bool:
    """Verifica que una URL esté viva (no 404) usando HEAD con fallback a GET."""
    try:
        # HEAD es más rápido, pero algunos servidores no lo soportan
        res = await http_client.head(url, follow_redirects=True, timeout=8.0)
        if res.status_code < 400:
            return True
        # Algunos servidores rechazan HEAD pero aceptan GET
        if res.status_code in [403, 405, 406]:
            res = await http_client.get(url, follow_redirects=True, timeout=8.0)
            return res.status_code < 400
        return False
    except Exception:
        return False


async def verify_and_filter_sources(http_client: httpx.AsyncClient, sources: list) -> list:
    """Verifica todas las URLs en paralelo y devuelve solo las que funcionan."""
    if not sources:
        return []
    
    async def check_source(source):
        url = source.get("url", "")
        if not url:
            return None
        is_valid = await verify_url(http_client, url)
        return source if is_valid else None
    
    results = await asyncio.gather(*[check_source(s) for s in sources])
    return [s for s in results if s is not None]


@app.get("/api/interventions/{intervention_id}/ai_sources")
async def get_intervention_ai_sources(intervention_id: str, force: bool = Query(False, description="Forzar regeneración ignorando caché")):
    headers = {
        "apikey": SUPABASE_KEY,
        "Authorization": f"Bearer {SUPABASE_KEY}",
        "Content-Type": "application/json",
        "Prefer": "return=representation"
    }
    
    async with httpx.AsyncClient(timeout=60.0, headers={"User-Agent": "Mozilla/5.0 (compatible; USInterventions/1.0)"}) as http_client:
        # 1. Comprobar caché
        res = await http_client.get(
            f"{SUPABASE_URL}/rest/v1/interventions?id=eq.{intervention_id}&select=ai_sources,title,country_name,start_year",
            headers=headers
        )
        data = res.json()
        
        if not data:
            raise HTTPException(status_code=404, detail="Intervención no encontrada")
            
        intervention = data[0]
        
        # Si ya existen y no se fuerza regeneración, las devolvemos
        if intervention.get("ai_sources") and not force:
            return {"sources": intervention["ai_sources"], "cached": True}
            
        if not client_genai:
            raise HTTPException(status_code=500, detail="Gemini API no configurada")

        title = intervention.get('title', '')
        country = intervention.get('country_name', '')
        year = intervention.get('start_year', '')

        # ===================================================
        # ESTRATEGIA: Fuentes IA verificadas + 5 búsquedas en prensa + 3 referencias académicas
        # Sin límite fijo: cada intervención puede tener tantas fuentes como encuentre
        # ===================================================

        # Paso 1: Las 3 fuentes de referencia académicas (SIEMPRE funcionan)
        reference_sources = [dict(s) for s in REFERENCE_SOURCES]  # Copias para no mutar

        # Paso 2: Pedir a Gemini fuentes adicionales específicas con Google Search Grounding
        ai_verified_sources = []
        try:
            prompt = (
                f'Busca artículos de prensa y documentos académicos REALES sobre: '
                f'"{title}" ({year}) en {country}, intervención de Estados Unidos.\n\n'
                f'Necesito exactamente 4 fuentes periodísticas o académicas que pueda consultar online ahora mismo.\n\n'
                f'REGLAS ESTRICTAS:\n'
                f'- SOLO incluye URLs que existan REALMENTE y que hayas encontrado en tu búsqueda de Google.\n'
                f'- Prioriza: artículos de prensa (NYT, BBC, Reuters, The Guardian, Washington Post, AP News), '
                f'documentos PDF académicos, informes del Congressional Research Service, National Security Archive, JSTOR.\n'
                f'- Si encuentras un PDF académico relevante, inclúyelo con su URL directa.\n'
                f'- NO inventes URLs. NO uses Wikipedia.\n'
                f'- Varía las fuentes: usa al menos 3 medios diferentes.\n\n'
                f'DEVUELVE SOLO un array JSON (sin markdown, sin ```), con esta estructura:\n'
                f'[\n'
                f'  {{\n'
                f'    "source_name": "Nombre del medio",\n'
                f'    "date": "Fecha publicación",\n'
                f'    "headline": "Titular exacto del artículo",\n'
                f'    "url": "https://url-real-verificada",\n'
                f'    "snippet": "Resumen de 1-2 líneas."\n'
                f'  }}\n'
                f']'
            )

            ai_response = client_genai.models.generate_content(
                model='gemini-2.5-flash',
                contents=prompt,
                config=types.GenerateContentConfig(
                    tools=[types.Tool(google_search=types.GoogleSearch())],
                )
            )
            raw_text = ai_response.text or ""

            # Recopilar todas las URLs candidatas: del JSON de Gemini + del grounding metadata
            candidate_sources = []

            # 2a. Intentar parsear el JSON de la respuesta de texto
            clean_text = raw_text.replace("```json", "").replace("```", "").strip()
            try:
                parsed_sources = json.loads(clean_text)
                if isinstance(parsed_sources, list):
                    candidate_sources.extend(parsed_sources)
            except json.JSONDecodeError:
                pass

            # 2b. Extraer URLs del grounding metadata (son URLs que Google realmente encontró)
            grounded_urls = []
            if ai_response.candidates and ai_response.candidates[0].grounding_metadata:
                gm = ai_response.candidates[0].grounding_metadata
                if gm.grounding_chunks:
                    for chunk in gm.grounding_chunks:
                        if chunk.web and chunk.web.uri:
                            grounded_urls.append({
                                "uri": chunk.web.uri,
                                "title": chunk.web.title or "",
                                "domain": chunk.web.domain or ""
                            })

            # Añadir grounding URLs que no estén ya en los candidatos
            candidate_urls = {s.get("url", "") for s in candidate_sources}
            for g_url in grounded_urls:
                if g_url["uri"] not in candidate_urls:
                    candidate_sources.append({
                        "source_name": g_url.get("domain", "Fuente verificada"),
                        "date": str(year),
                        "headline": g_url.get("title", f"Artículo sobre {title}"),
                        "url": g_url["uri"],
                        "snippet": f"Fuente encontrada por Google sobre {title} ({year}) en {country}."
                    })
                    candidate_urls.add(g_url["uri"])

            # Paso 3: VERIFICAR cada URL con HTTP HEAD/GET (en paralelo)
            if candidate_sources:
                print(f"[SOURCES] Verificando {len(candidate_sources)} URLs candidatas para '{title}'...")
                ai_verified_sources = await verify_and_filter_sources(http_client, candidate_sources)
                print(f"[SOURCES] {len(ai_verified_sources)}/{len(candidate_sources)} URLs verificadas OK")

        except Exception as e:
            print(f"[SOURCES] Error en Gemini Grounding: {e}")
            # Si Gemini falla, seguimos con las fuentes de referencia

        # Paso 4: Combinar TODAS las fuentes (sin límites artificiales)
        # Orden: fuentes IA verificadas → fuentes de prensa (búsqueda) → referencias académicas
        final_sources = []
        seen_urls = set()

        # 4a. Añadir TODAS las fuentes verificadas de IA (sin cap)
        for source in ai_verified_sources:
            url = source.get("url", "")
            if url and url not in seen_urls:
                final_sources.append(source)
                seen_urls.add(url)

        # 4b. Añadir URLs de búsqueda en prensa (siempre funcionan)
        press_sources = generate_press_search_sources(title, country, year)
        for ps in press_sources:
            url = ps.get("url", "")
            if url and url not in seen_urls:
                final_sources.append(ps)
                seen_urls.add(url)

        # 4c. Añadir TODAS las fuentes de referencia académicas (siempre)
        for ref_source in reference_sources:
            if ref_source["url"] not in seen_urls:
                final_sources.append(ref_source)
                seen_urls.add(ref_source["url"])

        # Guardar en base de datos
        await http_client.patch(
            f"{SUPABASE_URL}/rest/v1/interventions?id=eq.{intervention_id}",
            headers=headers,
            json={"ai_sources": final_sources}
        )
        
        return {"sources": final_sources, "cached": False}

# ================================
# SISTEMA SOCIAL: COMENTARIOS
# ================================
class CommentCreate(BaseModel):
    content: str

@app.get("/api/interventions/{intervention_id}/comments")
async def get_comments(intervention_id: str):
    headers = {"apikey": SUPABASE_KEY, "Authorization": f"Bearer {SUPABASE_KEY}"}
    async with httpx.AsyncClient() as client:
        # Try to read from the view that joins comments with usernames
        res = await client.get(
            f"{SUPABASE_URL}/rest/v1/comments_with_users?intervention_id=eq.{intervention_id}&order=created_at.desc",
            headers=headers
        )
        if res.status_code != 200 or "details" in res.text.lower() or "404" in str(res.status_code):
            # Fallback to normal comments if the view is not created yet
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
# BASES MILITARES
# ================================

# Fuentes de referencia para bases militares (SIEMPRE disponibles)
BASE_REFERENCE_SOURCES = [
    {
        "source_name": "David Vine — American University",
        "date": "2015-2024",
        "headline": "Base Nation: How U.S. Military Bases Abroad Harm America and the World",
        "url": "https://dfrlab.org/2024/03/07/mapping-us-military-bases-globally/",
        "snippet": "Investigación del profesor David Vine (American University) sobre la red global de bases militares de EE.UU. y su impacto geopolítico."
    },
    {
        "source_name": "GlobalSecurity.org",
        "date": "Actualización continua",
        "headline": "US Military Installations Worldwide",
        "url": "https://www.globalsecurity.org/military/facility/",
        "snippet": "Directorio exhaustivo de instalaciones militares de EE.UU. en todo el mundo, con datos técnicos y operativos."
    },
    {
        "source_name": "Library of Congress — Congressional Research Service",
        "date": "Informes periódicos",
        "headline": "Overseas U.S. Military Bases: Background and Issues",
        "url": "https://sgp.fas.org/crs/natsec/",
        "snippet": "Informes del Servicio de Investigación del Congreso sobre el despliegue de bases militares estadounidenses en el extranjero."
    },
]


@app.get("/api/military_bases")
async def get_military_bases():
    headers = {
        "apikey": SUPABASE_KEY,
        "Authorization": f"Bearer {SUPABASE_KEY}",
        "Content-Type": "application/json"
    }
    url = f"{SUPABASE_URL}/rest/v1/military_bases"
    query_params = "select=*"

    async with httpx.AsyncClient() as client:
        response = await client.get(f"{url}?{query_params}", headers=headers)

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
                    "name": item.get("name", ""),
                    "title": item.get("name", ""),  # alias for popup compatibility
                    "country_name": item.get("country_name", ""),
                    "description": item.get("description", ""),
                    "category": item.get("category", ""),
                    "branch": item.get("branch", ""),
                    "status": item.get("status", "Active"),
                    "year_established": item.get("year_established"),
                    "year_closed": item.get("year_closed"),
                    "is_base": True,
                    "color_code": "#00CED1",
                    "type_name": "Base Militar",
                    "has_ai_summary": item.get("ai_summary") is not None
                }
            }
            features.append(feature)

    return {"type": "FeatureCollection", "features": features}


@app.get("/api/military_bases/{base_id}/summary")
async def get_base_ai_summary(base_id: str):
    headers = {
        "apikey": SUPABASE_KEY,
        "Authorization": f"Bearer {SUPABASE_KEY}",
        "Content-Type": "application/json",
        "Prefer": "return=representation"
    }

    async with httpx.AsyncClient() as client:
        res = await client.get(
            f"{SUPABASE_URL}/rest/v1/military_bases?id=eq.{base_id}&select=ai_summary,name,country_name,category,branch,status,year_established",
            headers=headers
        )
        data = res.json()

        if not data:
            raise HTTPException(status_code=404, detail="Base militar no encontrada")

        base = data[0]

        if base.get("ai_summary"):
            return {"summary": base["ai_summary"], "cached": True}

        if not client_genai:
            raise HTTPException(status_code=500, detail="Gemini API no está configurada en el servidor")

        prompt = f"""
Actúa como un experto en geopolítica militar y defensa.
Genera un resumen de 3 párrafos sobre la siguiente base militar de EE.UU.: "{base.get('name')}" en {base.get('country_name')}.
Categoría: {base.get('category', 'N/A')}. Rama: {base.get('branch', 'N/A')}. Estado: {base.get('status', 'N/A')}.
{f"Año de establecimiento: {base.get('year_established')}." if base.get('year_established') else ""}

Sigue estrictamente esta estructura:
1. Historia y origen de la base (contexto geopolítico de su establecimiento).
2. Función estratégica actual (tipo de operaciones, importancia militar regional).
3. Impacto local y controversias (relaciones con la población, incidentes, protestas).

Tono: Formal, académico y neutral.
Idioma: Español.
Formato: Markdown (usa negritas para nombres y fechas clave). No pongas el título, solo los párrafos.
"""

        try:
            ai_response = client_genai.models.generate_content(
                model='gemini-2.5-flash',
                contents=prompt
            )
            generated_text = ai_response.text

            await client.patch(
                f"{SUPABASE_URL}/rest/v1/military_bases?id=eq.{base_id}",
                headers=headers,
                json={"ai_summary": generated_text}
            )

            return {"summary": generated_text, "cached": False}
        except Exception as e:
            raise HTTPException(status_code=500, detail=f"Error al generar con IA: {str(e)}")


@app.get("/api/military_bases/{base_id}/ai_sources")
async def get_base_ai_sources(base_id: str, force: bool = Query(False)):
    headers = {
        "apikey": SUPABASE_KEY,
        "Authorization": f"Bearer {SUPABASE_KEY}",
        "Content-Type": "application/json",
        "Prefer": "return=representation"
    }

    async with httpx.AsyncClient(timeout=60.0, headers={"User-Agent": "Mozilla/5.0 (compatible; USInterventions/1.0)"}) as http_client:
        res = await http_client.get(
            f"{SUPABASE_URL}/rest/v1/military_bases?id=eq.{base_id}&select=ai_sources,name,country_name,year_established",
            headers=headers
        )
        data = res.json()

        if not data:
            raise HTTPException(status_code=404, detail="Base militar no encontrada")

        base = data[0]

        if base.get("ai_sources") and not force:
            return {"sources": base["ai_sources"], "cached": True}

        if not client_genai:
            raise HTTPException(status_code=500, detail="Gemini API no configurada")

        name = base.get('name', '')
        country = base.get('country_name', '')
        year = base.get('year_established', '')

        # Fuentes de referencia para bases (siempre funcionan)
        reference_sources = [dict(s) for s in BASE_REFERENCE_SOURCES]

        # Pedir a Gemini fuentes con Google Search Grounding
        ai_verified_sources = []
        try:
            prompt = (
                f'Busca artículos y documentos REALES sobre la base militar de EE.UU.: '
                f'"{name}" en {country}.\n\n'
                f'Necesito exactamente 4 fuentes periodísticas o académicas que pueda consultar online ahora mismo.\n\n'
                f'REGLAS ESTRICTAS:\n'
                f'- SOLO incluye URLs que existan REALMENTE y que hayas encontrado en tu búsqueda de Google.\n'
                f'- Prioriza: artículos de prensa (NYT, BBC, Reuters, The Guardian, The Intercept, High North News), '
                f'documentos del GAO, Congressional Research Service, informes militares oficiales.\n'
                f'- NO inventes URLs. NO uses Wikipedia.\n'
                f'- Varía las fuentes: usa al menos 3 medios diferentes.\n\n'
                f'DEVUELVE SOLO un array JSON (sin markdown, sin ```), con esta estructura:\n'
                f'[\n'
                f'  {{\n'
                f'    "source_name": "Nombre del medio",\n'
                f'    "date": "Fecha publicación",\n'
                f'    "headline": "Titular exacto del artículo",\n'
                f'    "url": "https://url-real-verificada",\n'
                f'    "snippet": "Resumen de 1-2 líneas."\n'
                f'  }}\n'
                f']'
            )

            ai_response = client_genai.models.generate_content(
                model='gemini-2.5-flash',
                contents=prompt,
                config=types.GenerateContentConfig(
                    tools=[types.Tool(google_search=types.GoogleSearch())],
                )
            )
            raw_text = ai_response.text or ""

            candidate_sources = []

            clean_text = raw_text.replace("```json", "").replace("```", "").strip()
            try:
                parsed_sources = json.loads(clean_text)
                if isinstance(parsed_sources, list):
                    candidate_sources.extend(parsed_sources)
            except json.JSONDecodeError:
                pass

            grounded_urls = []
            if ai_response.candidates and ai_response.candidates[0].grounding_metadata:
                gm = ai_response.candidates[0].grounding_metadata
                if gm.grounding_chunks:
                    for chunk in gm.grounding_chunks:
                        if chunk.web and chunk.web.uri:
                            grounded_urls.append({
                                "uri": chunk.web.uri,
                                "title": chunk.web.title or "",
                                "domain": chunk.web.domain or ""
                            })

            candidate_urls = {s.get("url", "") for s in candidate_sources}
            for g_url in grounded_urls:
                if g_url["uri"] not in candidate_urls:
                    candidate_sources.append({
                        "source_name": g_url.get("domain", "Fuente verificada"),
                        "date": str(year) if year else "N/A",
                        "headline": g_url.get("title", f"Artículo sobre {name}"),
                        "url": g_url["uri"],
                        "snippet": f"Fuente encontrada por Google sobre la base {name} en {country}."
                    })
                    candidate_urls.add(g_url["uri"])

            if candidate_sources:
                print(f"[BASE SOURCES] Verificando {len(candidate_sources)} URLs candidatas para '{name}'...")
                ai_verified_sources = await verify_and_filter_sources(http_client, candidate_sources)
                print(f"[BASE SOURCES] {len(ai_verified_sources)}/{len(candidate_sources)} URLs verificadas OK")

        except Exception as e:
            print(f"[BASE SOURCES] Error en Gemini Grounding: {e}")

        # Combinar fuentes
        final_sources = []
        seen_urls = set()

        for source in ai_verified_sources:
            url = source.get("url", "")
            if url and url not in seen_urls:
                final_sources.append(source)
                seen_urls.add(url)

        # Press search URLs for bases
        en_name = _translate_to_english(name)
        press_sources = generate_press_search_sources(en_name, country, year if year else "US military base")
        for ps in press_sources:
            url = ps.get("url", "")
            if url and url not in seen_urls:
                final_sources.append(ps)
                seen_urls.add(url)

        for ref_source in reference_sources:
            if ref_source["url"] not in seen_urls:
                final_sources.append(ref_source)
                seen_urls.add(ref_source["url"])

        # Guardar en DB
        await http_client.patch(
            f"{SUPABASE_URL}/rest/v1/military_bases?id=eq.{base_id}",
            headers=headers,
            json={"ai_sources": final_sources}
        )

        return {"sources": final_sources, "cached": False}


# ================================
# BASES MILITARES: COMENTARIOS
# ================================
@app.get("/api/military_bases/{base_id}/comments")
async def get_base_comments(base_id: str):
    headers = {"apikey": SUPABASE_KEY, "Authorization": f"Bearer {SUPABASE_KEY}"}
    async with httpx.AsyncClient() as client:
        res = await client.get(
            f"{SUPABASE_URL}/rest/v1/base_comments_with_users?base_id=eq.{base_id}&order=created_at.desc",
            headers=headers
        )
        if res.status_code != 200 or "details" in res.text.lower():
            res = await client.get(
                f"{SUPABASE_URL}/rest/v1/base_comments?base_id=eq.{base_id}&order=created_at.desc",
                headers=headers
            )
        return res.json()


@app.post("/api/military_bases/{base_id}/comments")
async def add_base_comment(base_id: str, comment: CommentCreate, authorization: str = Header(None)):
    if not authorization:
        raise HTTPException(status_code=401, detail="Usuario no autenticado")

    headers = {
        "apikey": SUPABASE_KEY,
        "Authorization": authorization,
        "Content-Type": "application/json",
        "Prefer": "return=representation"
    }

    async with httpx.AsyncClient() as client:
        user_res = await client.get(f"{SUPABASE_URL}/auth/v1/user", headers=headers)
        if user_res.status_code != 200:
            raise HTTPException(status_code=401, detail="Token inválido")

        user_id = user_res.json().get("id")

        res = await client.post(
            f"{SUPABASE_URL}/rest/v1/base_comments",
            headers=headers,
            json={
                "base_id": base_id,
                "user_id": user_id,
                "content": comment.content
            }
        )
        return res.json()


# ================================
# BASES MILITARES: VOTOS
# ================================
@app.get("/api/military_bases/{base_id}/votes")
async def get_base_votes(base_id: str):
    headers = {"apikey": SUPABASE_KEY, "Authorization": f"Bearer {SUPABASE_KEY}"}
    async with httpx.AsyncClient() as client:
        res = await client.get(
            f"{SUPABASE_URL}/rest/v1/base_votes?base_id=eq.{base_id}",
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


@app.post("/api/military_bases/{base_id}/votes")
async def add_base_vote(base_id: str, vote: VoteCreate, authorization: str = Header(None)):
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
            f"{SUPABASE_URL}/rest/v1/base_votes",
            headers=headers,
            json={
                "base_id": base_id,
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
    if "naval" in type_name: return "⚓"
    if "encubierta" in type_name or "clandestina" in type_name: return "🕵️"
    if "ww1" in type_name: return "⚔️"
    if "ww2" in type_name: return "🪖"
    return "📍"

def generate_tags(item):
    tags = [f"#{item['country_name'].replace(' ', '')}"]
    year = item['start_year']
    type_name = item.get("intervention_types", {}).get("name", "").lower()
    
    # Era tags
    if "ww1" in type_name:
        tags.append("#WW1")
    elif "ww2" in type_name:
        tags.append("#WW2")
    elif year < 1850:
        tags.append("#ExpansiónTemprana")
    elif 1850 <= year < 1900:
        tags.append("#EraImperial")
    elif 1900 <= year < 1947:
        tags.append("#DiplomaciaDelDólar")
    elif 1947 <= year <= 1991:
        tags.append("#GuerraFría")
    elif year > 2001:
        tags.append("#WarOnTerror")
        
    desc = str(item.get("description", "")).lower()
    if "cia" in desc or "encubierta" in type_name:
        tags.append("#CovertOps")
    if "naval" in type_name:
        tags.append("#Naval")
    return tags
