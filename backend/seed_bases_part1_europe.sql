-- ============================================================
-- MILITARY BASES SEED: Part 1 - Europe (Major & Medium installations)
-- Sources: David Vine (American University), GlobalSecurity.org
-- Run AFTER seed_military_bases_schema.sql
-- ============================================================

DO $$
BEGIN

-- ========== GERMANY (Major hub - largest US presence in Europe) ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Ramstein Air Base', 'Germany', 'Largest US Air Force base outside the US. Headquarters of US Air Forces in Europe (USAFE) and NATO Allied Air Command. Critical hub for airlift operations to the Middle East and Africa.', 49.4369, 7.6003, 'Major', 'Air Force', 'Active', 1953
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Ramstein Air Base' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Landstuhl Regional Medical Center', 'Germany', 'Largest US military hospital outside the United States. Provides medical care for wounded service members evacuated from combat zones in the Middle East and Africa.', 49.4350, 7.5750, 'Major', 'Army', 'Active', 1953
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Landstuhl Regional Medical Center' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Spangdahlem Air Base', 'Germany', 'US Air Force fighter base hosting the 52nd Fighter Wing. Key NATO forward operating location in central Europe.', 49.9725, 6.6925, 'Major', 'Air Force', 'Active', 1953
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Spangdahlem Air Base' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'US Army Garrison Wiesbaden (Clay Kaserne)', 'Germany', 'Headquarters of US Army Europe and Africa (USAREUR-AF). Major command and control installation.', 50.0500, 8.2400, 'Major', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'US Army Garrison Wiesbaden (Clay Kaserne)' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'US Army Garrison Stuttgart (Kelley Barracks)', 'Germany', 'Headquarters of US European Command (EUCOM) and US Africa Command (AFRICOM). Major strategic command center.', 48.7360, 9.1640, 'Major', 'Army/Joint', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'US Army Garrison Stuttgart (Kelley Barracks)' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'US Army Garrison Bavaria (Grafenwöhr)', 'Germany', 'Major US Army training area in Europe. One of the largest military training grounds on the continent, used for combined arms exercises.', 49.6830, 11.9200, 'Major', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'US Army Garrison Bavaria (Grafenwöhr)' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Vilseck (Rose Barracks)', 'Germany', 'Home of the 2nd Cavalry Regiment, US Army. Stryker brigade combat team stationed here for European rapid response.', 49.6130, 11.8060, 'Major', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Vilseck (Rose Barracks)' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Hohenfels Training Area', 'Germany', 'Joint Multinational Readiness Center (JMRC). Major combined training facility for US and NATO forces.', 49.1960, 11.8310, 'Major', 'Army', 'Active', 1951
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Hohenfels Training Area' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Ansbach (Katterbach Kaserne)', 'Germany', 'US Army aviation garrison. Home to combat aviation brigade assets in Europe.', 49.3060, 10.5630, 'Medium', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Ansbach (Katterbach Kaserne)' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Baumholder (Smith Barracks)', 'Germany', 'US Army garrison supporting armored brigade combat teams. Training area in Rhineland-Palatinate.', 49.6530, 7.3370, 'Medium', 'Army', 'Active', 1951
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Baumholder (Smith Barracks)' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kaiserslautern Military Community', 'Germany', 'Largest US military community outside the United States. Includes multiple installations, logistics, and support facilities.', 49.4400, 7.7700, 'Medium', 'Joint', 'Active', 1951
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kaiserslautern Military Community' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Sembach Kaserne', 'Germany', 'US Army installation near Kaiserslautern. Supports logistics and intelligence operations.', 49.5100, 7.8670, 'Medium', 'Army', 'Active', 1953
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Sembach Kaserne' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Rhine Ordnance Barracks', 'Germany', 'Major logistics hub supporting US forces in Europe. Ammunition storage and distribution center.', 49.4330, 7.7220, 'Medium', 'Army', 'Active', 1951
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Rhine Ordnance Barracks' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Panzer Kaserne (Böblingen)', 'Germany', 'US Army garrison near Stuttgart. Houses Special Operations Command Europe.', 48.6830, 9.0170, 'Medium', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Panzer Kaserne (Böblingen)' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Patch Barracks (Stuttgart)', 'Germany', 'Key installation within US Army Garrison Stuttgart. Houses US Special Operations Command Europe (SOCEUR).', 48.7290, 9.1020, 'Medium', 'Army/SOF', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Patch Barracks (Stuttgart)' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Dagger Complex (Griesheim)', 'Germany', 'NSA/intelligence facility near Darmstadt. Signals intelligence and cyber operations site.', 49.8540, 8.5580, 'Small', 'Intelligence', 'Active', 2004
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Dagger Complex (Griesheim)' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Miesau Army Depot', 'Germany', 'Major US Army ammunition and logistics depot in Europe. Stores and distributes munitions.', 49.4640, 7.4650, 'Medium', 'Army', 'Active', 1954
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Miesau Army Depot' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Wiesbaden Army Airfield', 'Germany', 'Military airfield supporting US Army Europe operations. Helicopter and fixed-wing transport hub.', 50.0498, 8.3254, 'Medium', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Wiesbaden Army Airfield' AND country_name = 'Germany');

-- ========== ITALY ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Naval Air Station Sigonella', 'Italy', 'Major US Navy hub in the Mediterranean. Supports P-8 Poseidon maritime patrol operations and logistics for Africa/Middle East.', 37.4017, 14.9222, 'Major', 'Navy', 'Active', 1959
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Naval Air Station Sigonella' AND country_name = 'Italy');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Aviano Air Base', 'Italy', 'US Air Force base in northeastern Italy. Home to the 31st Fighter Wing with F-16 fighters. Key NATO southern flank installation.', 46.0319, 12.5965, 'Major', 'Air Force', 'Active', 1955
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Aviano Air Base' AND country_name = 'Italy');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Naval Support Activity Naples', 'Italy', 'Headquarters of US Naval Forces Europe and Africa (NAVEUR-NAVAF) and Allied Joint Force Command Naples (NATO). Strategic Mediterranean command center.', 40.8200, 14.1938, 'Major', 'Navy', 'Active', 1951
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Naval Support Activity Naples' AND country_name = 'Italy');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Darby', 'Italy', 'US Army installation near Pisa. Largest US Army munitions storage south of the Alps. Critical pre-positioned war reserve.', 43.6710, 10.3275, 'Major', 'Army', 'Active', 1951
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Darby' AND country_name = 'Italy');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'US Army Garrison Vicenza (Caserma Del Din)', 'Italy', 'Home of the 173rd Airborne Brigade, the US Army rapid deployment force in Europe. Paratroopers stationed here for global response.', 45.5455, 11.5353, 'Major', 'Army', 'Active', 1955
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'US Army Garrison Vicenza (Caserma Del Din)' AND country_name = 'Italy');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Caserma Ederle (Vicenza)', 'Italy', 'US Army garrison in Vicenza, supporting the 173rd Airborne Brigade and SETAF-AF (Southern European Task Force - Africa).', 45.5380, 11.5460, 'Medium', 'Army', 'Active', 1955
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Caserma Ederle (Vicenza)' AND country_name = 'Italy');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Naval Computer and Telecommunications Station Sicily', 'Italy', 'Communications facility supporting Mediterranean naval operations and satellite links.', 37.4000, 14.9100, 'Small', 'Navy', 'Active', 1991
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Naval Computer and Telecommunications Station Sicily' AND country_name = 'Italy');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Gaeta Naval Base', 'Italy', 'Home port for the USS Mount Whitney, flagship of US Sixth Fleet. Small but strategically vital Mediterranean port.', 41.2140, 13.5710, 'Medium', 'Navy', 'Active', 1967
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Gaeta Naval Base' AND country_name = 'Italy');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'San Vito dei Normanni Air Station', 'Italy', 'Former intelligence and electronic surveillance station in Puglia. Now Italian Air Force managed with US access.', 40.6550, 17.8300, 'Small', 'Air Force', 'Reduced', 1960
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'San Vito dei Normanni Air Station' AND country_name = 'Italy');

-- ========== UNITED KINGDOM ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'RAF Lakenheath', 'United Kingdom', 'Largest US Air Force base in the UK. Home to the 48th Fighter Wing with F-15E Strike Eagles and F-35A Lightning IIs. Principal US power projection platform in Western Europe.', 52.4093, 0.5608, 'Major', 'Air Force', 'Active', 1948
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'RAF Lakenheath' AND country_name = 'United Kingdom');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'RAF Mildenhall', 'United Kingdom', 'Major US Air Force tanker and special operations base. Home to the 100th Air Refueling Wing and 352nd Special Operations Wing.', 52.3613, 0.4864, 'Major', 'Air Force', 'Active', 1950
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'RAF Mildenhall' AND country_name = 'United Kingdom');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'RAF Croughton', 'United Kingdom', 'Major US communications relay station. Key node in global Defense Information Systems Network (DISN).', 51.9988, -1.2058, 'Medium', 'Air Force', 'Active', 1950
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'RAF Croughton' AND country_name = 'United Kingdom');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'RAF Fairford', 'United Kingdom', 'US Air Force forward operating base for bombers. Has the longest runway in the UK, used for B-52, B-1B, and B-2 deployments.', 51.6822, -1.7900, 'Medium', 'Air Force', 'Active', 1950
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'RAF Fairford' AND country_name = 'United Kingdom');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'RAF Alconbury', 'United Kingdom', 'US Air Force intelligence and logistics facility. Joint Intelligence Operations Center Europe.', 52.3700, -0.2217, 'Medium', 'Air Force', 'Active', 1942
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'RAF Alconbury' AND country_name = 'United Kingdom');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'RAF Menwith Hill', 'United Kingdom', 'Major NSA/GCHQ signals intelligence station. Largest electronic monitoring station outside the US. Part of the ECHELON global surveillance network.', 54.0153, -1.6883, 'Major', 'Intelligence/NSA', 'Active', 1954
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'RAF Menwith Hill' AND country_name = 'United Kingdom');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'RAF Fylingdales', 'United Kingdom', 'Ballistic Missile Early Warning System (BMEWS) station. Part of the US missile defense network tracking ICBMs and space objects.', 54.3614, -0.6706, 'Medium', 'Space Force', 'Active', 1963
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'RAF Fylingdales' AND country_name = 'United Kingdom');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Diego Garcia (BIOT)', 'United Kingdom', 'Major US Navy and Air Force base in the Indian Ocean. Strategic bomber and naval operations hub for the Middle East and Indian Ocean region. Leased from the UK.', -7.3195, 72.4229, 'Major', 'Navy/Air Force', 'Active', 1971
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Diego Garcia (BIOT)' AND country_name = 'United Kingdom');

-- ========== SPAIN ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Naval Station Rota', 'Spain', 'Major US naval base in southwestern Spain. Home to Aegis Ashore missile defense system and forward-deployed destroyers. Key Mediterranean and Atlantic hub.', 36.6317, -6.3492, 'Major', 'Navy', 'Active', 1953
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Naval Station Rota' AND country_name = 'Spain');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Morón Air Base', 'Spain', 'US Air Force forward operating location. Supports crisis response operations in Africa and the Mediterranean. Hosts SPMAGTF-CR-AF Marines.', 37.1783, -5.6150, 'Medium', 'Air Force/Marines', 'Active', 1953
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Morón Air Base' AND country_name = 'Spain');

-- ========== TURKEY ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Incirlik Air Base', 'Turkey', 'Major US Air Force base in southern Turkey. Critical for operations in the Middle East. Houses approximately 50 US nuclear weapons as part of NATO nuclear sharing.', 37.0017, 35.4253, 'Major', 'Air Force', 'Active', 1954
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Incirlik Air Base' AND country_name = 'Turkey');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kürecik Radar Station', 'Turkey', 'AN/TPY-2 radar station part of the NATO missile defense system. Monitors ballistic missile launches from Iran.', 38.5000, 37.8333, 'Small', 'Army/Missile Defense', 'Active', 2012
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kürecik Radar Station' AND country_name = 'Turkey');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Izmir Air Station', 'Turkey', 'NATO Allied Air Command facility with US presence. Supports air operations coordination in the eastern Mediterranean.', 38.4272, 27.1580, 'Small', 'Air Force', 'Active', 1954
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Izmir Air Station' AND country_name = 'Turkey');

-- ========== GREECE ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Naval Support Activity Souda Bay', 'Greece', 'Deep-water naval facility on Crete. Only NATO base in the eastern Mediterranean capable of supporting aircraft carriers. Critical for Mediterranean and Middle East operations.', 35.4886, 24.1175, 'Major', 'Navy', 'Active', 1969
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Naval Support Activity Souda Bay' AND country_name = 'Greece');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Alexandroupoli Port Facility', 'Greece', 'US military logistics hub in northeastern Greece near Turkish and Bulgarian borders. Growing importance for Black Sea regional access.', 40.8489, 25.8744, 'Small', 'Army', 'Active', 2022
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Alexandroupoli Port Facility' AND country_name = 'Greece');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Larissa Air Base', 'Greece', 'Greek Air Force base with expanding US access under the 2021 Mutual Defense Cooperation Agreement. MQ-9 Reaper drone operations.', 39.6503, 22.4653, 'Access Agreement', 'Air Force', 'Active', 2021
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Larissa Air Base' AND country_name = 'Greece');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Stefanovikio Army Base', 'Greece', 'US Army rotational presence and helicopter operations under MDCA agreement. Near Volos in central Greece.', 39.4790, 22.7600, 'Access Agreement', 'Army', 'Active', 2021
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Stefanovikio Army Base' AND country_name = 'Greece');

-- ========== BELGIUM ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'SHAPE (Supreme Headquarters Allied Powers Europe)', 'Belgium', 'NATO military headquarters near Mons. Major US military presence as part of NATO command structure. Houses Allied Command Operations.', 50.5040, 3.9620, 'Major', 'Joint/NATO', 'Active', 1967
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'SHAPE (Supreme Headquarters Allied Powers Europe)' AND country_name = 'Belgium');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kleine Brogel Air Base', 'Belgium', 'Belgian Air Force base with US nuclear weapons storage as part of NATO nuclear sharing arrangement. B61 gravity bombs.', 51.1681, 5.4700, 'Medium', 'Air Force', 'Active', 1953
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kleine Brogel Air Base' AND country_name = 'Belgium');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Brussels NATO HQ', 'Belgium', 'NATO Headquarters. Large US military and civilian staff presence. Political headquarters of the North Atlantic Alliance.', 50.8764, 4.4239, 'Medium', 'Joint/NATO', 'Active', 1967
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Brussels NATO HQ' AND country_name = 'Belgium');

-- ========== NETHERLANDS ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Volkel Air Base', 'Netherlands', 'Royal Netherlands Air Force base hosting US nuclear weapons under NATO nuclear sharing. B61 gravity bombs for Dutch F-35s.', 51.6564, 5.7081, 'Medium', 'Air Force', 'Active', 1954
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Volkel Air Base' AND country_name = 'Netherlands');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Brunssum (JFCBS)', 'Netherlands', 'Allied Joint Force Command Brunssum. NATO operational command with significant US staff. Commands NATO operations in northern and eastern Europe.', 50.9400, 5.9700, 'Medium', 'Joint/NATO', 'Active', 1967
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Brunssum (JFCBS)' AND country_name = 'Netherlands');

-- ========== POLAND ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Redzikowo Aegis Ashore', 'Poland', 'US Aegis Ashore missile defense site. Part of the European Phased Adaptive Approach for ballistic missile defense. Operational since 2024.', 54.4772, 17.0978, 'Major', 'Navy/Missile Defense', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Redzikowo Aegis Ashore' AND country_name = 'Poland');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Powidz Air Base', 'Poland', 'Major US logistics and prepositioning hub in central Poland. Army Prepositioned Stock (APS) site with heavy equipment.', 52.3794, 17.8539, 'Major', 'Army', 'Active', 2023
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Powidz Air Base' AND country_name = 'Poland');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Kosciuszko (Poznan)', 'Poland', 'Headquarters of V Corps Forward in Poland. US Army forward command post supporting NATO eastern flank.', 52.4064, 16.9252, 'Medium', 'Army', 'Active', 2022
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Kosciuszko (Poznan)' AND country_name = 'Poland');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Lask Air Base', 'Poland', 'Polish Air Force base with US MQ-9 Reaper drone detachment and rotational fighter aircraft deployments.', 51.5519, 19.1792, 'Access Agreement', 'Air Force', 'Active', 2013
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Lask Air Base' AND country_name = 'Poland');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Drawsko Pomorskie Training Area', 'Poland', 'Major NATO training area in northwestern Poland. US armored brigade rotational deployments and live-fire exercises.', 53.5400, 15.8000, 'Access Agreement', 'Army', 'Active', 2017
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Drawsko Pomorskie Training Area' AND country_name = 'Poland');

-- ========== ROMANIA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Deveselu Aegis Ashore', 'Romania', 'US Aegis Ashore missile defense site. First European location for the ballistic missile defense system, operational since 2016.', 43.7847, 24.4636, 'Major', 'Navy/Missile Defense', 'Active', 2016
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Deveselu Aegis Ashore' AND country_name = 'Romania');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Mihail Kogalniceanu Air Base', 'Romania', 'Major US military hub near the Black Sea. Expanded significantly after 2022 Russian invasion of Ukraine. Hosts rotational US forces.', 44.3600, 28.4411, 'Major', 'Air Force/Army', 'Active', 2007
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Mihail Kogalniceanu Air Base' AND country_name = 'Romania');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Campia Turzii Air Base', 'Romania', 'Romanian Air Force base with expanding US presence. Hosts rotational US Air Force fighter and MQ-9 drone detachments.', 46.5022, 23.8861, 'Medium', 'Air Force', 'Active', 2019
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Campia Turzii Air Base' AND country_name = 'Romania');

-- ========== BULGARIA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Novo Selo Training Area', 'Bulgaria', 'US Army training range in southeastern Bulgaria. Used for rotational deployments and combined exercises near Black Sea region.', 42.1000, 26.0000, 'Access Agreement', 'Army', 'Active', 2006
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Novo Selo Training Area' AND country_name = 'Bulgaria');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Graf Ignatievo Air Base', 'Bulgaria', 'Bulgarian Air Force base with US access for rotational deployments. Supports NATO air policing missions in the Black Sea region.', 42.2906, 24.7139, 'Access Agreement', 'Air Force', 'Active', 2006
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Graf Ignatievo Air Base' AND country_name = 'Bulgaria');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Bezmer Air Base', 'Bulgaria', 'Bulgarian Air Force base with US rotational presence. Forward operating location for southeastern European operations.', 42.4550, 26.3519, 'Access Agreement', 'Air Force', 'Active', 2006
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Bezmer Air Base' AND country_name = 'Bulgaria');

-- ========== NORWAY ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Rygge Air Station', 'Norway', 'US access site under the 2022 Supplementary Defense Cooperation Agreement (SDCA). Supports air operations in northern Europe.', 59.3783, 10.7853, 'Access Agreement', 'Air Force', 'Active', 2022
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Rygge Air Station' AND country_name = 'Norway');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Sola Air Station', 'Norway', 'US access site near Stavanger under SDCA. Supports maritime patrol and North Sea operations.', 58.8764, 5.6372, 'Access Agreement', 'Air Force', 'Active', 2022
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Sola Air Station' AND country_name = 'Norway');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Evenes Air Station', 'Norway', 'US access site in northern Norway under SDCA. Strategic location for Arctic maritime patrol operations.', 68.4903, 16.6789, 'Access Agreement', 'Air Force', 'Active', 2022
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Evenes Air Station' AND country_name = 'Norway');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Ramsund Naval Station', 'Norway', 'US access naval facility in northern Norway under SDCA. Supports Arctic naval operations.', 68.4500, 16.5167, 'Access Agreement', 'Navy', 'Active', 2022
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Ramsund Naval Station' AND country_name = 'Norway');

-- ========== SWEDEN (new 2024 DCA) ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Luleå-Kallax Air Base', 'Sweden', 'Swedish Air Force base with US access under 2024 DCA. Strategic for Arctic air operations near the Finnish/Norwegian border.', 65.5436, 22.1208, 'Access Agreement', 'Air Force', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Luleå-Kallax Air Base' AND country_name = 'Sweden');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Vidsel Test Range', 'Sweden', 'Swedish military test range with US access under 2024 DCA. Largest test range in Western Europe.', 65.8764, 20.1489, 'Access Agreement', 'Joint', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Vidsel Test Range' AND country_name = 'Sweden');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Gothenburg Port Facility', 'Sweden', 'Port access under 2024 Sweden DCA for US naval and logistics operations in the Baltic region.', 57.7089, 11.9746, 'Access Agreement', 'Navy', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Gothenburg Port Facility' AND country_name = 'Sweden');

-- ========== FINLAND (new 2024 DCA) ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Rovaniemi Air Base', 'Finland', 'Finnish Air Force base with US access under 2024 DCA. Strategic Arctic location near Russian border.', 66.5639, 25.8308, 'Access Agreement', 'Air Force', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Rovaniemi Air Base' AND country_name = 'Finland');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Sodankylä Garrison', 'Finland', 'Finnish Army base with US access under 2024 DCA. Northernmost US access site in NATO, ideal for Arctic training.', 67.4167, 26.5833, 'Access Agreement', 'Army', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Sodankylä Garrison' AND country_name = 'Finland');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Ivalo Airport / Garrison', 'Finland', 'Finnish military facility with US access under DCA. Near the Arctic border with Norway and Russia.', 68.6073, 27.4053, 'Access Agreement', 'Army', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Ivalo Airport / Garrison' AND country_name = 'Finland');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Värriö Border Guard Station', 'Finland', 'Finnish border station near Russia with US access potential under 2024 DCA framework.', 67.7500, 29.6500, 'Access Agreement', 'Joint', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Värriö Border Guard Station' AND country_name = 'Finland');

-- ========== ICELAND ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Keflavik Air Base', 'Iceland', 'Former major US naval air station. Now Icelandic-operated with NATO rotational presence. P-8 Poseidon maritime patrol flights for North Atlantic surveillance.', 63.9850, -22.6056, 'Medium', 'Navy/Air Force', 'Active', 1951
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Keflavik Air Base' AND country_name = 'Iceland');

-- ========== PORTUGAL ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Lajes Field (Azores)', 'Portugal', 'US Air Force base in the Azores, mid-Atlantic. Strategic refueling and staging location between North America, Europe, and Africa.', 38.7618, -27.0908, 'Medium', 'Air Force', 'Active', 1944
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Lajes Field (Azores)' AND country_name = 'Portugal');

-- ========== KOSOVO ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Bondsteel', 'Kosovo', 'Largest US military base in southeastern Europe. Built in 1999 after the Kosovo War. Houses US KFOR contingent for peacekeeping operations.', 42.3628, 21.2544, 'Major', 'Army', 'Active', 1999
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Bondsteel' AND country_name = 'Kosovo');

-- ========== BALTIC STATES ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Ämari Air Base', 'Estonia', 'Estonian Air Force base with NATO air policing and US rotational fighter deployments. Near Tallinn on NATO eastern flank.', 59.2603, 24.2086, 'Access Agreement', 'Air Force', 'Active', 2014
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Ämari Air Base' AND country_name = 'Estonia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Tapa Military Base', 'Estonia', 'NATO Enhanced Forward Presence battlegroup location. US troops rotate through as part of the multinational NATO force.', 59.2500, 25.9500, 'Access Agreement', 'Army', 'Active', 2017
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Tapa Military Base' AND country_name = 'Estonia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Lielvārde Air Base', 'Latvia', 'Latvian Air Force base with US rotational presence. Supports NATO air policing and drone operations in the Baltic.', 56.7500, 24.8500, 'Access Agreement', 'Air Force', 'Active', 2019
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Lielvārde Air Base' AND country_name = 'Latvia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Ādaži Military Base', 'Latvia', 'NATO Enhanced Forward Presence location in Latvia. Canadian-led battlegroup with US rotational support.', 57.0700, 24.3300, 'Access Agreement', 'Army', 'Active', 2017
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Ādaži Military Base' AND country_name = 'Latvia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Šiauliai Air Base', 'Lithuania', 'Lithuanian Air Force base hosting NATO air policing rotations. US fighters frequently deploy here.', 55.8939, 23.3950, 'Access Agreement', 'Air Force', 'Active', 2004
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Šiauliai Air Base' AND country_name = 'Lithuania');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Pabradė Training Area', 'Lithuania', 'Major NATO training area in Lithuania. US Army rotational deployments near the Belarusian border.', 54.9800, 25.7800, 'Access Agreement', 'Army', 'Active', 2019
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Pabradė Training Area' AND country_name = 'Lithuania');

-- ========== CZECH REPUBLIC / HUNGARY ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Náměšť nad Oslavou Air Base', 'Czech Republic', 'Czech Air Force base with periodic US rotational presence for NATO exercises and training.', 49.1658, 16.1250, 'Access Agreement', 'Air Force', 'Active', 2015
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Náměšť nad Oslavou Air Base' AND country_name = 'Czech Republic');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Pápa Air Base', 'Hungary', 'NATO Strategic Airlift Capability base. Hosts C-17 Globemaster III aircraft shared by 12 NATO nations including the US.', 47.3636, 17.5008, 'Medium', 'Air Force/NATO', 'Active', 2009
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Pápa Air Base' AND country_name = 'Hungary');

END $$;
