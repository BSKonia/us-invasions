import os
import httpx
import asyncio
from dotenv import load_dotenv

load_dotenv()

SUPABASE_URL = os.getenv("SUPABASE_URL", "https://ckmoeexhnmzyajfphssa.supabase.co")
SUPABASE_KEY = os.getenv("SUPABASE_KEY", "sb_publishable_MEpINIGSIvN2C2KRaPsL0Q_Q4aWh12h")

HEADERS = {
    "apikey": SUPABASE_KEY,
    "Authorization": f"Bearer {SUPABASE_KEY}",
    "Content-Type": "application/json",
    "Prefer": "return=representation"
}

# Coordenadas aproximadas para los países
COUNTRY_COORDS = {
    "Cuba": [21.5, -77.8], "Dominican Rep": [18.7, -70.2], "Grenada": [12.1, -61.7],
    "Guatemala": [15.8, -90.2], "Haiti": [19.0, -72.3], "Mexico": [23.6, -102.5],
    "Nicaragua": [12.9, -85.2], "Panama": [8.5, -80.8], "Bolivia": [-16.3, -68.1],
    "Brazil": [-14.2, -51.9], "Chile": [-35.7, -71.5], "El Salvador": [13.8, -88.9],
    "Guyana": [4.9, -58.9], "Honduras": [15.2, -86.2], "China": [35.9, 104.2],
    "North Korea": [40.3, 127.5], "Indonesia": [-0.8, 113.9], "Laos": [19.9, 102.5],
    "Vietnam": [14.1, 108.3], "Cambodia": [12.6, 104.9], "Lebanon": [33.9, 35.9],
    "Libya": [26.3, 17.2], "Iran": [32.4, 53.7], "Iraq": [33.2, 43.7],
    "Kuwait": [29.3, 47.5], "Somalia": [5.2, 46.2], "Bosnia": [43.9, 17.7],
    "Sudan": [12.9, 30.2], "Afghanistan": [33.9, 67.7], "Yugoslavia": [44.0, 21.0],
    "Pakistan": [30.4, 69.3], "Yemen": [15.5, 48.5], "Syria": [34.8, 39.0],
    "Nigeria": [9.1, 8.7], "Venezuela": [6.4, -66.6], "Congo": [-4.0, 21.7],
    "Argentina": [-38.4, -63.6], "Uruguay": [-32.5, -55.7], "Paraguay": [-23.2, -58.1],
    "Greece": [39.0, 22.0], "Turkey": [38.9, 35.2], "Angola": [-11.2, 17.8]
}

TYPES = [
    {"name": "Golpe de Estado", "color_code": "#ff0000"},
    {"name": "Bombardeo", "color_code": "#ff5500"},
    {"name": "Ocupación Militar", "color_code": "#ff0055"},
    {"name": "Injerencia Política", "color_code": "#ffaa00"}
]

DATA = [
    # GOLPES DE ESTADO (Indirect)
    ("Bolivia", 1944, None, "Coup uprising overthrow Pres. Villaroel", "Golpe de Estado"),
    ("Bolivia", 1963, None, "Military coup ousts elected Pres. Paz Estenssoro", "Golpe de Estado"),
    ("Bolivia", 1971, None, "Military coup ousts Gen. Torres", "Golpe de Estado"),
    ("Brazil", 1964, None, "Military coup ousts elected Pres. Goulart", "Golpe de Estado"),
    ("Chile", 1973, None, "Coup ousts elected Pres. Allende", "Golpe de Estado"),
    ("Cuba", 1934, None, "U.S. sponsors coup by Col. Batista to oust Pres. Grau", "Golpe de Estado"),
    ("Dominican Rep", 1963, None, "Coup ousts elected Pres. Bosch", "Golpe de Estado"),
    ("El Salvador", 1961, None, "Coup ousts reformist civil-military junta", "Golpe de Estado"),
    ("El Salvador", 1979, None, "Coup ousts Gen. Humberto Romero", "Golpe de Estado"),
    ("Guatemala", 1954, None, "C.I.A.-organized armed force ousts Pres. Arbenz", "Golpe de Estado"),
    ("Guatemala", 1963, None, "U.S. supports coup vs elected Pres. Ydígoras", "Golpe de Estado"),
    ("Honduras", 1963, None, "Military coups ousts elected Pres. Morales", "Golpe de Estado"),
    ("Panama", 1941, None, "U.S supports coup ousting elected Pres. Arias", "Golpe de Estado"),
    ("Iran", 1953, None, "CIA-backed coup overthrows Prime Minister Mossadegh (Operation Ajax)", "Golpe de Estado"),
    ("Congo", 1960, None, "CIA complicit in the assassination of Patrice Lumumba", "Golpe de Estado"),
    ("Argentina", 1976, 1983, "U.S. backs military junta in Operation Condor", "Golpe de Estado"),
    ("Uruguay", 1973, 1985, "U.S. supports military dictatorship", "Golpe de Estado"),

    # OCUPACIONES / MILITAR DIRECTA
    ("Cuba", 1898, 1902, "Spanish-American War", "Ocupación Militar"),
    ("Dominican Rep", 1916, 1924, "U.S. occupation", "Ocupación Militar"),
    ("Dominican Rep", 1965, 1966, "U.S. invasion to prevent 'another Cuba' (Operation Power Pack)", "Ocupación Militar"),
    ("Grenada", 1983, None, "U.S. Armed Forces occupy island; oust government", "Ocupación Militar"),
    ("Haiti", 1915, 1934, "U.S. occupation", "Ocupación Militar"),
    ("Haiti", 1994, 1995, "Operation Uphold Democracy", "Ocupación Militar"),
    ("Mexico", 1914, None, "Veracruz occupied; US allows rebels to buy arms", "Ocupación Militar"),
    ("Nicaragua", 1912, 1925, "U.S. occupation", "Ocupación Militar"),
    ("Panama", 1989, None, "U.S. Armed Forces occupy nation", "Ocupación Militar"),

    # INJERENCIA
    ("Chile", 1989, 1990, "Aid to anti-Pinochet opposition", "Injerencia Política"),
    ("Guyana", 1953, None, "CIA aids strikes; Govt. is ousted", "Injerencia Política"),
    ("Nicaragua", 1981, 1990, "Contra war; then support for opposition in election", "Injerencia Política"),
    ("Greece", 1947, 1949, "Truman Doctrine supports anti-communist forces in Greek Civil War", "Injerencia Política"),
    ("Angola", 1975, 1992, "CIA supports UNITA rebels during civil war", "Injerencia Política"),

    # BOMBARDEOS
    ("China", 1945, 1946, "Bombing operations post WWII", "Bombardeo"),
    ("North Korea", 1950, 1953, "Korean War Bombings", "Bombardeo"),
    ("Indonesia", 1958, None, "CIA bombing missions", "Bombardeo"),
    ("Laos", 1964, 1973, "Secret War carpet bombing", "Bombardeo"),
    ("Vietnam", 1965, 1973, "Operation Rolling Thunder & others", "Bombardeo"),
    ("Cambodia", 1969, 1973, "Operation Menu bombings", "Bombardeo"),
    ("Lebanon", 1983, 1984, "Naval & aerial bombardment", "Bombardeo"),
    ("Libya", 1986, None, "Operation El Dorado Canyon", "Bombardeo"),
    ("Libya", 2011, None, "NATO intervention and airstrikes", "Bombardeo"),
    ("Iran", 1987, 1988, "Operation Praying Mantis / naval clashes", "Bombardeo"),
    ("Iraq", 1991, None, "Gulf War bombings", "Bombardeo"),
    ("Iraq", 1998, None, "Operation Desert Fox", "Bombardeo"),
    ("Iraq", 2003, 2011, "Invasion and occupation", "Bombardeo"),
    ("Somalia", 1993, None, "Operation Gothic Serpent airstrikes", "Bombardeo"),
    ("Bosnia", 1995, None, "Operation Deliberate Force", "Bombardeo"),
    ("Sudan", 1998, None, "Al-Shifa pharmaceutical factory bombing", "Bombardeo"),
    ("Afghanistan", 2001, 2021, "Operation Enduring Freedom & subsequent airstrikes", "Bombardeo"),
    ("Yugoslavia", 1999, None, "NATO Operation Allied Force", "Bombardeo"),
    ("Pakistan", 2004, 2018, "Drone strikes in North-West", "Bombardeo"),
    ("Yemen", 2002, 2025, "Drone strikes and coalition support", "Bombardeo"),
    ("Syria", 2014, 2025, "Airstrikes against ISIL and government forces", "Bombardeo"),
    ("Venezuela", 2026, None, "Recent operations (Hypothetical/Reported)", "Bombardeo")
]

async def seed():
    async with httpx.AsyncClient() as client:
        print("1. Insertando Tipos de Intervención...")
        type_ids = {}
        for t in TYPES:
            res = await client.post(f"{SUPABASE_URL}/rest/v1/intervention_types", headers=HEADERS, json=t)
            if res.status_code in [200, 201]:
                type_ids[t['name']] = res.json()[0]['id']
                print(f"  OK: {t['name']}")
            else:
                # Si ya existen, obtener sus IDs
                res_get = await client.get(f"{SUPABASE_URL}/rest/v1/intervention_types?name=eq.{t['name']}", headers=HEADERS)
                if res_get.status_code == 200 and len(res_get.json()) > 0:
                    type_ids[t['name']] = res_get.json()[0]['id']
        
        print("\n2. Insertando Intervenciones y Eventos...")
        for country, sy, ey, desc, t_name in DATA:
            coords = COUNTRY_COORDS.get(country, [0, 0])
            # Añadir un ligero ruido para que no se superpongan si hay múltiples en el mismo país
            import random
            lat = coords[0] + random.uniform(-0.5, 0.5)
            lng = coords[1] + random.uniform(-0.5, 0.5)
            
            payload = {
                "title": f"{t_name} en {country}",
                "country_name": country,
                "description": desc,
                "start_year": sy,
                "end_year": ey,
                "latitude": lat,
                "longitude": lng,
                "type_id": type_ids.get(t_name)
            }
            
            res = await client.post(f"{SUPABASE_URL}/rest/v1/interventions", headers=HEADERS, json=payload)
            if res.status_code in [200, 201]:
                print(f"  OK: {country} ({sy})")
            else:
                print(f"  Error {country}: {res.text}")

if __name__ == "__main__":
    asyncio.run(seed())
