-- ============================================================
-- MILITARY BASES SEED: Part 4 - Americas, Caribbean & remaining global
-- Sources: David Vine (American University), GlobalSecurity.org, GAO reports
-- ============================================================

DO $$
BEGIN

-- ========== CUBA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Naval Station Guantánamo Bay', 'Cuba', 'Oldest US overseas naval base. Leased from Cuba since 1903 for $4,085/year (checks uncashed since 1959). Houses the controversial detention facility for War on Terror detainees.', 19.9022, -75.0960, 'Major', 'Navy/Joint', 'Active', 1903
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Naval Station Guantánamo Bay' AND country_name = 'Cuba');

-- ========== PUERTO RICO (US Territory) ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Fort Buchanan', 'Puerto Rico', 'US Army garrison in San Juan. Only remaining active US military installation in Puerto Rico after the closure of Roosevelt Roads and Vieques.', 18.4167, -66.1167, 'Medium', 'Army', 'Active', 1923
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Fort Buchanan' AND country_name = 'Puerto Rico');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Santiago (Salinas)', 'Puerto Rico', 'Puerto Rico National Guard training site. Used for joint exercises and counter-narcotics operations in the Caribbean.', 18.0039, -66.2822, 'Small', 'Army/National Guard', 'Active', 1940
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Santiago (Salinas)' AND country_name = 'Puerto Rico');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Roosevelt Roads (former)', 'Puerto Rico', 'Former major US Navy base in eastern Puerto Rico. Was the largest US naval installation in the world. Closed in 2004 after Vieques protests.', 18.2353, -65.6436, 'Major', 'Navy', 'Closed', 1943
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Roosevelt Roads (former)' AND country_name = 'Puerto Rico');

-- ========== HONDURAS ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Soto Cano Air Base (Palmerola)', 'Honduras', 'US Joint Task Force-Bravo headquarters. Supports counter-narcotics, humanitarian, and disaster relief operations in Central America. About 500 US personnel.', 14.3822, -87.6212, 'Medium', 'Air Force/Army', 'Active', 1982
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Soto Cano Air Base (Palmerola)' AND country_name = 'Honduras');

-- ========== EL SALVADOR ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Comalapa International Airport (CSL)', 'El Salvador', 'US Cooperative Security Location at El Salvador international airport. Supports counter-narcotics surveillance flights over Central America and the eastern Pacific.', 13.4409, -89.0557, 'Lily-pad', 'Air Force', 'Active', 2000
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Comalapa International Airport (CSL)' AND country_name = 'El Salvador');

-- ========== COLOMBIA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Palanquero Air Base', 'Colombia', 'Colombian Air Force base with US access under bilateral agreement. Supports counter-narcotics and ISR operations in South America.', 5.4836, -74.6574, 'Access Agreement', 'Air Force', 'Active', 2009
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Palanquero Air Base' AND country_name = 'Colombia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Tolemaida Military Base', 'Colombia', 'Major Colombian Army base with US Special Forces advisory presence. Counter-narcotics and counter-insurgency training.', 4.2500, -74.6500, 'Access Agreement', 'Army/SOF', 'Active', 2009
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Tolemaida Military Base' AND country_name = 'Colombia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Larandia Military Base', 'Colombia', 'Colombian Army base with US counter-narcotics cooperation. Located in Caquetá, a historic FARC stronghold.', 1.5833, -75.5167, 'Access Agreement', 'Army', 'Active', 2009
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Larandia Military Base' AND country_name = 'Colombia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Apiay Air Base', 'Colombia', 'Colombian Air Force base near Villavicencio with US counter-narcotics ISR cooperation.', 4.0758, -73.5627, 'Access Agreement', 'Air Force', 'Active', 2009
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Apiay Air Base' AND country_name = 'Colombia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Bahía Málaga Naval Base', 'Colombia', 'Colombian Navy Pacific coast base with US counter-narcotics cooperation. Supports maritime interdiction operations.', 3.9333, -77.3500, 'Access Agreement', 'Navy', 'Active', 2009
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Bahía Málaga Naval Base' AND country_name = 'Colombia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Cartagena Naval Base', 'Colombia', 'Colombian Navy base on the Caribbean coast with US counter-narcotics cooperation and UNITAS exercise participation.', 10.3932, -75.5142, 'Access Agreement', 'Navy', 'Active', 2009
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Cartagena Naval Base' AND country_name = 'Colombia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Malambo Air Base', 'Colombia', 'Colombian Air Force base near Barranquilla with US access for counter-narcotics and ISR operations.', 10.8961, -74.7808, 'Access Agreement', 'Air Force', 'Active', 2009
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Malambo Air Base' AND country_name = 'Colombia');

-- ========== PERU ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Iquitos Cooperation Center', 'Peru', 'US counter-narcotics cooperation facility in the Amazon region. Supports DEA/military counter-narcotics operations.', -3.7489, -73.2516, 'Lily-pad', 'Army/DEA', 'Active', 2006
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Iquitos Cooperation Center' AND country_name = 'Peru');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Santa Lucía Counter-Narcotics Base', 'Peru', 'Peruvian military base in the VRAEM coca-growing region with US Special Forces advisory presence and counter-narcotics support.', -12.0500, -76.8500, 'Lily-pad', 'Army/SOF', 'Active', 2012
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Santa Lucía Counter-Narcotics Base' AND country_name = 'Peru');

-- ========== ECUADOR ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Manta Air Base (former)', 'Ecuador', 'Former US Air Force Forward Operating Location for counter-narcotics. Ecuador refused to renew lease in 2009 under President Correa.', -0.9461, -80.6785, 'Medium', 'Air Force', 'Closed', 1999
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Manta Air Base (former)' AND country_name = 'Ecuador');

-- ========== ARUBA & CURAÇAO (Netherlands Caribbean) ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Forward Operating Location Aruba (Queen Beatrix Airport)', 'Aruba', 'US counter-narcotics Forward Operating Location. Supports P-3 and P-8 maritime patrol aircraft monitoring Caribbean and South American drug trafficking routes.', 12.5014, -70.0152, 'Lily-pad', 'Air Force', 'Active', 2000
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Forward Operating Location Aruba (Queen Beatrix Airport)' AND country_name = 'Aruba');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Forward Operating Location Curaçao (Hato Airport)', 'Curaçao', 'US counter-narcotics Forward Operating Location. Supports aerial surveillance of drug trafficking in the Caribbean and eastern Pacific corridor.', 12.1889, -68.9598, 'Lily-pad', 'Air Force', 'Active', 2000
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Forward Operating Location Curaçao (Hato Airport)' AND country_name = 'Curaçao');

-- ========== GUYANA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Stephenson (Timehri)', 'Guyana', 'Guyana Defence Force facility with periodic US military cooperation for New Horizons humanitarian exercises.', 6.5000, -58.2542, 'Lily-pad', 'Army', 'Active', 2010
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Stephenson (Timehri)' AND country_name = 'Guyana');

-- ========== TRINIDAD & TOBAGO ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Chaguaramas (former US Navy base)', 'Trinidad and Tobago', 'Former WWII-era US naval base. Now returned to Trinidad. Small periodic US military cooperation for counter-narcotics.', 10.6822, -61.6267, 'Lily-pad', 'Navy', 'Active', 1941
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Chaguaramas (former US Navy base)' AND country_name = 'Trinidad and Tobago');

-- ========== BAHAMAS ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'AUTEC (Andros Island)', 'Bahamas', 'Atlantic Undersea Test and Evaluation Center. US Navy deep-water facility for submarine and weapons testing. The world premier underwater testing range.', 24.4000, -77.7667, 'Major', 'Navy', 'Active', 1966
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'AUTEC (Andros Island)' AND country_name = 'Bahamas');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'NSWC Exuma Sound', 'Bahamas', 'Naval weapons testing facility in the Exuma Sound. Supports underwater acoustic and weapons research.', 23.7800, -76.1000, 'Small', 'Navy', 'Active', 1966
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'NSWC Exuma Sound' AND country_name = 'Bahamas');

-- ========== US VIRGIN ISLANDS ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Naval Station St. Croix (former)', 'US Virgin Islands', 'Former US Navy presence on St. Croix. Now supports limited military logistics and Coast Guard operations.', 17.7500, -64.7500, 'Lily-pad', 'Navy/Coast Guard', 'Reduced', 1941
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Naval Station St. Croix (former)' AND country_name = 'US Virgin Islands');

-- ========== PANAMA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Howard Air Force Base (former)', 'Panama', 'Former major US Air Force base in the Panama Canal Zone. Hub for Central American operations during the Cold War. Returned to Panama in 1999.', 8.9147, -79.5997, 'Major', 'Air Force', 'Closed', 1942
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Howard Air Force Base (former)' AND country_name = 'Panama');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Fort Sherman (former)', 'Panama', 'Former US Army jungle warfare training center in the Canal Zone. Trained Special Forces for decades. Returned to Panama in 1999.', 9.3571, -79.9518, 'Medium', 'Army', 'Closed', 1911
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Fort Sherman (former)' AND country_name = 'Panama');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Fort Clayton (former, now Ciudad del Saber)', 'Panama', 'Former US Army headquarters in the Canal Zone. Now converted to the City of Knowledge education center. Returned in 1999.', 9.0069, -79.5764, 'Major', 'Army', 'Closed', 1932
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Fort Clayton (former, now Ciudad del Saber)' AND country_name = 'Panama');

-- ========== CANADA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'NORAD Cheyenne Mountain Complex', 'United States', 'Joint US-Canadian NORAD headquarters inside Cheyenne Mountain, Colorado. Monitors aerospace and maritime threats to North America.', 38.7445, -104.8460, 'Major', 'Joint/NORAD', 'Active', 1966
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'NORAD Cheyenne Mountain Complex' AND country_name = 'United States');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Thule Air Base', 'Greenland', 'US Space Force base in northwestern Greenland (Danish territory). Hosts ballistic missile early warning radar. Northernmost US military installation.', 76.5312, -68.7031, 'Major', 'Space Force', 'Active', 1951
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Thule Air Base' AND country_name = 'Greenland');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'CFB Goose Bay', 'Canada', 'Canadian Forces base with US access for fighter training and North American defense. Strategic for transatlantic aviation routes.', 53.3192, -60.4258, 'Access Agreement', 'Air Force', 'Active', 1941
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'CFB Goose Bay' AND country_name = 'Canada');

-- ========== BERMUDA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Naval Air Station Bermuda (former)', 'Bermuda', 'Former US Navy facility. Closed in 1995 under Base Realignment and Closure. Was critical for Atlantic ASW patrols during the Cold War.', 32.3640, -64.6770, 'Medium', 'Navy', 'Closed', 1941
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Naval Air Station Bermuda (former)' AND country_name = 'Bermuda');

-- ========== ADDITIONAL EUROPE (remaining Nordic sites, etc.) ==========

-- Norway additional DCA sites
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Ørland Air Station', 'Norway', 'Norwegian Air Force main fighter base with US access under SDCA. Houses Norwegian F-35s.', 63.6989, 9.6039, 'Access Agreement', 'Air Force', 'Active', 2022
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Ørland Air Station' AND country_name = 'Norway');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Haakonsvern Naval Base', 'Norway', 'Main Norwegian Navy base near Bergen with US access under SDCA. Supports NATO maritime operations in the Norwegian Sea.', 60.3233, 5.1925, 'Access Agreement', 'Navy', 'Active', 2022
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Haakonsvern Naval Base' AND country_name = 'Norway');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Bardufoss Air Station', 'Norway', 'Norwegian Air Force base in northern Norway with US Marine Corps pre-positioned equipment caves nearby.', 69.0581, 18.5394, 'Access Agreement', 'Marines/Air Force', 'Active', 2022
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Bardufoss Air Station' AND country_name = 'Norway');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Andøya Air Station', 'Norway', 'Norwegian Air Force base with US access. Strategic for maritime patrol and Arctic surveillance.', 69.2925, 16.1442, 'Access Agreement', 'Air Force', 'Active', 2022
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Andøya Air Station' AND country_name = 'Norway');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Tromsø Naval Base', 'Norway', 'Norwegian Navy facility in Tromsø with US access under SDCA for Arctic operations.', 69.6492, 18.9553, 'Access Agreement', 'Navy', 'Active', 2022
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Tromsø Naval Base' AND country_name = 'Norway');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Bodø Air Station', 'Norway', 'Former Norwegian fighter base, now used for maritime patrol with US access.', 67.2685, 14.3653, 'Access Agreement', 'Air Force', 'Active', 2022
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Bodø Air Station' AND country_name = 'Norway');

-- Sweden additional DCA sites
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Visby Airport (Gotland)', 'Sweden', 'Swedish military airfield on Gotland island with US access under 2024 DCA. Strategic Baltic Sea location.', 57.6628, 18.3464, 'Access Agreement', 'Air Force', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Visby Airport (Gotland)' AND country_name = 'Sweden');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Berga Naval Base', 'Sweden', 'Swedish Navy base south of Stockholm with US access under 2024 DCA. Supports Baltic naval operations.', 59.1467, 18.2467, 'Access Agreement', 'Navy', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Berga Naval Base' AND country_name = 'Sweden');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Halmstad Garrison', 'Sweden', 'Swedish Army base with US access under 2024 DCA. Air defense training center.', 56.6850, 12.8375, 'Access Agreement', 'Army', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Halmstad Garrison' AND country_name = 'Sweden');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Uppsala-Ärna Air Base', 'Sweden', 'Swedish Air Force transport base with US access under 2024 DCA.', 59.8964, 17.5922, 'Access Agreement', 'Air Force', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Uppsala-Ärna Air Base' AND country_name = 'Sweden');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Sälen/Hagfors Area', 'Sweden', 'Swedish military training area with US access under 2024 DCA for winter warfare exercises.', 61.1564, 13.2656, 'Access Agreement', 'Army', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Sälen/Hagfors Area' AND country_name = 'Sweden');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Ronneby Air Base', 'Sweden', 'Swedish Air Force base with US access under 2024 DCA. Located in southern Sweden.', 56.2672, 15.2650, 'Access Agreement', 'Air Force', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Ronneby Air Base' AND country_name = 'Sweden');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Skövde Garrison', 'Sweden', 'Swedish Army garrison with US access under 2024 DCA. Supports armored and mechanized training.', 58.4108, 13.8256, 'Access Agreement', 'Army', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Skövde Garrison' AND country_name = 'Sweden');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Karlsborg Fortress', 'Sweden', 'Swedish special forces base with US access under 2024 DCA.', 58.5361, 14.5256, 'Access Agreement', 'SOF', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Karlsborg Fortress' AND country_name = 'Sweden');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Malmen Air Base (Linköping)', 'Sweden', 'Swedish Air Force test center with US access under 2024 DCA. Saab/Gripen manufacturing nearby.', 58.4264, 15.5256, 'Access Agreement', 'Air Force', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Malmen Air Base (Linköping)' AND country_name = 'Sweden');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Boden Garrison', 'Sweden', 'Swedish Army garrison in northern Sweden with US access under 2024 DCA. Arctic warfare capability.', 66.0003, 21.6886, 'Access Agreement', 'Army', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Boden Garrison' AND country_name = 'Sweden');

-- Finland additional DCA sites
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kuopio-Rissala Air Base', 'Finland', 'Finnish Air Force base with US access under 2024 DCA. Hosts F/A-18 Hornet and future F-35 operations.', 63.0453, 27.7978, 'Access Agreement', 'Air Force', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kuopio-Rissala Air Base' AND country_name = 'Finland');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kajaani Garrison', 'Finland', 'Finnish Army base with US access under 2024 DCA. Training in subarctic conditions.', 64.2167, 27.7333, 'Access Agreement', 'Army', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kajaani Garrison' AND country_name = 'Finland');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Tampere-Pirkkala Air Base', 'Finland', 'Finnish Air Force base with US access under 2024 DCA.', 61.4144, 23.6044, 'Access Agreement', 'Air Force', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Tampere-Pirkkala Air Base' AND country_name = 'Finland');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Niinisalo Training Area', 'Finland', 'Finnish Army training area with US access under 2024 DCA. Major live-fire range.', 61.8333, 22.7833, 'Access Agreement', 'Army', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Niinisalo Training Area' AND country_name = 'Finland');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Turku Archipelago Naval Base', 'Finland', 'Finnish Navy base with US access under 2024 DCA. Supports Baltic maritime operations.', 60.4518, 22.2666, 'Access Agreement', 'Navy', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Turku Archipelago Naval Base' AND country_name = 'Finland');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Upinniemi Naval Base', 'Finland', 'Finnish Navy headquarters with US access under 2024 DCA.', 60.0833, 24.3333, 'Access Agreement', 'Navy', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Upinniemi Naval Base' AND country_name = 'Finland');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Jokkmokk / Boden Arctic Range', 'Finland', 'Finnish Arctic training areas with US access. Extreme cold weather training in Lapland.', 66.6064, 19.8286, 'Access Agreement', 'Army', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Jokkmokk / Boden Arctic Range' AND country_name = 'Finland');

-- ========== ADDITIONAL ASIA-PACIFIC ==========

-- Japan additional
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp McTureous', 'Japan', 'Small Marine Corps installation on Okinawa supporting logistics and housing.', 26.3300, 127.8200, 'Small', 'Marines', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp McTureous' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Lester', 'Japan', 'Former Marine Corps installation on Okinawa. Mostly returned to Japan, with some facilities remaining.', 26.3300, 127.7600, 'Small', 'Marines', 'Reduced', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Lester' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Northern Training Area (Okinawa)', 'Japan', 'Jungle warfare training area in northern Okinawa. Partially returned to Japan in 2016.', 26.5900, 128.0300, 'Medium', 'Marines', 'Reduced', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Northern Training Area (Okinawa)' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Ie Shima Auxiliary Airfield', 'Japan', 'US Marine Corps training airfield on Ie Shima island off Okinawa. Short takeoff/landing practice.', 26.7250, 127.7639, 'Small', 'Marines', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Ie Shima Auxiliary Airfield' AND country_name = 'Japan');

-- Vietnam War era bases (historical, all closed)
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Korat Royal Thai Air Force Base', 'Thailand', 'Major US Air Force base during the Vietnam War. F-105 Thunderchiefs flew bombing missions over North Vietnam. Returned to Thailand 1976.', 14.9350, 102.0781, 'Major', 'Air Force', 'Closed', 1962
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Korat Royal Thai Air Force Base' AND country_name = 'Thailand');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Takhli Royal Thai Air Force Base', 'Thailand', 'US Air Force base during Vietnam War. F-105 and F-4 operations over North Vietnam and Laos. Returned to Thailand 1976.', 15.2772, 100.2961, 'Major', 'Air Force', 'Closed', 1961
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Takhli Royal Thai Air Force Base' AND country_name = 'Thailand');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Udorn Royal Thai Air Force Base', 'Thailand', 'Major US/CIA air base during Vietnam and Laos wars. Home to Air America and combat fighter wings. Returned 1976.', 17.3864, 102.7881, 'Major', 'Air Force/CIA', 'Closed', 1964
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Udorn Royal Thai Air Force Base' AND country_name = 'Thailand');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Nakhon Phanom Royal Thai Navy Base', 'Thailand', 'US Air Force base during Vietnam War. Task Force Alpha electronic warfare operations. Returned 1976.', 17.3833, 104.6428, 'Medium', 'Air Force', 'Closed', 1966
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Nakhon Phanom Royal Thai Navy Base' AND country_name = 'Thailand');

-- Additional Pacific
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Tinian (Pacific Airfield)', 'Northern Mariana Islands', 'WWII-era airfield being rebuilt for US military use. The B-29 Enola Gay launched the Hiroshima bomb from here. Divert airfield for Pacific operations.', 14.9990, 145.6190, 'Small', 'Air Force', 'Active', 2019
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Tinian (Pacific Airfield)' AND country_name = 'Northern Mariana Islands');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Saipan International Airport', 'Northern Mariana Islands', 'US military divert airfield in the Marianas chain. Strategic for Pacific contingencies.', 15.1190, 145.7294, 'Small', 'Air Force', 'Active', 2019
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Saipan International Airport' AND country_name = 'Northern Mariana Islands');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Yap Compact Access', 'Micronesia', 'US military access rights in Yap State under the Compact of Free Association with the Federated States of Micronesia.', 9.5144, 138.1292, 'Lily-pad', 'Joint', 'Active', 1986
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Yap Compact Access' AND country_name = 'Micronesia');

-- ========== ADDITIONAL MIDDLE EAST ==========

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Al Minhad Air Base', 'UAE', 'UAE Air Force base used by US and allied forces for logistics, tanker, and transport operations. Key hub for Afghanistan airlift operations.', 25.0286, 55.3658, 'Medium', 'Air Force', 'Active', 2002
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Al Minhad Air Base' AND country_name = 'UAE');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Arar (northern Saudi Arabia)', 'Saudi Arabia', 'US Patriot missile battery and troop presence near the Iraqi border. Deployed during periods of heightened tensions.', 30.9064, 41.1419, 'Small', 'Army', 'Active', 2019
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Arar (northern Saudi Arabia)' AND country_name = 'Saudi Arabia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Tabuk Air Base', 'Saudi Arabia', 'Saudi Air Force base with periodic US access near the Jordanian/Israeli border. Used during CENTCOM exercises.', 28.3654, 36.6189, 'Access Agreement', 'Air Force', 'Active', 1991
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Tabuk Air Base' AND country_name = 'Saudi Arabia');

-- ========== ADDITIONAL AFRICA ==========

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Nzara Cooperation Site', 'South Sudan', 'Former US SOF presence for LRA counter-operations near the DRC border.', 4.2556, 28.5994, 'Lily-pad', 'SOF', 'Closed', 2011
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Nzara Cooperation Site' AND country_name = 'South Sudan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Mombasa Port Access', 'Kenya', 'US Navy port access at Mombasa for ship visits, logistics, and replenishment. Indian Ocean maritime operations support.', -4.0435, 39.6682, 'Lily-pad', 'Navy', 'Active', 2002
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Mombasa Port Access' AND country_name = 'Kenya');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Wajir Airstrip', 'Kenya', 'Kenyan military airstrip with US drone and ISR operations supporting counter-Al-Shabaab.', 1.7333, 40.0917, 'Lily-pad', 'Air Force', 'Active', 2012
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Wajir Airstrip' AND country_name = 'Kenya');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Arba Minch Airport', 'Ethiopia', 'Small US drone facility in southern Ethiopia. Surveillance flights over Somalia and East Africa.', 6.0394, 37.5906, 'Lily-pad', 'Air Force', 'Active', 2011
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Arba Minch Airport' AND country_name = 'Ethiopia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Victoria International Airport', 'Seychelles', 'US Navy P-3/MQ-9 operations for Indian Ocean maritime domain awareness and counter-piracy.', -4.6743, 55.5218, 'Lily-pad', 'Navy', 'Active', 2009
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Victoria International Airport' AND country_name = 'Seychelles');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Léopoldville / N''Dolo Airfield', 'Democratic Republic of Congo', 'Periodic US military logistics presence for Central Africa operations and humanitarian support.', -4.3265, 15.3271, 'Lily-pad', 'Air Force', 'Active', 2014
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Léopoldville / N''Dolo Airfield' AND country_name = 'Democratic Republic of Congo');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Agadez Drone Base (French cooperation)', 'Niger', 'Auxiliary ISR site coordinated with French forces in the Sahel. Operations suspended after 2023 coup.', 16.9667, 7.9833, 'Lily-pad', 'Air Force', 'Closed', 2018
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Agadez Drone Base (French cooperation)' AND country_name = 'Niger');

-- ========== ADDITIONAL EUROPE (Denmark, Croatia, Slovakia) ==========

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Keflavik NATO Air Policing', 'Iceland', 'Rotational NATO air policing facility. US and allied aircraft deploy periodically for North Atlantic surveillance.', 63.9850, -22.6056, 'Access Agreement', 'Air Force', 'Active', 2008
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Keflavik NATO Air Policing' AND country_name = 'Iceland');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Sliac Air Base', 'Slovakia', 'Slovak Air Force base with periodic US rotational presence. NATO air policing and exercises.', 48.6378, 19.1344, 'Access Agreement', 'Air Force', 'Active', 2018
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Sliac Air Base' AND country_name = 'Slovakia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Đukovac Barracks (Croatia)', 'Croatia', 'US/NATO military cooperation site for exercises in southeastern Europe.', 45.4286, 15.5536, 'Access Agreement', 'Army', 'Active', 2018
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Đukovac Barracks (Croatia)' AND country_name = 'Croatia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Deveselu Support Area', 'Romania', 'Support facilities adjacent to the Aegis Ashore missile defense site. Houses personnel and logistics.', 43.7900, 24.4700, 'Small', 'Navy', 'Active', 2016
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Deveselu Support Area' AND country_name = 'Romania');

-- ========== VIETNAM WAR ERA SOUTH VIETNAM (historical, all closed) ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Cam Ranh Bay', 'Vietnam', 'Former major US Navy and Air Force base during the Vietnam War. One of the best natural deepwater harbors in Southeast Asia. Now Vietnamese military base.', 11.9981, 109.2190, 'Major', 'Navy/Air Force', 'Closed', 1965
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Cam Ranh Bay' AND country_name = 'Vietnam');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Tan Son Nhut Air Base', 'Vietnam', 'Major US Air Force base near Saigon during the Vietnam War. Site of the final evacuation helicopter flights in April 1975.', 10.8188, 106.6525, 'Major', 'Air Force', 'Closed', 1955
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Tan Son Nhut Air Base' AND country_name = 'Vietnam');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Da Nang Air Base', 'Vietnam', 'First US combat base in Vietnam (1965). Marine and Air Force operations hub in central Vietnam during the war.', 16.0439, 108.1994, 'Major', 'Air Force/Marines', 'Closed', 1965
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Da Nang Air Base' AND country_name = 'Vietnam');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Bien Hoa Air Base', 'Vietnam', 'Major US Air Force base northeast of Saigon. First jet fighter base in Vietnam. Still contaminated with Agent Orange.', 10.9822, 106.8113, 'Major', 'Air Force', 'Closed', 1961
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Bien Hoa Air Base' AND country_name = 'Vietnam');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Long Binh Post', 'Vietnam', 'Largest US Army base during the Vietnam War. Housed up to 60,000 personnel at peak. Logistics and command center.', 10.9500, 106.8300, 'Major', 'Army', 'Closed', 1966
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Long Binh Post' AND country_name = 'Vietnam');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Phu Bai Combat Base', 'Vietnam', 'US Marine Corps and Army base near Hue. Intelligence operations and combat support during the Tet Offensive.', 16.4000, 107.7000, 'Medium', 'Marines/Army', 'Closed', 1965
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Phu Bai Combat Base' AND country_name = 'Vietnam');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Khe Sanh Combat Base', 'Vietnam', 'Famous Marine Corps base site of the 1968 siege during the Vietnam War. 77-day battle became a symbol of the war.', 16.6340, 106.7280, 'Medium', 'Marines', 'Closed', 1962
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Khe Sanh Combat Base' AND country_name = 'Vietnam');

-- ========== IRAQ WAR ERA (historical, closed) ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Victory / Baghdad International', 'Iraq', 'Former headquarters of Multi-National Force Iraq at Baghdad International Airport. Massive base complex housing tens of thousands. Closed 2011.', 33.2625, 44.2347, 'Major', 'Army', 'Closed', 2003
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Victory / Baghdad International' AND country_name = 'Iraq');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'FOB Speicher (Tikrit)', 'Iraq', 'Former large US base near Tikrit, Saddam Hussein hometown. Closed in 2011. Briefly captured by ISIS in 2014.', 34.6067, 43.6772, 'Major', 'Army', 'Closed', 2003
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'FOB Speicher (Tikrit)' AND country_name = 'Iraq');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Taji', 'Iraq', 'Former US base north of Baghdad. Used for training Iraqi forces. Transitioned to Iraqi control.', 33.5253, 44.2631, 'Major', 'Army', 'Closed', 2003
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Taji' AND country_name = 'Iraq');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Balad Air Base (Joint Base Balad)', 'Iraq', 'Second largest US base in Iraq during the war. Handled more air traffic than Chicago O''Hare at peak. Now Iraqi Air Force.', 33.9403, 44.3614, 'Major', 'Air Force', 'Closed', 2003
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Balad Air Base (Joint Base Balad)' AND country_name = 'Iraq');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Fallujah', 'Iraq', 'US Marine Corps base in Fallujah. Center of operations during the two Battles of Fallujah (2004). Closed 2011.', 33.3500, 43.7833, 'Major', 'Marines', 'Closed', 2003
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Fallujah' AND country_name = 'Iraq');

-- ========== REMAINING GLOBAL SITES ==========

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Lamu Port Access', 'Kenya', 'US Navy port access and ISR cooperation at Lamu, supporting maritime operations in the Indian Ocean.', -2.2714, 40.9022, 'Lily-pad', 'Navy', 'Active', 2010
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Lamu Port Access' AND country_name = 'Kenya');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Yokota JASDF Fuchu AS', 'Japan', 'Japanese Air Self-Defense Force facility near Yokota with joint US-Japan air defense operations.', 35.6900, 139.4800, 'Small', 'Air Force', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Yokota JASDF Fuchu AS' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Clark Air Base (former)', 'Philippines', 'Once the largest US overseas air base. Destroyed by Mt. Pinatubo eruption in 1991 and returned to the Philippines. Now Clark International Airport.', 15.1860, 120.5600, 'Major', 'Air Force', 'Closed', 1903
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Clark Air Base (former)' AND country_name = 'Philippines');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Subic Bay Naval Base (former)', 'Philippines', 'Former major US Navy base. Was the largest US overseas naval facility. Philippines refused to renew lease in 1991. Now Subic Bay Freeport.', 14.7942, 120.2822, 'Major', 'Navy', 'Closed', 1898
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Subic Bay Naval Base (former)' AND country_name = 'Philippines');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Red Cloud (Uijeongbu)', 'South Korea', 'Former US Army base near Seoul. Returned to South Korea as part of the consolidation to Camp Humphreys.', 37.7383, 127.0350, 'Medium', 'Army', 'Closed', 1954
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Red Cloud (Uijeongbu)' AND country_name = 'South Korea');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Hovey', 'South Korea', 'Former US Army base near the DMZ. Consolidated into Camp Humphreys. Support for 2nd Infantry Division.', 37.9000, 127.0500, 'Medium', 'Army', 'Closed', 1952
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Hovey' AND country_name = 'South Korea');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Wheelus Air Base (former)', 'Libya', 'Former major US Air Force base near Tripoli. Was the largest US base in Africa. Expelled by Gaddafi in 1970.', 32.8951, 13.2758, 'Major', 'Air Force', 'Closed', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Wheelus Air Base (former)' AND country_name = 'Libya');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kénitra Air Base (former)', 'Morocco', 'Former US Air Force and Navy base near Rabat. Strategic Cold War installation. Returned to Morocco in 1978.', 34.2989, -6.5956, 'Major', 'Air Force/Navy', 'Closed', 1951
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kénitra Air Base (former)' AND country_name = 'Morocco');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Peshawar Air Station (former)', 'Pakistan', 'Former CIA/USAF intelligence base. The U-2 spy plane shot down over Russia in 1960 (Gary Powers) launched from here. Closed 1970.', 34.0151, 71.5249, 'Medium', 'Air Force/CIA', 'Closed', 1958
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Peshawar Air Station (former)' AND country_name = 'Pakistan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Shamsi Airfield (former)', 'Pakistan', 'Former CIA drone base in Balochistan used for strikes in Pakistan tribal areas. Pakistan ordered US withdrawal in 2011 after Bin Laden raid.', 28.3167, 65.8833, 'Small', 'CIA/Air Force', 'Closed', 2001
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Shamsi Airfield (former)' AND country_name = 'Pakistan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Jacobabad Airfield (former)', 'Pakistan', 'Former US base used during early Afghanistan operations. Search and rescue and close air support staging.', 28.2836, 68.4500, 'Medium', 'Air Force', 'Closed', 2001
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Jacobabad Airfield (former)' AND country_name = 'Pakistan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Châteauroux-Déols Air Station (former)', 'France', 'Former major US Air Force logistics base in central France. Closed when De Gaulle withdrew from NATO military structure in 1966.', 46.8621, 1.7217, 'Major', 'Air Force', 'Closed', 1951
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Châteauroux-Déols Air Station (former)' AND country_name = 'France');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Évreux-Fauville Air Base (former)', 'France', 'Former US Air Force base in Normandy. Part of the massive US military presence expelled by De Gaulle in 1967.', 49.0286, 1.2197, 'Medium', 'Air Force', 'Closed', 1952
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Évreux-Fauville Air Base (former)' AND country_name = 'France');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Zaragoza Air Base (former)', 'Spain', 'Former US Air Force training base in northeastern Spain. Supported NATO tactical fighter training. Returned 1994.', 41.6661, -1.0414, 'Medium', 'Air Force', 'Closed', 1954
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Zaragoza Air Base (former)' AND country_name = 'Spain');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Torrejón Air Base (former)', 'Spain', 'Former major US Air Force base near Madrid. Home to the 401st Tactical Fighter Wing. Returned to Spain 1992.', 40.4836, -3.4458, 'Major', 'Air Force', 'Closed', 1953
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Torrejón Air Base (former)' AND country_name = 'Spain');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Hellenikon Air Base (former)', 'Greece', 'Former US Air Force base near Athens. Closed in 1991. Site now Athens International Airport.', 37.8933, 23.7261, 'Major', 'Air Force', 'Closed', 1947
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Hellenikon Air Base (former)' AND country_name = 'Greece');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Eritrea (Camp Gilbert/Kagnew Station, former)', 'Eritrea', 'Former US Army communications station in Asmara. Important Cold War signals intelligence facility. Closed when Ethiopia aligned with Soviet Union.', 15.3389, 38.9406, 'Medium', 'Army', 'Closed', 1943
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Eritrea (Camp Gilbert/Kagnew Station, former)' AND country_name = 'Eritrea');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Dhahran Air Base (former)', 'Saudi Arabia', 'Former US Air Force base. Attacked by Scud missile in 1991, killing 28 US soldiers. Now King Abdulaziz Air Base.', 26.2653, 50.1522, 'Major', 'Air Force', 'Closed', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Dhahran Air Base (former)' AND country_name = 'Saudi Arabia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Taipei Air Station (former)', 'Taiwan', 'Former US Air Force advisory group in Taipei. US military presence ended with recognition of PRC in 1979.', 25.0667, 121.5500, 'Medium', 'Air Force', 'Closed', 1950
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Taipei Air Station (former)' AND country_name = 'Taiwan');

END $$;
