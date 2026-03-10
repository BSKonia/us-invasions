import os
import httpx
import asyncio
import random
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

# Coordenadas aproximadas para países/regiones
COUNTRY_COORDS = {
    # Americas
    "Cuba": [21.5, -77.8], "Dominican Rep": [18.7, -70.2], "Grenada": [12.1, -61.7],
    "Guatemala": [15.8, -90.2], "Haiti": [19.0, -72.3], "Mexico": [23.6, -102.5],
    "Nicaragua": [12.9, -85.2], "Panama": [8.5, -80.8], "Bolivia": [-16.3, -68.1],
    "Brazil": [-14.2, -51.9], "Chile": [-35.7, -71.5], "El Salvador": [13.8, -88.9],
    "Guyana": [4.9, -58.9], "Honduras": [15.2, -86.2], "Colombia": [4.6, -74.1],
    "Argentina": [-38.4, -63.6], "Uruguay": [-32.5, -55.7], "Paraguay": [-23.2, -58.1],
    "Venezuela": [6.4, -66.6], "Peru": [-9.2, -75.0], "Puerto Rico": [18.2, -66.6],
    "Ecuador": [-1.8, -78.2], "Canada": [56.1, -106.3],
    "Falkland Islands": [-51.8, -59.0],
    # Asia
    "China": [35.9, 104.2], "North Korea": [40.3, 127.5], "South Korea": [35.9, 128.0],
    "Indonesia": [-0.8, 113.9], "Laos": [19.9, 102.5], "Vietnam": [14.1, 108.3],
    "Cambodia": [12.6, 104.9], "Philippines": [12.9, 121.8], "Japan": [36.2, 138.3],
    "Formosa": [23.7, 120.9], "Korea": [37.0, 127.5],
    # Middle East
    "Lebanon": [33.9, 35.9], "Libya": [26.3, 17.2], "Iran": [32.4, 53.7],
    "Iraq": [33.2, 43.7], "Kuwait": [29.3, 47.5], "Syria": [34.8, 39.0],
    "Yemen": [15.5, 48.5], "Oman": [21.5, 55.9], "Saudi Arabia": [23.9, 45.1],
    "Turkey": [38.9, 35.2], "Israel": [31.0, 34.8], "Egypt": [26.8, 30.8],
    # Africa
    "Somalia": [5.2, 46.2], "Sudan": [12.9, 30.2], "Angola": [-11.2, 17.8],
    "Congo": [-4.0, 21.7], "Liberia": [6.4, -9.4], "Nigeria": [9.1, 8.7],
    "Ghana": [7.9, -1.0], "Ivory Coast": [7.5, -5.5],
    "Portuguese West Africa": [-8.8, 13.2],
    "Niger": [17.6, 8.1],
    # Europe
    "Greece": [39.0, 22.0], "Yugoslavia": [44.0, 21.0], "Bosnia": [43.9, 17.7],
    "Croatia": [45.1, 15.2], "Russia": [61.5, 105.3], "Italy": [41.9, 12.5],
    "Albania": [41.2, 20.2], "Macedonia": [41.5, 21.7],
    # Central Asia / South Asia
    "Afghanistan": [33.9, 67.7], "Pakistan": [30.4, 69.3],
    # Pacific
    "Samoa": [-13.8, -172.0], "Fiji": [-17.7, 178.1], "Guam": [13.4, 144.8],
    "Hawaii": [19.9, -155.6], "Midway Island": [28.2, -177.4],
    "Marquesas Islands": [-9.0, -139.5],
    # North Africa
    "Tripoli": [32.9, 13.2], "Algiers": [36.7, 3.1],
    # Caribbean general
    "Caribbean": [17.0, -68.0],
    # Other
    "Sumatra": [0.6, 101.3],
    "Zaire": [-4.0, 21.7],
}

TYPES = [
    {"name": "Golpe de Estado", "color_code": "#ff0000"},
    {"name": "Bombardeo", "color_code": "#ff5500"},
    {"name": "Ocupación Militar", "color_code": "#ff0055"},
    {"name": "Injerencia Política", "color_code": "#ffaa00"},
    {"name": "Operación Naval", "color_code": "#0088ff"},
    {"name": "Operación Encubierta", "color_code": "#aa00ff"},
]

# Format: (country, start_year, end_year, description, type)
# Merged from:
#   1) Global Policy Forum list (1798-present)
#   2) Evergreen/Zoltan list (1890-2024)
#   3) Harvard DRCLAS list (direct & indirect interventions)
#   4) Previous seed data
# Deduplicated by country + approximate year range

DATA = [
    # ===================================================================
    # 1798-1849: EARLY REPUBLIC / NAVAL EXPANSION ERA
    # ===================================================================
    ("France", 1798, 1800, "Undeclared naval war (Quasi-War). Marines land in Puerto Plata.", "Operación Naval"),
    ("Tripoli", 1801, 1805, "First Barbary War against Tripoli (Libya).", "Operación Naval"),
    ("Mexico", 1806, None, "Military force enters Spanish territory at headwaters of the Rio Grande.", "Ocupación Militar"),
    ("Caribbean", 1806, 1810, "US naval vessels attack French and Spanish shipping in the Caribbean.", "Operación Naval"),
    ("Spain (West Florida)", 1810, None, "Troops invade and seize Western Florida, a Spanish possession.", "Ocupación Militar"),
    ("Spain (East Florida)", 1812, None, "Troops seize Amelia Island and adjacent territories in Spanish East Florida.", "Ocupación Militar"),
    ("Marquesas Islands", 1813, None, "Forces seize Nukahiva and establish first US naval base in the Pacific.", "Operación Naval"),
    ("Spain (East Florida)", 1814, None, "Troops seize Pensacola in Spanish East Florida.", "Ocupación Militar"),
    ("Caribbean", 1814, 1825, "US naval squadron engages French, British and Spanish shipping.", "Operación Naval"),
    ("Algiers", 1815, None, "Second Barbary War. US naval fleet under Capt. Decatur in North Africa.", "Operación Naval"),
    ("Spain (East Florida)", 1816, 1819, "Troops attack Nicholls' Fort, Amelia Island. Spain cedes East Florida.", "Ocupación Militar"),
    ("Cuba", 1822, 1825, "Marines land in numerous cities in Spanish Cuba and Puerto Rico.", "Ocupación Militar"),
    ("Greece", 1827, None, "Marines invade the Greek islands of Argentiere, Miconi and Andross.", "Ocupación Militar"),
    ("Falkland Islands", 1831, None, "US naval squadrons aggress the Falkland Islands.", "Operación Naval"),
    ("Sumatra", 1832, None, "US naval squadrons attack Qallah Battoo in the Dutch East Indies.", "Operación Naval"),
    ("Argentina", 1833, None, "Forces land in Buenos Aires and engage local combatants.", "Ocupación Militar"),
    ("Peru", 1835, 1836, "Troops dispatched twice for counter-insurgency operations.", "Ocupación Militar"),
    ("Mexico", 1836, None, "Troops assist Texas war for independence from Mexico.", "Injerencia Política"),
    ("Canada", 1837, None, "Naval incident on border leads to mobilization of force to invade Canada. War narrowly averted.", "Operación Naval"),
    ("Sumatra", 1838, None, "US naval forces sent to Sumatra for punitive expedition.", "Operación Naval"),
    ("Fiji", 1840, 1841, "Naval forces deployed, marines land.", "Operación Naval"),
    ("Samoa", 1841, None, "Naval forces deployed, marines land.", "Operación Naval"),
    ("Mexico", 1842, None, "Naval forces temporarily seize cities of Monterey and San Diego.", "Operación Naval"),
    ("China", 1843, None, "Marines land in Canton.", "Ocupación Militar"),
    ("Ivory Coast", 1843, None, "Marines land on the Ivory Coast.", "Ocupación Militar"),
    ("Mexico", 1846, 1848, "Full-scale Mexican-American War. Mexico cedes half its territory by Treaty of Guadalupe Hidalgo.", "Ocupación Militar"),
    ("Turkey", 1849, None, "Naval force dispatched to Smyrna in the Ottoman Empire.", "Operación Naval"),

    # ===================================================================
    # 1850-1899: EXPANSION & IMPERIAL ERA
    # ===================================================================
    ("Argentina", 1852, 1853, "Marines land in Buenos Aires.", "Ocupación Militar"),
    ("Nicaragua", 1854, None, "Navy bombards and destroys city of San Juan del Norte. Marines land and burn the city.", "Bombardeo"),
    ("Japan", 1854, None, "Commodore Perry and fleet deploy at Yokohama, forcing open of trade.", "Operación Naval"),
    ("Uruguay", 1855, None, "Marines land in Montevideo.", "Ocupación Militar"),
    ("Colombia", 1856, None, "Marines land in Panama region for counter-insurgency.", "Ocupación Militar"),
    ("China", 1856, None, "Marines deployed in Canton.", "Ocupación Militar"),
    ("Hawaii", 1856, None, "Naval forces seize islands of Jarvis, Baker and Howland.", "Operación Naval"),
    ("Nicaragua", 1857, None, "Marines land in Nicaragua.", "Ocupación Militar"),
    ("Uruguay", 1858, None, "Marines land in Montevideo.", "Ocupación Militar"),
    ("Fiji", 1858, None, "Marines land in Fiji.", "Ocupación Militar"),
    ("Paraguay", 1859, None, "Large naval force deployed against Paraguay.", "Operación Naval"),
    ("China", 1859, None, "Troops enter Shanghai.", "Ocupación Militar"),
    ("Mexico", 1859, None, "Military force enters northern Mexico.", "Ocupación Militar"),
    ("Portuguese West Africa", 1860, None, "Troops land at Kissembo.", "Ocupación Militar"),
    ("Colombia", 1860, None, "Troops and naval forces deployed in Panama region.", "Ocupación Militar"),
    ("Japan", 1863, None, "Troops land at Shimonoseki.", "Ocupación Militar"),
    ("Japan", 1864, None, "Troops land in Yedo (Tokyo).", "Ocupación Militar"),
    ("Colombia", 1865, None, "Marines land in Panama region.", "Ocupación Militar"),
    ("China", 1866, None, "Marines land in Newchwang.", "Ocupación Militar"),
    ("Nicaragua", 1867, None, "Marines land in Managua and Leon.", "Ocupación Militar"),
    ("Formosa", 1867, None, "Marines land on Formosa Island (Taiwan).", "Ocupación Militar"),
    ("Midway Island", 1867, None, "Naval forces seize Midway Island for a naval base.", "Operación Naval"),
    ("Japan", 1868, None, "Naval forces deployed at Osaka, Hiogo, Nagasaki, Yokohama and Negata.", "Operación Naval"),
    ("Uruguay", 1868, None, "Marines land at Montevideo.", "Ocupación Militar"),
    ("Colombia", 1870, None, "Marines land in Colombia.", "Ocupación Militar"),
    ("Korea", 1871, None, "US forces land in Korea.", "Ocupación Militar"),
    ("Colombia", 1873, None, "Marines land in Panama region.", "Ocupación Militar"),
    ("Hawaii", 1874, None, "Sailors and marines land in Hawaii.", "Ocupación Militar"),
    ("Mexico", 1876, None, "Army occupies Matamoros.", "Ocupación Militar"),
    ("Egypt", 1882, None, "Troops land in British Egypt.", "Ocupación Militar"),
    ("Colombia", 1885, None, "Troops land in Colon and Panama City.", "Ocupación Militar"),
    ("Samoa", 1885, None, "Naval force deployed in Samoa.", "Operación Naval"),
    ("Hawaii", 1887, None, "Navy gains right to build permanent base at Pearl Harbor.", "Operación Naval"),
    ("Haiti", 1888, None, "Troops land in Haiti.", "Ocupación Militar"),
    ("Samoa", 1888, None, "Marines land in Samoa.", "Ocupación Militar"),
    ("Samoa", 1889, None, "Naval clash with German forces in Samoa.", "Operación Naval"),
    ("Argentina", 1890, None, "US sailors land in Buenos Aires to protect interests.", "Ocupación Militar"),
    ("Chile", 1891, None, "US sailors land in Valparaiso. Marines clash with nationalist rebels.", "Ocupación Militar"),
    ("Haiti", 1891, None, "Marines land on US-claimed Navassa Island.", "Ocupación Militar"),
    ("Hawaii", 1893, None, "Marines and naval forces overthrow the Hawaiian monarchy.", "Golpe de Estado"),
    ("Nicaragua", 1894, None, "Marines land at Bluefields on the eastern coast.", "Ocupación Militar"),
    ("China", 1894, 1895, "Marines stationed at Tientsin and Beijing during Sino-Japanese War.", "Ocupación Militar"),
    ("Korea", 1894, 1896, "Marines land and remain in Seoul.", "Ocupación Militar"),
    ("Colombia", 1895, None, "Marines sent to Bocas del Toro.", "Ocupación Militar"),
    ("Nicaragua", 1896, None, "Marines land in port of Corinto.", "Ocupación Militar"),
    ("Nicaragua", 1898, None, "Marines land at port of San Juan del Sur.", "Ocupación Militar"),
    ("Guam", 1898, None, "Naval forces seize Guam from Spain. US holds island permanently.", "Ocupación Militar"),
    ("Cuba", 1898, 1902, "Spanish-American War. Naval and land forces seize Cuba from Spain.", "Ocupación Militar"),
    ("Puerto Rico", 1898, None, "Naval and land forces seize Puerto Rico from Spain permanently.", "Ocupación Militar"),
    ("Philippines", 1898, 1910, "Naval forces defeat Spanish fleet. US takes control; 600,000 Filipinos killed in counter-insurgency.", "Ocupación Militar"),
    ("Samoa", 1899, None, "Naval forces land in Samoa.", "Operación Naval"),
    ("Nicaragua", 1899, None, "Marines land at Bluefields.", "Ocupación Militar"),
    ("China", 1900, None, "US forces intervene in several Chinese cities during Boxer Rebellion.", "Ocupación Militar"),

    # ===================================================================
    # 1900-1945: IMPERIAL / GUNBOAT DIPLOMACY ERA
    # ===================================================================
    ("Colombia", 1901, None, "Marines land in Panama region.", "Ocupación Militar"),
    ("Colombia", 1902, None, "US forces land in Bocas de Toro.", "Ocupación Militar"),
    ("Panama", 1903, 1914, "US backs Panama independence from Colombia. Canal Zone annexed, canal opened 1914.", "Ocupación Militar"),
    ("Guam", 1903, None, "Navy begins development of permanent base at Apra Harbor.", "Operación Naval"),
    ("Honduras", 1903, None, "Marines go ashore at Puerto Cortez during revolution.", "Ocupación Militar"),
    ("Dominican Rep", 1903, 1904, "Marines land in Santo Domingo to protect US interests.", "Ocupación Militar"),
    ("Korea", 1904, 1905, "Marines land and stay in Seoul during Russo-Japanese War.", "Ocupación Militar"),
    ("Cuba", 1906, 1909, "Marines land and occupy. US builds major base at Guantanamo Bay.", "Ocupación Militar"),
    ("Nicaragua", 1907, None, "Troops seize major centers. Dollar Diplomacy protectorate established.", "Ocupación Militar"),
    ("Honduras", 1907, None, "Marines land in Trujillo, Ceiba, Puerto Cortez and other cities.", "Ocupación Militar"),
    ("Panama", 1908, None, "Marines land and carry out operations during election.", "Ocupación Militar"),
    ("Nicaragua", 1909, None, "US supports rebels against Zelaya government.", "Injerencia Política"),
    ("Nicaragua", 1910, None, "Marines land in Bluefields and Corinto.", "Ocupación Militar"),
    ("Honduras", 1911, None, "Marines intervene to protect US interests in civil war.", "Ocupación Militar"),
    ("China", 1911, 1941, "US builds military presence to 5,000 troops and 44 vessels patrolling coast and rivers.", "Ocupación Militar"),
    ("Cuba", 1912, None, "US sends army troops into combat in Havana.", "Ocupación Militar"),
    ("Panama", 1912, None, "Army troops intervene during heated election.", "Ocupación Militar"),
    ("Honduras", 1912, None, "Marines land to protect US economic interests.", "Ocupación Militar"),
    ("Nicaragua", 1912, 1933, "Marines intervene. 20-year occupation fighting Sandinista rebels.", "Ocupación Militar"),
    ("Mexico", 1913, None, "US Amb. H.L. Wilson organizes coup vs Pres. Madero. Marines land at Ciaris Estero.", "Golpe de Estado"),
    ("Dominican Rep", 1914, None, "Naval forces engage in battles in Santo Domingo.", "Operación Naval"),
    ("Mexico", 1914, 1918, "US forces seize and occupy Veracruz. Series of interventions against nationalists.", "Ocupación Militar"),
    ("Haiti", 1914, 1934, "Troops land, aerial bombardment. 19-year military occupation after revolts.", "Ocupación Militar"),
    ("Mexico", 1915, 1916, "Expeditionary force under Gen. Pershing penetrates hundreds of miles into Mexico. Over 11,000 troops.", "Ocupación Militar"),
    ("Dominican Rep", 1916, 1924, "Military intervention leading to 8-year occupation.", "Ocupación Militar"),
    ("Cuba", 1917, 1933, "Landing of naval forces. 15-year occupation.", "Ocupación Militar"),
    ("Panama", 1918, 1920, "Troops intervene, remain on police duty for over 2 years.", "Ocupación Militar"),
    ("Russia", 1918, 1922, "Naval forces and army troops fight battles during Bolshevik Revolution.", "Ocupación Militar"),
    ("Yugoslavia", 1919, None, "Marines intervene in Dalmatia for Italy against Serbs.", "Ocupación Militar"),
    ("Honduras", 1919, None, "Marines land during election campaign.", "Ocupación Militar"),
    ("Guatemala", 1920, None, "2-week intervention against unionists.", "Ocupación Militar"),
    ("Turkey", 1922, None, "Marines engaged in operations in Smyrna (Izmir) against Turkish nationalists.", "Ocupación Militar"),
    ("China", 1922, 1927, "Naval forces and troops deployed during nationalist revolt.", "Ocupación Militar"),
    ("Honduras", 1924, 1925, "Troops land twice during election strife.", "Ocupación Militar"),
    ("Panama", 1925, None, "Marines suppress general strike.", "Ocupación Militar"),
    ("China", 1927, 1934, "Marines and naval forces stationed throughout China.", "Ocupación Militar"),
    ("El Salvador", 1932, None, "Naval forces intervene during Farabundo Marti revolt.", "Operación Naval"),
    ("Cuba", 1933, None, "US abandons support for Pres. Machado.", "Injerencia Política"),
    ("Cuba", 1934, None, "US sponsors coup by Col. Batista to oust Pres. Grau.", "Golpe de Estado"),
    ("China", 1934, None, "Marines land in Foochow.", "Ocupación Militar"),

    # ===================================================================
    # 1946-1959: COLD WAR BEGINS
    # ===================================================================
    ("Iran", 1946, None, "Troops deployed in northern province. Soviets pressured to withdraw.", "Ocupación Militar"),
    ("Yugoslavia", 1946, None, "Naval response to shoot-down of US plane.", "Operación Naval"),
    ("Greece", 1947, 1949, "US directs far-right forces in civil war (Truman Doctrine).", "Injerencia Política"),
    ("Italy", 1948, None, "Heavy CIA involvement in national elections to prevent Communist victory.", "Injerencia Política"),
    ("China", 1948, 1949, "Major US army presence ~100,000 troops. Marines evacuate before Communist victory.", "Ocupación Militar"),
    ("Philippines", 1948, 1954, "CIA directs commando operations and secret war against Huk Rebellion.", "Operación Encubierta"),
    ("Puerto Rico", 1950, None, "Independence rebellion crushed in Ponce.", "Ocupación Militar"),
    ("North Korea", 1950, 1953, "Korean War. US/South Korea vs China/North Korea. Nuclear threats in 1950 and 1953.", "Ocupación Militar"),
    ("Iran", 1953, None, "CIA overthrows democracy, installs Shah (Operation Ajax).", "Golpe de Estado"),
    ("Guatemala", 1954, None, "CIA directs exile invasion after nationalization of United Fruit lands. Bombers based in Nicaragua.", "Golpe de Estado"),
    ("Vietnam", 1954, None, "Financial and materiel support for French colonial operations at Dien Bien Phu. Nuclear bombs offered.", "Injerencia Política"),
    ("Egypt", 1956, None, "Soviets told to keep out of Suez Crisis. Marines evacuate foreigners.", "Operación Naval"),
    ("Lebanon", 1958, None, "US marines and army (14,000 troops) land against rebels.", "Ocupación Militar"),
    ("Iraq", 1958, None, "Iraq warned against invading Kuwait. Nuclear threat.", "Injerencia Política"),
    ("Panama", 1958, None, "Flag protests erupt into Canal Zone confrontation.", "Ocupación Militar"),
    ("Cuba", 1959, None, "Marines land in Haiti (response to regional instability).", "Ocupación Militar"),

    # ===================================================================
    # 1960-1979: HEIGHT OF COLD WAR
    # ===================================================================
    ("Congo", 1960, None, "CIA-backed overthrow and assassination of PM Patrice Lumumba.", "Golpe de Estado"),
    ("Vietnam", 1960, 1975, "Full-scale war. Up to 500,000+ troops. 1 million+ killed.", "Ocupación Militar"),
    ("Cuba", 1961, None, "CIA-directed Bay of Pigs exile invasion fails.", "Operación Encubierta"),
    ("Cuba", 1962, None, "Nuclear threat and naval blockade during missile crisis. Near-war with Soviets.", "Operación Naval"),
    ("Laos", 1962, None, "CIA-backed military buildup during Pathet Lao guerrilla war.", "Operación Encubierta"),
    ("Iraq", 1963, None, "CIA organizes coup that kills president, brings Ba'ath Party to power with Saddam Hussein.", "Golpe de Estado"),
    ("Ecuador", 1963, None, "CIA backs military overthrow of President Jose Maria Velasco Ibarra.", "Golpe de Estado"),
    ("Panama", 1964, None, "Panamanians shot for urging canal's return. Clashes with US forces.", "Ocupación Militar"),
    ("Brazil", 1964, None, "CIA-backed military coup overthrows elected Pres. Goulart. Gen. Castello Branco takes power.", "Golpe de Estado"),
    ("Indonesia", 1965, None, "CIA-assisted army coup overthrows Pres. Sukarno. 1 million+ killed.", "Golpe de Estado"),
    ("Congo", 1965, None, "CIA-backed coup overthrows Pres. Kasavubu. Mobutu takes power.", "Golpe de Estado"),
    ("Dominican Rep", 1965, 1966, "23,000 troops land during election campaign (Operation Power Pack).", "Ocupación Militar"),
    ("Laos", 1965, 1973, "Bombing campaign lasting eight years. Carpet-bombing along Ho Chi Minh Trail.", "Bombardeo"),
    ("Ghana", 1966, None, "CIA-backed military coup ousts President Kwame Nkrumah.", "Golpe de Estado"),
    ("Guatemala", 1966, 1967, "Extensive counter-insurgency operation with Green Berets.", "Operación Encubierta"),
    ("Cambodia", 1969, 1975, "CIA supports coup vs Prince Sihanouk. Intensive bombing; up to 2 million killed.", "Bombardeo"),
    ("Oman", 1970, None, "US directs Iranian marine invasion for counter-insurgency.", "Operación Encubierta"),
    ("Laos", 1971, 1973, "US directs South Vietnamese invasion.", "Ocupación Militar"),
    ("Chile", 1973, None, "CIA-backed coup ousts elected Pres. Salvador Allende. Gen. Pinochet takes power.", "Golpe de Estado"),
    ("Cambodia", 1975, None, "Marines land, engage in combat. Gassing of captured ship Mayaguez.", "Ocupación Militar"),
    ("Angola", 1976, 1992, "Military and CIA operations supporting South African-backed UNITA rebels.", "Operación Encubierta"),
    ("Argentina", 1976, 1983, "US backs military junta in Operation Condor.", "Golpe de Estado"),
    ("Uruguay", 1973, 1985, "US supports military dictatorship.", "Golpe de Estado"),

    # ===================================================================
    # 1980-1989: LATE COLD WAR
    # ===================================================================
    ("Iran", 1980, None, "Raid to rescue embassy hostages. 8 troops die in helicopter crash.", "Ocupación Militar"),
    ("Libya", 1981, None, "Two Libyan jets shot down in naval maneuvers over Mediterranean.", "Operación Naval"),
    ("El Salvador", 1981, 1992, "CIA and Special Forces wage long counterinsurgency campaign.", "Operación Encubierta"),
    ("Nicaragua", 1981, 1990, "CIA directs Contra invasions, plants harbor mines against Sandinista govt.", "Operación Encubierta"),
    ("Lebanon", 1982, 1984, "Marines expel PLO. Navy shells Muslim rebels. 241 Marines killed in barracks bombing.", "Ocupación Militar"),
    ("Grenada", 1983, None, "Invasion topples leftist revolutionary government.", "Ocupación Militar"),
    ("Honduras", 1983, 1989, "Large military assistance program. Maneuvers build bases near Nicaragua.", "Injerencia Política"),
    ("Iran", 1984, None, "Two Iranian jets shot down over Persian Gulf.", "Operación Naval"),
    ("Libya", 1986, None, "Air strikes on Tripoli and Benghazi including Qaddafi's residence (Operation El Dorado Canyon).", "Bombardeo"),
    ("Bolivia", 1986, None, "Special Forces assist raids on cocaine-producing region.", "Operación Encubierta"),
    ("Iran", 1987, 1988, "Naval forces block Iranian shipping. Civilian airliner shot down (Operation Praying Mantis).", "Operación Naval"),
    ("Libya", 1989, None, "Two Libyan jets shot down over Gulf of Sidra.", "Operación Naval"),
    ("Philippines", 1989, None, "Air cover provided for government against coup attempt.", "Injerencia Política"),
    ("Panama", 1989, 1990, "27,000 troops invade. Noriega govt ousted. 2,000+ killed.", "Ocupación Militar"),
    ("Chile", 1989, 1990, "Aid to anti-Pinochet opposition.", "Injerencia Política"),

    # ===================================================================
    # 1990-1999: POST-COLD WAR / NEW WORLD ORDER
    # ===================================================================
    ("Liberia", 1990, None, "Troops deployed to evacuate foreigners during civil war.", "Ocupación Militar"),
    ("Saudi Arabia", 1990, 1991, "540,000 troops stationed. Also deployed in Oman, Qatar, Bahrain, UAE, Israel.", "Ocupación Militar"),
    ("Iraq", 1990, 1991, "Gulf War. Blockade, air strikes, ground invasion. 200,000+ killed.", "Bombardeo"),
    ("Kuwait", 1991, None, "Kuwait royal family restored to throne after Iraqi occupation.", "Ocupación Militar"),
    ("Iraq", 1991, 2003, "No-fly zones over Kurdish north and Shi'a south. Constant air strikes and sanctions.", "Bombardeo"),
    ("Haiti", 1991, None, "CIA-backed military coup ousts President Aristide.", "Golpe de Estado"),
    ("Somalia", 1992, 1994, "US-led UN occupation during civil war. Raids in Mogadishu (Black Hawk Down).", "Ocupación Militar"),
    ("Yugoslavia", 1992, 1994, "Major role in NATO blockade of Serbia and Montenegro.", "Operación Naval"),
    ("Bosnia", 1993, 1995, "No-fly zone. Downed jets, bombed Serbs (Operation Deliberate Force).", "Bombardeo"),
    ("Haiti", 1994, 1996, "Troops depose military rulers. Restore President Aristide.", "Ocupación Militar"),
    ("Croatia", 1995, None, "Krajina Serb airfields attacked.", "Bombardeo"),
    ("Zaire", 1996, 1997, "Marines involved in operations in eastern Congo.", "Ocupación Militar"),
    ("Liberia", 1997, None, "Troops deployed. Soldiers under fire during evacuation.", "Ocupación Militar"),
    ("Albania", 1997, None, "Soldiers under fire during evacuation of foreigners.", "Ocupación Militar"),
    ("Sudan", 1998, None, "Air strikes destroy country's major pharmaceutical plant (Al-Shifa).", "Bombardeo"),
    ("Afghanistan", 1998, None, "Missile attack on former CIA training camps used by Al Qaeda.", "Bombardeo"),
    ("Iraq", 1998, None, "Four days of intensive air strikes (Operation Desert Fox).", "Bombardeo"),
    ("Yugoslavia", 1999, None, "Heavy NATO air strikes after Serbia declines to withdraw from Kosovo.", "Bombardeo"),

    # ===================================================================
    # 2000-PRESENT: WAR ON TERROR ERA
    # ===================================================================
    ("Yemen", 2000, None, "USS Cole bombed by Al Qaeda in port of Aden.", "Operación Naval"),
    ("Macedonia", 2001, None, "NATO troops disarm and relocate Kosovo Albanian rebels.", "Ocupación Militar"),
    ("Afghanistan", 2001, 2021, "Invasion to overthrow Taliban, hunt Al Qaeda. 30,000+ troops, private contractors.", "Ocupación Militar"),
    ("Yemen", 2002, None, "Drone missile attack on Al Qaeda targets, including US citizen.", "Bombardeo"),
    ("Philippines", 2002, None, "Training mission evolves into combat missions in Mindanao vs Abu Sayyaf.", "Operación Encubierta"),
    ("Colombia", 2003, 2022, "Special Forces protect oil pipeline and back Colombian military vs rebels.", "Operación Encubierta"),
    ("Iraq", 2003, 2011, "Invasion ousts Saddam Hussein. 250,000+ personnel. Battle Sunni & Shi'a insurgencies.", "Ocupación Militar"),
    ("Liberia", 2003, None, "Troops in peacekeeping force as rebels expel leader.", "Ocupación Militar"),
    ("Haiti", 2004, 2005, "Marines and Army land after CIA-backed forces oust President Aristide.", "Golpe de Estado"),
    ("Pakistan", 2005, 2021, "CIA drone strikes, air strikes, Special Forces raids. Hundreds of civilians killed.", "Bombardeo"),
    ("Somalia", 2006, None, "Special Forces advise Ethiopian invasion. AC-130 strikes, cruise missiles vs Al Shabab.", "Bombardeo"),
    ("Syria", 2008, None, "Special Forces helicopter raid near Iraq border kills 8 civilians.", "Operación Encubierta"),
    ("Yemen", 2009, 2021, "Cruise missile attacks on Al Qaeda. Backing Saudi-Yemeni attacks on Houthi rebels.", "Bombardeo"),
    ("Libya", 2011, None, "NATO air strikes and missile attacks vs Qaddafi government. Special Forces vs Islamist rebels.", "Bombardeo"),
    ("Syria", 2014, 2025, "Air strikes and Special Forces vs Islamic State. Bombing of alleged chemical weapons sites.", "Bombardeo"),
    ("Iraq", 2014, None, "Air strikes and Special Forces vs Islamic State. Strikes on pro-Iran militia 2019-20.", "Bombardeo"),
    ("Niger", 2017, None, "Special Forces combat Islamist insurgents, fly drones.", "Operación Encubierta"),
    ("Saudi Arabia", 2019, 2020, "Troop mobilization against Iran after drone attacks on Saudi oil infrastructure.", "Ocupación Militar"),
    ("Yemen", 2023, None, "US-UK attacks on Houthi vessels and sites after attacks on Red Sea shipping.", "Bombardeo"),
    ("Israel", 2024, None, "US, UK, Jordanian forces shoot down Iranian missiles/drones retaliating for Israeli bombing.", "Operación Naval"),

    # ===================================================================
    # ADDITIONAL INDIRECT INTERVENTIONS (Harvard DRCLAS)
    # ===================================================================
    ("Bolivia", 1944, None, "Coup uprising overthrows Pres. Villaroel.", "Golpe de Estado"),
    ("Bolivia", 1963, None, "Military coup ousts elected Pres. Paz Estenssoro.", "Golpe de Estado"),
    ("Bolivia", 1971, None, "Military coup ousts Gen. Torres.", "Golpe de Estado"),
    ("Dominican Rep", 1914, None, "US secures ouster of Gen. Jose Bordas.", "Injerencia Política"),
    ("Dominican Rep", 1961, None, "Assassination of Pres. Trujillo.", "Golpe de Estado"),
    ("Dominican Rep", 1963, None, "Coup ousts elected Pres. Bosch.", "Golpe de Estado"),
    ("El Salvador", 1961, None, "Coup ousts reformist civil-military junta.", "Golpe de Estado"),
    ("El Salvador", 1979, None, "Coup ousts Gen. Humberto Romero.", "Golpe de Estado"),
    ("El Salvador", 1980, None, "US creates and aids new Christian Democrat junta.", "Injerencia Política"),
    ("Guatemala", 1963, None, "US supports coup vs elected Pres. Ydigoras.", "Golpe de Estado"),
    ("Guatemala", 1982, None, "US supports coup vs Gen. Lucas Garcia.", "Golpe de Estado"),
    ("Guatemala", 1983, None, "US supports coup vs Gen. Rios Montt.", "Golpe de Estado"),
    ("Guyana", 1953, None, "CIA aids strikes; Government is ousted.", "Operación Encubierta"),
    ("Honduras", 1963, None, "Military coup ousts elected Pres. Morales.", "Golpe de Estado"),
    ("Nicaragua", 1979, None, "US pressures Pres. Somoza to leave.", "Injerencia Política"),
    ("Panama", 1941, None, "US supports coup ousting elected Pres. Arias.", "Golpe de Estado"),
    ("Panama", 1949, None, "US supports coup ousting constitutional govt of VP Chanis.", "Golpe de Estado"),
    ("Panama", 1969, None, "US supports coup by Gen. Torrijos.", "Golpe de Estado"),
]

async def seed():
    async with httpx.AsyncClient(timeout=30.0) as client:
        # =====================
        # STEP 1: Upsert types
        # =====================
        print("=" * 60)
        print("PASO 1: Insertando Tipos de Intervención...")
        print("=" * 60)
        type_ids = {}
        for t in TYPES:
            res = await client.post(
                f"{SUPABASE_URL}/rest/v1/intervention_types",
                headers=HEADERS, json=t
            )
            if res.status_code in [200, 201]:
                type_ids[t['name']] = res.json()[0]['id']
                print(f"  [NEW] {t['name']}")
            else:
                res_get = await client.get(
                    f"{SUPABASE_URL}/rest/v1/intervention_types?name=eq.{t['name']}",
                    headers=HEADERS
                )
                if res_get.status_code == 200 and len(res_get.json()) > 0:
                    type_ids[t['name']] = res_get.json()[0]['id']
                    print(f"  [EXISTS] {t['name']}")

        # =====================
        # STEP 2: Get existing interventions to avoid duplicates
        # =====================
        print("\n" + "=" * 60)
        print("PASO 2: Obteniendo intervenciones existentes...")
        print("=" * 60)
        existing = set()
        res = await client.get(
            f"{SUPABASE_URL}/rest/v1/interventions?select=country_name,start_year",
            headers=HEADERS
        )
        if res.status_code == 200:
            for item in res.json():
                key = (item['country_name'], item['start_year'])
                existing.add(key)
            print(f"  Encontradas {len(existing)} intervenciones existentes.")

        # =====================
        # STEP 3: Insert new interventions
        # =====================
        print("\n" + "=" * 60)
        print("PASO 3: Insertando nuevas intervenciones...")
        print("=" * 60)
        inserted = 0
        skipped = 0
        errors = 0

        for country, sy, ey, desc, t_name in DATA:
            key = (country, sy)
            if key in existing:
                skipped += 1
                continue

            coords = COUNTRY_COORDS.get(country, [0, 0])
            lat = coords[0] + random.uniform(-0.3, 0.3)
            lng = coords[1] + random.uniform(-0.3, 0.3)

            payload = {
                "title": f"{t_name} en {country} ({sy})",
                "country_name": country,
                "description": desc,
                "start_year": sy,
                "end_year": ey,
                "latitude": lat,
                "longitude": lng,
                "type_id": type_ids.get(t_name)
            }

            res = await client.post(
                f"{SUPABASE_URL}/rest/v1/interventions",
                headers=HEADERS, json=payload
            )
            if res.status_code in [200, 201]:
                inserted += 1
                print(f"  [OK] {country} ({sy}) - {t_name}")
            else:
                errors += 1
                print(f"  [ERROR] {country} ({sy}): {res.text[:100]}")

            # Mark as existing to avoid duplicates within the DATA list itself
            existing.add(key)

        print("\n" + "=" * 60)
        print(f"RESUMEN: {inserted} insertadas, {skipped} ya existían, {errors} errores")
        print("=" * 60)

if __name__ == "__main__":
    asyncio.run(seed())
