-- ============================================================
-- MILITARY BASES SEED: Part 2 - Asia-Pacific
-- Sources: David Vine (American University), GlobalSecurity.org
-- ============================================================

DO $$
BEGIN

-- ========== JAPAN (Largest US presence in Asia) ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Yokosuka Naval Base', 'Japan', 'Headquarters of US 7th Fleet, the largest forward-deployed US naval force. Home port to the aircraft carrier USS Ronald Reagan and 11 other warships. Key to US Pacific strategy.', 35.2830, 139.6720, 'Major', 'Navy', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Yokosuka Naval Base' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Yokota Air Base', 'Japan', 'Headquarters of US Forces Japan (USFJ) and 5th Air Force. Major airlift hub in the western Pacific.', 35.7485, 139.3485, 'Major', 'Air Force', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Yokota Air Base' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kadena Air Base', 'Japan', 'Largest US Air Force base in the Pacific. Located in Okinawa. Hosts F-15 fighters, KC-135 tankers, and surveillance aircraft. Called the "Keystone of the Pacific".', 26.3516, 127.7694, 'Major', 'Air Force', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kadena Air Base' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Marine Corps Air Station Iwakuni', 'Japan', 'USMC air station near Hiroshima. Home to Marine Aircraft Group 12 with F-35B Lightning IIs. Major Pacific aviation hub.', 34.1464, 132.2355, 'Major', 'Marines', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Marine Corps Air Station Iwakuni' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Butler / Marine Corps Bases Okinawa', 'Japan', 'Headquarters of III Marine Expeditionary Force (III MEF). Umbrella command for all Marine bases on Okinawa, the largest Marine presence outside the US.', 26.4600, 127.7740, 'Major', 'Marines', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Butler / Marine Corps Bases Okinawa' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Foster', 'Japan', 'Major Marine Corps installation on Okinawa. Hosts logistics, exchange, and administrative facilities for the Marine Corps community.', 26.3408, 127.7625, 'Medium', 'Marines', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Foster' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Hansen', 'Japan', 'Marine Corps infantry training base on Okinawa. Central Training Area for live-fire exercises.', 26.4397, 127.7750, 'Medium', 'Marines', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Hansen' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Schwab', 'Japan', 'Marine Corps base on Okinawa. Adjacent to the controversial Henoko sea-based facility replacement for MCAS Futenma.', 26.5300, 127.9397, 'Medium', 'Marines', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Schwab' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'MCAS Futenma', 'Japan', 'Controversial Marine Corps air station in densely populated Ginowan, Okinawa. Planned relocation to Camp Schwab/Henoko has been a major political issue since 1996.', 26.2742, 127.7556, 'Major', 'Marines', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'MCAS Futenma' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Courtney', 'Japan', 'Headquarters of III Marine Expeditionary Force on Okinawa. Houses the 3rd Marine Division command element.', 26.4467, 127.8072, 'Medium', 'Marines', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Courtney' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Sasebo Naval Base', 'Japan', 'US Navy base on Kyushu. Home to amphibious forces and mine countermeasures ships. Supports operations in the East and South China Seas.', 33.1600, 129.7100, 'Major', 'Navy', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Sasebo Naval Base' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Naval Air Facility Atsugi', 'Japan', 'US Navy air facility near Tokyo. Supports carrier air wing operations and helicopter squadrons. Being relocated.', 35.4547, 139.4497, 'Medium', 'Navy', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Naval Air Facility Atsugi' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Zama', 'Japan', 'Headquarters of US Army Japan (USARJ). Located near Tokyo, supports Army operations across the Pacific.', 35.4900, 139.3900, 'Medium', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Zama' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Misawa Air Base', 'Japan', 'US Air Force and Japanese Air Self-Defense Force shared base in northern Honshu. Hosts F-16 fighters and intelligence operations.', 40.7032, 141.3686, 'Major', 'Air Force', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Misawa Air Base' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Torii Station', 'Japan', 'US Army installation on Okinawa. Hosts Special Forces and signal intelligence units. Home to the 10th Support Group.', 26.3450, 127.7300, 'Small', 'Army/SOF', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Torii Station' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'White Beach Naval Facility', 'Japan', 'US Navy port facility on Okinawa. Supports amphibious ship operations and logistics.', 26.3339, 127.8422, 'Small', 'Navy', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'White Beach Naval Facility' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Kinser (Makiminato)', 'Japan', 'Marine Corps logistics base on Okinawa. Major supply and distribution center being returned to Japan.', 26.3200, 127.7100, 'Medium', 'Marines', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Kinser (Makiminato)' AND country_name = 'Japan');

-- ========== SOUTH KOREA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Humphreys', 'South Korea', 'Largest US military base overseas. Headquarters of US Forces Korea (USFK) and Eighth Army. Massive $11 billion expansion completed 2022. Houses over 36,000 personnel.', 36.9626, 127.0314, 'Major', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Humphreys' AND country_name = 'South Korea');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Osan Air Base', 'South Korea', 'US Air Force base south of Seoul. Home to the 51st Fighter Wing with A-10 and F-16 aircraft. First line of air defense for South Korea.', 37.0901, 127.0297, 'Major', 'Air Force', 'Active', 1952
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Osan Air Base' AND country_name = 'South Korea');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kunsan Air Base', 'South Korea', 'US Air Force base on the west coast. Home to the 8th Fighter Wing "Wolf Pack" with F-16 fighters.', 35.9022, 126.6158, 'Major', 'Air Force', 'Active', 1938
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kunsan Air Base' AND country_name = 'South Korea');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'US Naval Forces Korea (Busan)', 'South Korea', 'US Navy component command in Busan. Supports fleet logistics, maintenance, and naval operations in Korean waters.', 35.1028, 129.0403, 'Medium', 'Navy', 'Active', 1950
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'US Naval Forces Korea (Busan)' AND country_name = 'South Korea');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Carroll', 'South Korea', 'US Army logistics installation in Waegwan. Pre-positioned war reserve materiel site.', 35.9500, 128.3700, 'Medium', 'Army', 'Active', 1960
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Carroll' AND country_name = 'South Korea');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Casey', 'South Korea', 'US Army base near the DMZ in Dongducheon. Forward-deployed combat units. Being consolidated to Humphreys.', 37.9100, 127.0600, 'Medium', 'Army', 'Reduced', 1952
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Casey' AND country_name = 'South Korea');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Yongsan Garrison', 'South Korea', 'Historic US military headquarters in central Seoul. Former USFK HQ, now mostly relocated to Camp Humphreys. Being returned to South Korea.', 37.5310, 126.9810, 'Major', 'Army', 'Reduced', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Yongsan Garrison' AND country_name = 'South Korea');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Walker (Daegu)', 'South Korea', 'US Army garrison in Daegu. Supports Area IV operations and logistics in southeastern Korea.', 35.8492, 128.5872, 'Medium', 'Army', 'Active', 1950
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Walker (Daegu)' AND country_name = 'South Korea');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'THAAD Battery (Seongju)', 'South Korea', 'Terminal High Altitude Area Defense missile battery deployed in 2017. Controversial deployment opposed by China and some South Korean residents.', 35.9000, 128.1500, 'Small', 'Army/Missile Defense', 'Active', 2017
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'THAAD Battery (Seongju)' AND country_name = 'South Korea');

-- ========== GUAM (US Territory) ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Andersen Air Force Base', 'Guam', 'Major US Air Force base in the western Pacific. Strategic bomber hub with B-52, B-1B, and B-2 rotational deployments. Key to Indo-Pacific deterrence.', 13.5840, 144.9248, 'Major', 'Air Force', 'Active', 1944
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Andersen Air Force Base' AND country_name = 'Guam');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Naval Base Guam', 'Guam', 'Major US Navy submarine and surface ship base. Home to submarine squadron 15. Critical for Pacific fleet operations.', 13.4443, 144.6564, 'Major', 'Navy', 'Active', 1944
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Naval Base Guam' AND country_name = 'Guam');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Blaz (USMC)', 'Guam', 'New Marine Corps base under construction. Part of the Marine Corps realignment from Okinawa. Expected to host 5,000 Marines.', 13.5700, 144.8700, 'Major', 'Marines', 'Active', 2024
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Blaz (USMC)' AND country_name = 'Guam');

-- ========== AUSTRALIA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Pine Gap (Joint Defence Facility)', 'Australia', 'CIA/NSA joint signals intelligence facility near Alice Springs. Critical for missile early warning, satellite control, and signals intelligence collection.', -23.7990, 133.7370, 'Major', 'Intelligence/NSA', 'Active', 1970
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Pine Gap (Joint Defence Facility)' AND country_name = 'Australia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'RAAF Base Darwin', 'Australia', 'Australian Air Force base with expanding US Marine rotational presence under AUKUS/Force Posture Initiatives. Up to 2,500 Marines rotate through annually.', -12.4147, 130.8765, 'Medium', 'Marines', 'Active', 2012
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'RAAF Base Darwin' AND country_name = 'Australia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'RAAF Base Tindal', 'Australia', 'Australian Air Force base with US bomber and fighter rotational deployments. B-52 operations expanding under force posture agreement.', -14.5214, 132.3781, 'Medium', 'Air Force', 'Active', 2022
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'RAAF Base Tindal' AND country_name = 'Australia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'North West Cape (Harold E. Holt)', 'Australia', 'Naval communication station supporting submarine communications. Joint US-Australian facility for very low frequency transmissions.', -21.8161, 114.1653, 'Small', 'Navy', 'Active', 1967
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'North West Cape (Harold E. Holt)' AND country_name = 'Australia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'HMAS Stirling (AUKUS submarine base)', 'Australia', 'Australian naval base near Perth. Under AUKUS agreement, will host US and UK nuclear-powered submarines from 2027.', -32.3289, 115.6817, 'Medium', 'Navy', 'Active', 2023
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'HMAS Stirling (AUKUS submarine base)' AND country_name = 'Australia');

-- ========== PHILIPPINES ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Antonio Bautista Air Base (Palawan)', 'Philippines', 'Philippine Air Force base with US access under EDCA. Strategic location near the South China Sea / Spratly Islands.', 9.7422, 118.7589, 'Access Agreement', 'Air Force', 'Active', 2023
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Antonio Bautista Air Base (Palawan)' AND country_name = 'Philippines');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Basa Air Base', 'Philippines', 'Philippine Air Force base with US EDCA access near Manila. Supports bilateral exercises and humanitarian operations.', 15.4875, 120.5597, 'Access Agreement', 'Air Force', 'Active', 2016
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Basa Air Base' AND country_name = 'Philippines');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Fort Magsaysay', 'Philippines', 'Major Philippine Army training area with US access under EDCA for joint exercises. Largest military reservation in the Philippines.', 15.4500, 121.0000, 'Access Agreement', 'Army', 'Active', 2016
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Fort Magsaysay' AND country_name = 'Philippines');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Lumbia Airport (Cagayan de Oro)', 'Philippines', 'Philippine military/civilian airport with US EDCA access in Mindanao. Supports operations in the southern Philippines.', 8.6122, 124.6111, 'Access Agreement', 'Air Force', 'Active', 2016
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Lumbia Airport (Cagayan de Oro)' AND country_name = 'Philippines');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Lal-lo Airport (Cagayan)', 'Philippines', 'Philippine airfield with US EDCA access in northern Luzon. Near Taiwan and the Luzon Strait, strategic for contingencies.', 18.1833, 121.7333, 'Access Agreement', 'Air Force', 'Active', 2023
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Lal-lo Airport (Cagayan)' AND country_name = 'Philippines');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camilo Osias Naval Base (Santa Ana, Cagayan)', 'Philippines', 'Philippine Navy base with US EDCA access. Northernmost EDCA site, 250km from Taiwan. Strategic for Indo-Pacific contingencies.', 18.4900, 122.1500, 'Access Agreement', 'Navy', 'Active', 2023
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camilo Osias Naval Base (Santa Ana, Cagayan)' AND country_name = 'Philippines');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Balabac Island (Palawan)', 'Philippines', 'Philippine military site with US EDCA access. Southernmost site near the Spratly Islands and Borneo.', 7.9833, 117.0500, 'Access Agreement', 'Navy', 'Active', 2023
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Balabac Island (Palawan)' AND country_name = 'Philippines');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Mactan-Benito Ebuen Air Base', 'Philippines', 'Philippine Air Force base near Cebu with US EDCA access. Supports airlift and humanitarian assistance operations.', 10.3117, 123.9792, 'Access Agreement', 'Air Force', 'Active', 2016
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Mactan-Benito Ebuen Air Base' AND country_name = 'Philippines');

-- ========== SINGAPORE ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Changi Naval Base', 'Singapore', 'US Navy logistics facility at Changi. Littoral Combat Ships (LCS) rotate through. Key access point for the Strait of Malacca.', 1.3290, 103.9750, 'Medium', 'Navy', 'Active', 1990
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Changi Naval Base' AND country_name = 'Singapore');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Paya Lebar Air Base', 'Singapore', 'Singapore Air Force base with rotational US Air Force presence. Supports F-16 and P-8 deployments.', 1.3604, 103.9097, 'Small', 'Air Force', 'Active', 1992
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Paya Lebar Air Base' AND country_name = 'Singapore');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Sembawang Wharves', 'Singapore', 'US Navy logistics and ship maintenance facility. Former British Royal Navy base repurposed for US access.', 1.4600, 103.8200, 'Small', 'Navy', 'Active', 1992
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Sembawang Wharves' AND country_name = 'Singapore');

-- ========== MARSHALL ISLANDS & PACIFIC ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kwajalein Atoll (Reagan Test Site)', 'Marshall Islands', 'US Army missile testing range. Part of the ballistic missile defense test infrastructure. Also hosts space surveillance radar.', 8.7200, 167.7300, 'Major', 'Army/Space', 'Active', 1964
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kwajalein Atoll (Reagan Test Site)' AND country_name = 'Marshall Islands');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Wake Island Airfield', 'US Pacific', 'Remote Pacific airfield used as emergency divert strip and missile defense testing support. Strategic mid-Pacific location.', 19.2825, 166.6522, 'Small', 'Air Force', 'Active', 1941
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Wake Island Airfield' AND country_name = 'US Pacific');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Joint Base Pearl Harbor-Hickam', 'Hawaii', 'Headquarters of US Indo-Pacific Command (INDOPACOM). The most important US military hub in the Pacific. Controls all US forces from India to the International Date Line.', 21.3535, -157.9576, 'Major', 'Navy/Air Force', 'Active', 1899
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Joint Base Pearl Harbor-Hickam' AND country_name = 'Hawaii');

-- ========== PALAU ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Palau Compact Military Access', 'Palau', 'Under Compact of Free Association, the US has exclusive military access rights to Palau. Planned radar installations and airfield improvements.', 7.5150, 134.5825, 'Lily-pad', 'Joint', 'Active', 1994
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Palau Compact Military Access' AND country_name = 'Palau');

-- ========== FEDERATED STATES OF MICRONESIA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'FSM Compact Military Access', 'Micronesia', 'Under Compact of Free Association, the US has exclusive military access rights. Strategic denial area in the central Pacific.', 6.8874, 158.2150, 'Lily-pad', 'Joint', 'Active', 1986
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'FSM Compact Military Access' AND country_name = 'Micronesia');

-- ========== THAILAND ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Utapao Royal Thai Navy Airfield', 'Thailand', 'Former major US bomber base during Vietnam War. Now Thai-operated with periodic US access for Cobra Gold exercises and humanitarian operations.', 12.6799, 101.0050, 'Access Agreement', 'Navy/Air Force', 'Active', 1966
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Utapao Royal Thai Navy Airfield' AND country_name = 'Thailand');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Akatosarot (Phitsanulok)', 'Thailand', 'Thai Army base used for annual Cobra Gold military exercises. US prepositioned equipment storage.', 16.7800, 100.2700, 'Lily-pad', 'Army', 'Active', 2002
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Akatosarot (Phitsanulok)' AND country_name = 'Thailand');

-- ========== INDIA (Diego Garcia listed under UK) ==========

-- ========== INDONESIA ==========
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Halim Perdanakusuma (Jakarta)', 'Indonesia', 'Indonesian Air Force base with periodic US military cooperation for exercises and humanitarian assistance.', -6.2667, 106.8911, 'Lily-pad', 'Air Force', 'Active', 2010
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Halim Perdanakusuma (Jakarta)' AND country_name = 'Indonesia');

END $$;
