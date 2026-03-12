-- ============================================================
-- MILITARY BASES SEED: Part 3 - Middle East, Central Asia & Africa
-- Sources: David Vine (American University), GlobalSecurity.org, The Intercept (Africa)
-- ============================================================

DO $$
BEGIN

-- ========== BAHRAIN ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Naval Support Activity Bahrain', 'Bahrain', 'Headquarters of US 5th Fleet and US Naval Forces Central Command (NAVCENT). The primary US naval hub in the Persian Gulf. Approximately 8,000 personnel.', 26.2167, 50.6000, 'Major', 'Navy', 'Active', 1971
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Naval Support Activity Bahrain' AND country_name = 'Bahrain');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Shaikh Isa Air Base', 'Bahrain', 'Bahraini Air Force base with significant US access. Supports air operations over the Persian Gulf and Arabian Sea.', 25.9183, 50.5906, 'Medium', 'Air Force', 'Active', 2002
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Shaikh Isa Air Base' AND country_name = 'Bahrain');

-- ========== QATAR ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Al Udeid Air Base', 'Qatar', 'Largest US air base in the Middle East. Hosts the Combined Air Operations Center (CAOC) that coordinates all US air operations in the region. Over 10,000 US personnel.', 25.1175, 51.3150, 'Major', 'Air Force', 'Active', 2001
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Al Udeid Air Base' AND country_name = 'Qatar');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp As Sayliyah', 'Qatar', 'US Army pre-positioned equipment site. Largest pre-positioned stock of US military equipment outside the continental US. Being reduced after Afghanistan withdrawal.', 25.3010, 51.4060, 'Major', 'Army', 'Reduced', 2000
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp As Sayliyah' AND country_name = 'Qatar');

-- ========== KUWAIT ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Arifjan', 'Kuwait', 'Major US Army forward headquarters in Kuwait. Serves as the primary staging base for operations in Iraq and the broader Middle East. Headquarters of US Army Central (ARCENT).', 28.9500, 48.0800, 'Major', 'Army', 'Active', 1999
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Arifjan' AND country_name = 'Kuwait');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Ali Al Salem Air Base', 'Kuwait', 'US Air Force base used as a transit and staging hub. Major passenger and cargo terminal for forces deploying to the Middle East.', 29.3467, 47.5208, 'Major', 'Air Force', 'Active', 2003
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Ali Al Salem Air Base' AND country_name = 'Kuwait');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Buehring', 'Kuwait', 'US Army training and staging facility. Troops acclimatize and train here before deploying to other Middle Eastern locations.', 29.4000, 47.7000, 'Major', 'Army', 'Active', 2003
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Buehring' AND country_name = 'Kuwait');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Ahmad al-Jaber Air Base', 'Kuwait', 'Kuwaiti Air Force base with US access. Used for air operations over Iraq and the Gulf.', 28.9347, 47.7919, 'Medium', 'Air Force', 'Active', 2003
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Ahmad al-Jaber Air Base' AND country_name = 'Kuwait');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Patriot (Kuwait Naval Base)', 'Kuwait', 'US naval facility near Ash Shuaybah port. Supports maritime security operations in the northern Persian Gulf.', 29.0300, 48.1600, 'Medium', 'Navy', 'Active', 2003
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Patriot (Kuwait Naval Base)' AND country_name = 'Kuwait');

-- ========== UNITED ARAB EMIRATES ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Al Dhafra Air Base', 'UAE', 'Major US Air Force base near Abu Dhabi. Hosts F-35, F-22, KC-10 tankers, and RQ-4 Global Hawk drones. Critical for Gulf air operations.', 24.2464, 54.5481, 'Major', 'Air Force', 'Active', 2001
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Al Dhafra Air Base' AND country_name = 'UAE');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Jebel Ali Port', 'UAE', 'Major commercial port used by US Navy. Most visited port by US warships outside the US. Logistics and replenishment hub.', 24.9900, 55.0600, 'Medium', 'Navy', 'Active', 1999
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Jebel Ali Port' AND country_name = 'UAE');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Fujairah Naval Facility', 'UAE', 'US Navy access facility on the Gulf of Oman side. Supports maritime operations outside the Strait of Hormuz chokepoint.', 25.1119, 56.3361, 'Small', 'Navy', 'Active', 2010
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Fujairah Naval Facility' AND country_name = 'UAE');

-- ========== OMAN ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Thumrait Air Base', 'Oman', 'Omani Air Force base with US access. Supports tanker, bomber, and surveillance aircraft operations over the Arabian Sea and Indian Ocean.', 17.6660, 54.0247, 'Medium', 'Air Force', 'Active', 1980
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Thumrait Air Base' AND country_name = 'Oman');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Masirah Island Air Base', 'Oman', 'Omani/US air base on Masirah Island in the Arabian Sea. Strategic location for Indian Ocean surveillance and maritime patrol.', 20.6750, 58.8900, 'Medium', 'Air Force', 'Active', 1980
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Masirah Island Air Base' AND country_name = 'Oman');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Muscat (Port Sultan Qaboos)', 'Oman', 'Port access for US Navy ships. Supports logistics and replenishment near the Strait of Hormuz.', 23.6253, 58.5653, 'Small', 'Navy', 'Active', 1980
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Muscat (Port Sultan Qaboos)' AND country_name = 'Oman');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Duqm Port and Airfield', 'Oman', 'Expanding Omani military port with growing US access. Strategic for operations in the Arabian Sea beyond the Strait of Hormuz bottleneck.', 19.5000, 57.7000, 'Access Agreement', 'Navy', 'Active', 2019
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Duqm Port and Airfield' AND country_name = 'Oman');

-- ========== SAUDI ARABIA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Prince Sultan Air Base', 'Saudi Arabia', 'US Air Force reactivated presence south of Riyadh. Hosts fighter and air defense assets. Major base during 1991 Gulf War, reactivated in 2019 amid Iran tensions.', 24.0625, 47.5817, 'Major', 'Air Force', 'Active', 2019
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Prince Sultan Air Base' AND country_name = 'Saudi Arabia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Eskan Village', 'Saudi Arabia', 'US military housing and support compound near Riyadh. Hosts advisory and training personnel.', 24.6400, 46.7900, 'Small', 'Joint', 'Active', 1991
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Eskan Village' AND country_name = 'Saudi Arabia');

-- ========== JORDAN ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Muwaffaq Salti Air Base (Al-Azraq)', 'Jordan', 'Jordanian Air Force base with significant US presence. Hosts US F-16 fighters and drones for operations against ISIS and regional surveillance.', 31.8264, 36.7828, 'Medium', 'Air Force', 'Active', 2013
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Muwaffaq Salti Air Base (Al-Azraq)' AND country_name = 'Jordan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Tower 22 (At-Tanf border post)', 'Jordan', 'Small US logistics outpost on the Jordan-Syria-Iraq border. Three US soldiers were killed here by an Iran-backed drone strike in January 2024.', 33.4300, 38.8100, 'Lily-pad', 'Army', 'Active', 2016
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Tower 22 (At-Tanf border post)' AND country_name = 'Jordan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'King Abdullah II Special Operations Training Center', 'Jordan', 'Joint US-Jordanian special operations training facility. Trains special forces from multiple allied nations.', 32.0300, 36.2000, 'Small', 'SOF', 'Active', 2009
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'King Abdullah II Special Operations Training Center' AND country_name = 'Jordan');

-- ========== IRAQ ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Al Asad Air Base', 'Iraq', 'Major US airbase in Anbar Province. Hosts over 1,500 US personnel as part of the counter-ISIS mission. Targeted by Iranian ballistic missiles in January 2020.', 33.7856, 42.4414, 'Major', 'Air Force/Marines', 'Active', 2003
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Al Asad Air Base' AND country_name = 'Iraq');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Erbil Air Base (Kurdistan)', 'Iraq', 'US military base in the Kurdistan Region. Supports counter-ISIS operations and Special Forces missions in northern Iraq and Syria.', 36.2376, 44.0066, 'Medium', 'Air Force/SOF', 'Active', 2014
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Erbil Air Base (Kurdistan)' AND country_name = 'Iraq');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Baghdad Diplomatic Support Center (Union III)', 'Iraq', 'US military facility within the Green Zone supporting the US Embassy. Houses military advisors and security personnel.', 33.3000, 44.3600, 'Small', 'Army', 'Active', 2011
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Baghdad Diplomatic Support Center (Union III)' AND country_name = 'Iraq');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Harir Air Base (Kurdistan)', 'Iraq', 'US special operations and intelligence base in Kurdistan. Supports counter-ISIS and intelligence gathering.', 36.5400, 44.3500, 'Small', 'SOF', 'Active', 2014
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Harir Air Base (Kurdistan)' AND country_name = 'Iraq');

-- ========== SYRIA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Al-Tanf Garrison', 'Syria', 'US military outpost at the Syria-Jordan-Iraq border junction. Trains Syrian opposition forces and blocks Iranian land corridor to Lebanon.', 33.4922, 38.6389, 'Small', 'Army/SOF', 'Active', 2016
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Al-Tanf Garrison' AND country_name = 'Syria');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Conoco Gas Field Base', 'Syria', 'US military position in northeastern Syria near Deir ez-Zor. Secures Syrian oil/gas fields and blocks ISIS and Iranian expansion.', 35.2500, 40.4500, 'Small', 'Army', 'Active', 2017
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Conoco Gas Field Base' AND country_name = 'Syria');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Rmeilan / Hasakah Airfield', 'Syria', 'US airfield in northeastern Syria (Rojava/Kurdish-controlled area). Supports SDF partner forces and counter-ISIS operations.', 36.7500, 42.0500, 'Small', 'Army/Air', 'Active', 2015
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Rmeilan / Hasakah Airfield' AND country_name = 'Syria');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kobani Airfield', 'Syria', 'US military airstrip near the Turkish border in Kobani. Supports logistics and rotary-wing operations for SDF operations.', 36.8400, 38.3500, 'Lily-pad', 'Army', 'Active', 2015
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kobani Airfield' AND country_name = 'Syria');

-- ========== ISRAEL ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Site 512 (Negev Desert)', 'Israel', 'Secretive US military facility in the Negev Desert. AN/TPY-2 radar for ballistic missile defense. One of the most classified US installations abroad.', 30.0200, 35.1200, 'Small', 'Army/Missile Defense', 'Active', 2012
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Site 512 (Negev Desert)' AND country_name = 'Israel');

-- ========== DJIBOUTI ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Lemonnier', 'Djibouti', 'Only permanent US military base in Africa. Hosts over 4,000 personnel. Headquarters of Combined Joint Task Force - Horn of Africa (CJTF-HOA). Drone operations hub for Somalia/Yemen.', 11.5469, 43.1564, 'Major', 'Navy/Joint', 'Active', 2002
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Lemonnier' AND country_name = 'Djibouti');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Chabelley Airfield', 'Djibouti', 'US drone base near Camp Lemonnier. Hosts MQ-9 Reaper operations targeting Al-Shabaab and AQAP in Somalia and Yemen.', 11.5167, 43.0500, 'Medium', 'Air Force', 'Active', 2013
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Chabelley Airfield' AND country_name = 'Djibouti');

-- ========== NIGER ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Air Base 201 (Agadez)', 'Niger', 'US drone base in central Niger. $110 million facility for MQ-9 Reaper surveillance and strike operations in the Sahel. US ordered to leave after 2023 coup.', 16.9660, 7.9928, 'Medium', 'Air Force', 'Closed', 2018
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Air Base 201 (Agadez)' AND country_name = 'Niger');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Air Base 101 (Niamey)', 'Niger', 'US military presence at Niamey airport. Used for ISR operations and logistics. US expelled after 2023 military coup.', 13.4810, 2.1730, 'Small', 'Air Force', 'Closed', 2013
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Air Base 101 (Niamey)' AND country_name = 'Niger');

-- ========== SOMALIA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Baledogle Airfield', 'Somalia', 'US military airfield south of Mogadishu. Hosts special operations forces and drone operations against Al-Shabaab.', 2.3506, 45.2053, 'Small', 'SOF/Air Force', 'Active', 2017
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Baledogle Airfield' AND country_name = 'Somalia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Mogadishu International Airport (US compound)', 'Somalia', 'Small US military compound at Mogadishu airport. Houses advisors working with Somali forces against Al-Shabaab.', 2.0144, 45.3047, 'Lily-pad', 'SOF', 'Active', 2017
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Mogadishu International Airport (US compound)' AND country_name = 'Somalia');

-- ========== KENYA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Simba (Manda Bay)', 'Kenya', 'US military base on the Kenyan coast near Somalia. Supports counter-terrorism operations in East Africa. Attacked by Al-Shabaab in January 2020.', -2.2500, 40.9000, 'Small', 'Navy/SOF', 'Active', 2004
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Simba (Manda Bay)' AND country_name = 'Kenya');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Embakasi Garrison (Nairobi)', 'Kenya', 'US military presence at Kenyan Army facility near Nairobi. Supports East Africa logistics and training missions.', -1.3200, 36.8750, 'Lily-pad', 'Army', 'Active', 2007
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Embakasi Garrison (Nairobi)' AND country_name = 'Kenya');

-- ========== CAMEROON ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Garoua Air Base', 'Cameroon', 'US drone surveillance base in northern Cameroon. Supports operations against Boko Haram in the Lake Chad region.', 9.3400, 13.3700, 'Lily-pad', 'Air Force', 'Active', 2015
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Garoua Air Base' AND country_name = 'Cameroon');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Douala Naval Base', 'Cameroon', 'US Navy cooperation facility supporting Gulf of Guinea maritime security operations.', 4.0061, 9.7100, 'Lily-pad', 'Navy', 'Active', 2014
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Douala Naval Base' AND country_name = 'Cameroon');

-- ========== CHAD ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'N''Djamena International Airport', 'Chad', 'US military presence at Chad capital airport. Intelligence, surveillance, and reconnaissance operations in the Sahel region.', 12.1340, 15.0340, 'Lily-pad', 'Air Force', 'Active', 2015
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'N''Djamena International Airport' AND country_name = 'Chad');

-- ========== BURKINA FASO ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Ouagadougou Air Base', 'Burkina Faso', 'Former US drone surveillance base. Used for ISR against jihadist groups in the Sahel. US presence ended after 2022 military coup.', 12.3530, -1.5120, 'Lily-pad', 'Air Force', 'Closed', 2012
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Ouagadougou Air Base' AND country_name = 'Burkina Faso');

-- ========== GHANA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Accra (Kotoka Airport US facility)', 'Ghana', 'US military logistics and ISR presence at Accra airport. Supports operations in West Africa and the Gulf of Guinea.', 5.6052, -0.1668, 'Lily-pad', 'Air Force', 'Active', 2015
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Accra (Kotoka Airport US facility)' AND country_name = 'Ghana');

-- ========== SENEGAL ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Dakar (Léopold Sédar Senghor Airport)', 'Senegal', 'US military logistics facility at Dakar airport. Supports airlift and ISR operations in West Africa.', 14.7397, -17.4903, 'Lily-pad', 'Air Force', 'Active', 2015
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Dakar (Léopold Sédar Senghor Airport)' AND country_name = 'Senegal');

-- ========== TUNISIA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Sidi Ahmed Air Base', 'Tunisia', 'US military cooperation at Tunisian Air Force base in Bizerte. Supports training and counter-terrorism in North Africa.', 37.2450, 9.7910, 'Lily-pad', 'Air Force', 'Active', 2014
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Sidi Ahmed Air Base' AND country_name = 'Tunisia');

-- ========== EGYPT ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Cairo West Air Base', 'Egypt', 'Egyptian Air Force base with periodic US access. Supports Bright Star military exercises and logistics.', 30.1164, 30.9153, 'Access Agreement', 'Air Force', 'Active', 1981
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Cairo West Air Base' AND country_name = 'Egypt');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'MFO North Camp (Sinai)', 'Egypt', 'Multinational Force and Observers base in the Sinai. US Army provides the largest contingent (~400 soldiers) for peacekeeping since the 1979 Egypt-Israel treaty.', 31.0700, 33.8300, 'Small', 'Army', 'Active', 1982
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'MFO North Camp (Sinai)' AND country_name = 'Egypt');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'MFO South Camp (Sharm el-Sheikh)', 'Egypt', 'MFO observation base near Sharm el-Sheikh. US troops monitor the Strait of Tiran and Gulf of Aqaba.', 27.9767, 34.3947, 'Small', 'Army', 'Active', 1982
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'MFO South Camp (Sharm el-Sheikh)' AND country_name = 'Egypt');

-- ========== UGANDA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Entebbe Air Base', 'Uganda', 'US special operations and logistics presence. Supported the hunt for Joseph Kony and LRA. ISR operations in East/Central Africa.', 0.0424, 32.4436, 'Lily-pad', 'SOF', 'Active', 2011
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Entebbe Air Base' AND country_name = 'Uganda');

-- ========== ETHIOPIA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Gilbert (Dire Dawa)', 'Ethiopia', 'Small US military facility used for drone operations and logistics supporting Horn of Africa counter-terrorism.', 9.6047, 41.8544, 'Lily-pad', 'Air Force', 'Active', 2007
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Gilbert (Dire Dawa)' AND country_name = 'Ethiopia');

-- ========== SOUTH SUDAN ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Juba Embassy Compound', 'South Sudan', 'US military presence supporting the embassy and UNMISS peacekeeping. Small contingent of Marines and advisors.', 4.8500, 31.5750, 'Lily-pad', 'Marines', 'Active', 2011
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Juba Embassy Compound' AND country_name = 'South Sudan');

-- ========== CENTRAL AFRICAN REPUBLIC ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Bangui (Obo Outpost)', 'Central African Republic', 'Former US SOF presence for counter-LRA operations. Small team deployed to Central African Republic before withdrawal.', 4.3667, 18.5833, 'Lily-pad', 'SOF', 'Closed', 2011
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Bangui (Obo Outpost)' AND country_name = 'Central African Republic');

-- ========== GABON ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Libreville Military Cooperation', 'Gabon', 'US military logistics and cooperation presence. Supports crisis response and Africa partnership activities.', 0.4586, 9.4122, 'Lily-pad', 'Joint', 'Active', 2014
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Libreville Military Cooperation' AND country_name = 'Gabon');

-- ========== BOTSWANA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Thebephatshwa Air Base', 'Botswana', 'US access for training and humanitarian exercises. Supports Southern Africa Command logistics.', -24.5556, 25.9219, 'Lily-pad', 'Air Force', 'Active', 2012
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Thebephatshwa Air Base' AND country_name = 'Botswana');

-- ========== CENTRAL ASIA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Transit Center at Manas (Kyrgyzstan)', 'Kyrgyzstan', 'Former US Air Force transit base near Bishkek. Key logistics hub for Afghanistan operations. Closed in 2014 under Russian pressure.', 43.0610, 74.4780, 'Medium', 'Air Force', 'Closed', 2001
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Transit Center at Manas (Kyrgyzstan)' AND country_name = 'Kyrgyzstan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Karshi-Khanabad Air Base (K2)', 'Uzbekistan', 'Former US airbase used during early Afghanistan operations. Closed in 2005 after US criticism of the Andijan massacre.', 38.8330, 65.9210, 'Medium', 'Air Force', 'Closed', 2001
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Karshi-Khanabad Air Base (K2)' AND country_name = 'Uzbekistan');

-- ========== AFGHANISTAN (CLOSED) ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Bagram Air Base', 'Afghanistan', 'Former largest US military base in Afghanistan. At peak held over 40,000 personnel. Abandoned in July 2021 during US withdrawal. Now under Taliban control.', 34.9461, 69.2649, 'Major', 'Air Force/Army', 'Closed', 2001
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Bagram Air Base' AND country_name = 'Afghanistan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kandahar Airfield', 'Afghanistan', 'Major US/NATO airfield in southern Afghanistan. Hub for operations in Helmand and Kandahar provinces. Closed with the 2021 withdrawal.', 31.5058, 65.8478, 'Major', 'Air Force/Army', 'Closed', 2001
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kandahar Airfield' AND country_name = 'Afghanistan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Bastion/Leatherneck', 'Afghanistan', 'Major Marine Corps base in Helmand Province. British-built Camp Bastion expanded with US Camp Leatherneck. Closed in 2014.', 31.8675, 64.2208, 'Major', 'Marines', 'Closed', 2009
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Bastion/Leatherneck' AND country_name = 'Afghanistan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Shindand Air Base', 'Afghanistan', 'US/Afghan Air Force base in Herat Province. Trained Afghan pilots. Closed with the 2021 withdrawal.', 33.3913, 62.2610, 'Medium', 'Air Force', 'Closed', 2004
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Shindand Air Base' AND country_name = 'Afghanistan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Jalalabad Airfield', 'Afghanistan', 'US SOF and intelligence base near the Pakistan border. Used for cross-border operations. Closed 2021.', 34.3997, 70.4986, 'Medium', 'SOF', 'Closed', 2001
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Jalalabad Airfield' AND country_name = 'Afghanistan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'FOB Salerno (Khost)', 'Afghanistan', 'Former forward operating base near Khost. Site of the 2009 Camp Chapman attack that killed 7 CIA officers.', 33.3347, 69.9519, 'Medium', 'Army', 'Closed', 2002
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'FOB Salerno (Khost)' AND country_name = 'Afghanistan');

-- ========== MOROCCO ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Tan Tan Air Base', 'Morocco', 'Moroccan Air Force base with US access for African Lion exercises. Growing cooperation site in North Africa.', 28.4481, -11.1617, 'Access Agreement', 'Air Force', 'Active', 2013
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Tan Tan Air Base' AND country_name = 'Morocco');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Ben Guerir Air Base', 'Morocco', 'Moroccan Air Force base with US access for African Lion exercises and logistics. Former SAC base.', 32.1036, -7.5886, 'Access Agreement', 'Air Force', 'Active', 2013
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Ben Guerir Air Base' AND country_name = 'Morocco');

-- ========== LIBERIA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Roberts International Airport', 'Liberia', 'Former US Air Force base during Cold War. Now used for periodic US military cooperation and Ebola response operations.', 6.2337, -10.3622, 'Lily-pad', 'Air Force', 'Active', 2014
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Roberts International Airport' AND country_name = 'Liberia');

-- ========== MAURITANIA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Nouakchott International Airport', 'Mauritania', 'US military cooperation presence supporting Trans-Saharan Counter-Terrorism Partnership.', 18.0978, -15.9487, 'Lily-pad', 'Air Force', 'Active', 2007
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Nouakchott International Airport' AND country_name = 'Mauritania');

-- ========== MALI ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Bamako-Sénou Airport', 'Mali', 'Former US military cooperation and ISR presence at Bamako airport. US access ended after 2021 military coup and Russian Wagner Group arrival.', 12.5335, -7.9499, 'Lily-pad', 'Air Force', 'Closed', 2013
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Bamako-Sénou Airport' AND country_name = 'Mali');

-- ========== CÔTE D''IVOIRE ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Abidjan Military Cooperation', 'Côte d''Ivoire', 'US military cooperation presence in West Africa. Supports regional security and counter-terrorism training.', 5.3600, -4.0083, 'Lily-pad', 'Joint', 'Active', 2015
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Abidjan Military Cooperation' AND country_name = 'Côte d''Ivoire');

-- ========== NIGERIA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Abuja ISR Facility', 'Nigeria', 'US intelligence, surveillance, and reconnaissance cooperation facility. Supports Nigerian counter-Boko Haram operations.', 9.0579, 7.4951, 'Lily-pad', 'Air Force', 'Active', 2015
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Abuja ISR Facility' AND country_name = 'Nigeria');

-- ========== SAO TOME & PRINCIPE ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'São Tomé Naval Cooperation', 'São Tomé and Príncipe', 'US Navy cooperation and maritime awareness facility in the Gulf of Guinea. Supports maritime domain awareness.', 0.3036, 6.7333, 'Lily-pad', 'Navy', 'Active', 2006
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'São Tomé Naval Cooperation' AND country_name = 'São Tomé and Príncipe');

-- ========== SEYCHELLES ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Seychelles International Airport', 'Seychelles', 'US drone operations base for Indian Ocean maritime surveillance and counter-piracy operations off the Horn of Africa.', -4.6743, 55.5218, 'Lily-pad', 'Air Force', 'Active', 2009
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Seychelles International Airport' AND country_name = 'Seychelles');

-- ========== ASCENSION ISLAND ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Ascension Auxiliary Air Field', 'United Kingdom', 'US Air Force tracking station and airfield on Ascension Island in the South Atlantic. Supports space surveillance and communications.', -7.9696, -14.3937, 'Small', 'Air Force/Space', 'Active', 1957
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Ascension Auxiliary Air Field' AND country_name = 'United Kingdom');

END $$;
