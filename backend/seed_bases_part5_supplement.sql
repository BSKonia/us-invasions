-- ============================================================
-- MILITARY BASES SEED: Part 5 - Supplementary (Missing installations)
-- Sources: USFJ official facility list (Wikipedia/DoD), USFK components,
--          David Vine (American University), GlobalSecurity.org,
--          The Intercept (Africa), High North News (Nordic),
--          Library of Congress/GAO (Vietnam)
-- Run AFTER parts 1-4
-- ============================================================

DO $$
BEGIN

-- ================================================================
-- JAPAN - Additional facilities from USFJ official list
-- Japan hosts ~85 named current US facilities; we had 22
-- ================================================================

-- Air Force facilities in Japan (missing)
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Fuchu Communications Station', 'Japan', 'USAF communications station in Fuchu, Tokyo. Former USFJ headquarters location until 1974.', 35.6720, 139.4770, 'Small', 'Air Force', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Fuchu Communications Station' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Tama Hills Recreation Center', 'Japan', 'USAF Tama Service Annex. Recreation and support facility for US military personnel in the Kanto region.', 35.6270, 139.3700, 'Small', 'Air Force', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Tama Hills Recreation Center' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Owada Communication Site', 'Japan', 'USAF communications facility in Niiza, Saitama. Part of the US military communications network in Japan.', 35.7940, 139.5640, 'Small', 'Air Force', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Owada Communication Site' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Yugi Communication Site', 'Japan', 'USAF communications facility in Hachioji, Tokyo.', 35.6560, 139.3260, 'Small', 'Air Force', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Yugi Communication Site' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kadena Ammunition Storage Area', 'Japan', 'Ammunition storage facility supporting Kadena Air Base operations in Onna, Okinawa.', 26.4400, 127.7200, 'Small', 'Air Force', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kadena Ammunition Storage Area' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Okuma Rest Center', 'Japan', 'USAF recreation facility in Kunigami, northern Okinawa. R&R facility for US military personnel.', 26.7340, 128.1560, 'Small', 'Air Force', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Okuma Rest Center' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Yaedake Communication Site', 'Japan', 'USAF communications facility in Motobu, Okinawa.', 26.6570, 127.9010, 'Small', 'Air Force', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Yaedake Communication Site' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Itazuke Auxiliary Airfield', 'Japan', 'USAF air cargo terminal at Hakata, Fukuoka. Auxiliary airfield for logistics operations.', 33.5850, 130.4510, 'Small', 'Air Force', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Itazuke Auxiliary Airfield' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Chitose', 'Japan', 'USAF communications and administration annex in Chitose, Hokkaido.', 42.8230, 141.6510, 'Small', 'Air Force', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Chitose' AND country_name = 'Japan');

-- Army facilities in Japan (missing)
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Shariki Communication Site', 'Japan', 'US Army AN/TPY-2 radar station in Tsugaru, Aomori. Part of ballistic missile defense network.', 40.8810, 140.3340, 'Small', 'Army', 'Active', 2006
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Shariki Communication Site' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Akasaka Press Center (Hardy Barracks)', 'Japan', 'US Army office facility in Minato, central Tokyo. Administrative and press operations.', 35.6700, 139.7380, 'Small', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Akasaka Press Center (Hardy Barracks)' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Yokohama North Dock', 'Japan', 'US Army port facility in Yokohama. Key logistics and port operations facility.', 35.4600, 139.6450, 'Small', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Yokohama North Dock' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Sagami General Depot', 'Japan', 'US Army logistics depot in Sagamihara, Kanagawa. Major supply and maintenance facility.', 35.5560, 139.3840, 'Medium', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Sagami General Depot' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kyogamisaki Communication Site', 'Japan', 'US Army AN/TPY-2 X-band radar station in Kyotango, Kyoto. Ballistic missile defense.', 35.7590, 135.1320, 'Small', 'Army', 'Active', 2013
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kyogamisaki Communication Site' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Akizuki Ammunition Depot', 'Japan', 'US Army ammunition storage in Etajima, Hiroshima.', 34.2230, 132.4510, 'Small', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Akizuki Ammunition Depot' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Naha Port', 'Japan', 'US Army port facility in Naha, Okinawa. Military logistics port operations.', 26.2170, 127.6710, 'Small', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Naha Port' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Gesaji Communication Site', 'Japan', 'US Army communications facility in Higashi, Okinawa.', 26.6280, 128.1210, 'Small', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Gesaji Communication Site' AND country_name = 'Japan');

-- Navy facilities in Japan (missing)
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Fleet Activities Yokosuka', 'Japan', 'Headquarters of US 7th Fleet. Largest US naval installation in the western Pacific. Homeport for aircraft carrier USS Ronald Reagan.', 35.2830, 139.6580, 'Major', 'Navy', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Fleet Activities Yokosuka' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Fleet Activities Sasebo', 'Japan', 'US Navy fleet base in Sasebo, Nagasaki. Homeport for amphibious ships and mine countermeasures vessels.', 33.1600, 129.7200, 'Major', 'Navy', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Fleet Activities Sasebo' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Iwo Jima Communication Site', 'Japan', 'US Navy communications and training facility on Iwo Jima (Ioto), Ogasawara. Remote Pacific communications relay.', 24.7840, 141.3220, 'Small', 'Navy', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Iwo Jima Communication Site' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'New Sanno Hotel', 'Japan', 'US Navy forces recreation and lodging center in Minato, Tokyo. Joint officers club and hotel.', 35.6380, 139.7280, 'Small', 'Navy', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'New Sanno Hotel' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Tengan Pier', 'Japan', 'US Navy port facility in Uruma, Okinawa. Naval logistics pier.', 26.4360, 127.8310, 'Small', 'Navy', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Tengan Pier' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Shields', 'Japan', 'US Navy barracks and support facility in Okinawa City, Okinawa.', 26.3400, 127.7800, 'Small', 'Navy', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Shields' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Awase Communications Station', 'Japan', 'US Navy communications facility in Okinawa City.', 26.3350, 127.7920, 'Small', 'Navy', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Awase Communications Station' AND country_name = 'Japan');

-- Marine Corps facilities in Japan (missing)
INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Gonsalves (JWTC)', 'Japan', 'Marine Corps Jungle Warfare Training Center in Kunigami, northern Okinawa. Largest USMC training area in Okinawa.', 26.7530, 128.2120, 'Medium', 'Marines', 'Active', 1958
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Gonsalves (JWTC)' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Fuji', 'Japan', 'USMC training facility at the base of Mount Fuji in Gotenba, Shizuoka. Combined arms training.', 35.2680, 138.8080, 'Medium', 'Marines', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Fuji' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Henoko Ordnance Ammunition Depot', 'Japan', 'USMC ammunition storage facility in Nago, Okinawa.', 26.5340, 127.9770, 'Small', 'Marines', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Henoko Ordnance Ammunition Depot' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kin Red Beach Training Area', 'Japan', 'USMC amphibious training beach in Kin, Okinawa.', 26.4500, 127.9300, 'Small', 'Marines', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kin Red Beach Training Area' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kin Blue Beach Training Area', 'Japan', 'USMC amphibious training beach in Kin, Okinawa.', 26.4540, 127.9280, 'Small', 'Marines', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kin Blue Beach Training Area' AND country_name = 'Japan');

-- ================================================================
-- SOUTH KOREA - Additional facilities from USFK components
-- ================================================================

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp George', 'South Korea', 'US Army garrison support installation in Daegu. Housing and support area for USAG Daegu.', 35.8530, 128.5870, 'Medium', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp George' AND country_name = 'South Korea');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Henry', 'South Korea', 'US Army garrison headquarters in Daegu (Nam-gu). Administrative center for USAG Daegu.', 35.8470, 128.5940, 'Medium', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Henry' AND country_name = 'South Korea');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Commander Fleet Activities Chinhae', 'South Korea', 'US Navy facility in Jinhae/Changwon. Support base for US naval operations in the Korean theater.', 35.1340, 128.6670, 'Medium', 'Navy', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Commander Fleet Activities Chinhae' AND country_name = 'South Korea');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Mujuk', 'South Korea', 'Only US Marine Corps base in South Korea. Located in Pohang. Forward training base for US and ROK Marines.', 35.9820, 129.3960, 'Medium', 'Marines', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Mujuk' AND country_name = 'South Korea');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'K-2 Airfield (Daegu Air Base)', 'South Korea', 'USAF/ROKAF airfield at Daegu International Airport. Seventh Air Force operations.', 35.8940, 128.6580, 'Medium', 'Air Force', 'Active', 1950
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'K-2 Airfield (Daegu Air Base)' AND country_name = 'South Korea');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Liberty Bell', 'South Korea', 'US Army camp near the DMZ. Forward-positioned installation.', 37.9380, 126.9200, 'Small', 'Army', 'Active', 1953
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Liberty Bell' AND country_name = 'South Korea');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Bonifas', 'South Korea', 'US Army camp adjacent to the Joint Security Area at Panmunjom. Closest military installation to North Korea.', 37.9410, 126.6770, 'Small', 'Army', 'Active', 1953
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Bonifas' AND country_name = 'South Korea');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Pier 8 Busan', 'South Korea', 'US Army logistics and port facility in Busan. Major supply chain hub for USFK.', 35.1020, 129.0380, 'Medium', 'Army', 'Active', 1950
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Pier 8 Busan' AND country_name = 'South Korea');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Mobile', 'South Korea', 'US Army forward camp near the DMZ.', 37.8950, 127.0200, 'Small', 'Army', 'Active', 1953
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Mobile' AND country_name = 'South Korea');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Long Jon', 'South Korea', 'US Army forward camp near Wonju.', 37.3400, 127.9500, 'Small', 'Army', 'Active', 1953
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Long Jon' AND country_name = 'South Korea');

-- ================================================================
-- GERMANY - Additional documented installations
-- ================================================================

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Coleman Barracks', 'Germany', 'US Army installation in Mannheim. Pre-positioned war reserve stocks and logistics.', 49.5120, 8.5170, 'Medium', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Coleman Barracks' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kleber Kaserne', 'Germany', 'US Army installation in Kaiserslautern. Administrative and support facility.', 49.4360, 7.7510, 'Medium', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kleber Kaserne' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Pulaski Barracks', 'Germany', 'US Army installation in Kaiserslautern. Shopping and community services hub.', 49.4330, 7.7340, 'Small', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Pulaski Barracks' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Lucius D. Clay Kaserne (Wiesbaden Airfield)', 'Germany', 'US Army airfield adjacent to Clay Kaserne in Wiesbaden. Tactical airlift operations.', 50.0490, 8.3260, 'Medium', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Lucius D. Clay Kaserne (Wiesbaden Airfield)' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Tower Barracks (Dulmen)', 'Germany', 'US Army installation in Dulmen. Training and storage facility.', 51.8290, 7.2820, 'Small', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Tower Barracks (Dulmen)' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Germersheim Army Depot', 'Germany', 'US Army supply depot in Germersheim. Pre-positioned stocks storage.', 49.2230, 8.3690, 'Small', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Germersheim Army Depot' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kelley Barracks (Stuttgart)', 'Germany', 'Headquarters of US Africa Command (AFRICOM) and US European Command (EUCOM).', 48.7320, 9.1640, 'Major', 'Multi-service', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kelley Barracks (Stuttgart)' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Robinson Barracks (Stuttgart)', 'Germany', 'US Army housing and support installation in Stuttgart.', 48.8210, 9.1940, 'Small', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Robinson Barracks (Stuttgart)' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Netzaberg Housing Area', 'Germany', 'US Army family housing in Grafenwöhr area. Major residential community.', 49.7080, 11.9760, 'Small', 'Army', 'Active', 2010
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Netzaberg Housing Area' AND country_name = 'Germany');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Oberdachstetten Training Area', 'Germany', 'US Army training area in Bavaria. Field training and maneuver exercises.', 49.4100, 10.4050, 'Small', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Oberdachstetten Training Area' AND country_name = 'Germany');

-- ================================================================
-- UNITED KINGDOM - Additional facilities
-- ================================================================

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'RAF Welford', 'United Kingdom', 'US Air Force ammunition storage depot in Berkshire. Largest ammunition depot in Western Europe.', 51.4070, -1.4430, 'Medium', 'Air Force', 'Active', 1955
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'RAF Welford' AND country_name = 'United Kingdom');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'RAF Barford St John', 'United Kingdom', 'USAF communications relay facility in Oxfordshire.', 51.9860, -1.3470, 'Small', 'Air Force', 'Active', 1955
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'RAF Barford St John' AND country_name = 'United Kingdom');

-- ================================================================
-- ITALY - Additional facilities
-- ================================================================

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Ghedi Air Base', 'Italy', 'Italian Air Force base with US nuclear weapons storage under NATO nuclear sharing agreement.', 45.4320, 10.2800, 'Medium', 'Air Force', 'Active', 1955
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Ghedi Air Base' AND country_name = 'Italy');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Dal Molin (Del Din) Airfield', 'Italy', 'US Army airfield in Vicenza. Part of expanded SETAF garrison.', 45.5740, 11.5290, 'Small', 'Army', 'Active', 2013
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Dal Molin (Del Din) Airfield' AND country_name = 'Italy');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'NAS Capodichino', 'Italy', 'US Navy support facility at Capodichino airport in Naples. Part of NSA Naples complex.', 40.8840, 14.2900, 'Small', 'Navy', 'Active', 1951
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'NAS Capodichino' AND country_name = 'Italy');

-- ================================================================
-- VIETNAM - Additional major named bases (Vietnam War era)
-- ================================================================

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Chu Lai Base', 'Vietnam', 'Major US Marine Corps/Army base in Quang Tin Province. Site of first Marine offensive operation in Vietnam.', 15.4060, 108.7030, 'Major', 'Marines', 'Closed', 1965
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Chu Lai Base' AND country_name = 'Vietnam');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Phu Cat Air Base', 'Vietnam', 'USAF air base in Binh Dinh Province. Fighter-bomber operations during Vietnam War.', 13.9960, 109.0420, 'Medium', 'Air Force', 'Closed', 1966
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Phu Cat Air Base' AND country_name = 'Vietnam');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Nha Trang Air Base', 'Vietnam', 'USAF base in Nha Trang. Special Forces headquarters and training center.', 12.2280, 109.1920, 'Medium', 'Air Force', 'Closed', 1962
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Nha Trang Air Base' AND country_name = 'Vietnam');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Pleiku Air Base', 'Vietnam', 'US Army/USAF base in Central Highlands. Key strategic location during Vietnam War.', 13.9830, 108.0170, 'Medium', 'Army', 'Closed', 1962
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Pleiku Air Base' AND country_name = 'Vietnam');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Tuy Hoa Air Base', 'Vietnam', 'USAF fighter base in Phu Yen Province.', 13.0480, 109.3280, 'Medium', 'Air Force', 'Closed', 1966
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Tuy Hoa Air Base' AND country_name = 'Vietnam');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Qui Nhon Base', 'Vietnam', 'US Army logistics and port base in Binh Dinh Province. Major supply depot.', 13.7700, 109.2260, 'Medium', 'Army', 'Closed', 1965
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Qui Nhon Base' AND country_name = 'Vietnam');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'An Khe Base Camp', 'Vietnam', 'US Army 1st Cavalry Division base camp in the Central Highlands. Golf Course heliport.', 13.9550, 108.6520, 'Major', 'Army', 'Closed', 1965
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'An Khe Base Camp' AND country_name = 'Vietnam');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Cu Chi Base Camp', 'Vietnam', 'US Army 25th Infantry Division base camp northwest of Saigon. Built above Viet Cong tunnel network.', 11.0320, 106.4930, 'Major', 'Army', 'Closed', 1966
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Cu Chi Base Camp' AND country_name = 'Vietnam');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Dong Ha Combat Base', 'Vietnam', 'US Marine Corps forward base near the DMZ in Quang Tri Province. Frontline base during Tet Offensive.', 16.8240, 107.0950, 'Medium', 'Marines', 'Closed', 1966
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Dong Ha Combat Base' AND country_name = 'Vietnam');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Vung Tau Base', 'Vietnam', 'US Army logistics and R&R base on the coast southeast of Saigon.', 10.3500, 107.0840, 'Medium', 'Army', 'Closed', 1962
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Vung Tau Base' AND country_name = 'Vietnam');

-- ================================================================
-- AFRICA - Additional from The Intercept / Nick Turse reporting
-- ================================================================

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Chabelley Airfield (Djibouti Drone Base)', 'Djibouti', 'Secondary US drone operations base near Camp Lemonnier. Primarily used for MQ-9 Reaper operations over Yemen and Somalia.', 11.5170, 43.0600, 'Medium', 'Air Force', 'Active', 2013
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Chabelley Airfield (Djibouti Drone Base)' AND country_name = 'Djibouti');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Manda Bay Annex', 'Kenya', 'Additional support facility adjacent to Camp Simba at Manda Bay. Drone operations and ISR.', -2.2520, 40.9130, 'Small', 'Multi-service', 'Active', 2004
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Manda Bay Annex' AND country_name = 'Kenya');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Garoua-Boulai Forward Base', 'Cameroon', 'US forward operating location in eastern Cameroon near Central African Republic border.', 5.8830, 14.5370, 'Lily-pad', 'Multi-service', 'Active', 2015
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Garoua-Boulai Forward Base' AND country_name = 'Cameroon');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Djermaya Cooperation Site', 'Chad', 'US-Chad military cooperation facility northeast of N''Djamena.', 12.3190, 15.1250, 'Lily-pad', 'Multi-service', 'Active', 2014
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Djermaya Cooperation Site' AND country_name = 'Chad');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Arlit Drone Base', 'Niger', 'Small US ISR facility in uranium-mining town of Arlit, northern Niger.', 18.7370, 7.3860, 'Lily-pad', 'Air Force', 'Reduced', 2014
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Arlit Drone Base' AND country_name = 'Niger');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Ouallam Base', 'Niger', 'Cooperation security location in Ouallam near Mali border. Training and advisory.', 14.3130, 2.0830, 'Lily-pad', 'Army', 'Reduced', 2013
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Ouallam Base' AND country_name = 'Niger');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Dire Dawa Airfield', 'Ethiopia', 'US access to airfield in Dire Dawa for drone and ISR operations in the Horn of Africa.', 9.6270, 41.8540, 'Lily-pad', 'Air Force', 'Active', 2007
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Dire Dawa Airfield' AND country_name = 'Ethiopia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Nzara Cooperation Site (South Sudan)', 'South Sudan', 'US advisory and training site in Western Equatoria.', 4.2170, 28.5170, 'Lily-pad', 'Army', 'Reduced', 2011
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Nzara Cooperation Site (South Sudan)' AND country_name = 'South Sudan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Gaborone CSL', 'Botswana', 'Cooperation security location in Gaborone. Training partnership with Botswana Defence Force.', -24.6540, 25.9220, 'Lily-pad', 'Multi-service', 'Active', 2008
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Gaborone CSL' AND country_name = 'Botswana');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kasenyi Training Site', 'Uganda', 'US military training facility adjacent to Entebbe. Special operations advisory.', 0.0770, 32.5220, 'Lily-pad', 'Army', 'Active', 2010
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kasenyi Training Site' AND country_name = 'Uganda');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kismaayo Airfield', 'Somalia', 'US-accessed airfield in southern Somalia. Counter-terrorism operations support.', -0.3530, 42.4590, 'Lily-pad', 'Multi-service', 'Active', 2014
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kismaayo Airfield' AND country_name = 'Somalia');

-- ================================================================
-- MIDDLE EAST - Additional documented facilities
-- ================================================================

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Al-Tanf Border Crossing', 'Iraq', 'US garrison at the Iraq-Jordan-Syria tri-border area. Strategic checkpoint and training.', 33.5050, 38.9740, 'Small', 'Army', 'Active', 2016
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Al-Tanf Border Crossing' AND country_name = 'Iraq');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Ain al-Asad Air Base', 'Iraq', 'Major US air base in Al Anbar Province. One of the largest US military facilities in Iraq.', 33.7990, 42.4430, 'Major', 'Air Force', 'Active', 2003
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Ain al-Asad Air Base' AND country_name = 'Iraq');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'King Fahd Air Base', 'Saudi Arabia', 'Major deployment base used during Gulf War and subsequent operations. Near Taif.', 21.4830, 40.5430, 'Major', 'Air Force', 'Closed', 1990
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'King Fahd Air Base' AND country_name = 'Saudi Arabia');

-- ================================================================
-- LATIN AMERICA / CARIBBEAN - Additional
-- ================================================================

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Belize Defence Force (BDF) Training Support', 'Belize', 'US military training cooperation with Belize Defence Force. Jungle warfare training.', 17.2530, -88.7590, 'Access Agreement', 'Army', 'Active', 1994
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Belize Defence Force (BDF) Training Support' AND country_name = 'Belize');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Liberia Costa Rica Naval Cooperation', 'Costa Rica', 'US naval cooperation facility at Liberia airport. Counter-narcotics operations.', 10.5930, -85.5440, 'Access Agreement', 'Navy', 'Active', 2010
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Liberia Costa Rica Naval Cooperation' AND country_name = 'Costa Rica');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Reina Beatrix Airport FOL (Aruba Annex)', 'Aruba', 'Forward Operating Location extension at Reina Beatrix Airport. Counter-narcotics aerial surveillance.', 12.5010, -70.0150, 'Lily-pad', 'Air Force', 'Active', 2000
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Reina Beatrix Airport FOL (Aruba Annex)' AND country_name = 'Aruba');

-- ================================================================
-- PACIFIC - Additional documented installations
-- ================================================================

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Joint Region Marianas', 'Guam', 'Joint regional command overseeing all US military activities on Guam and the Northern Mariana Islands.', 13.4550, 144.7940, 'Major', 'Navy', 'Active', 2009
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Joint Region Marianas' AND country_name = 'Guam');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Pagan Island (CNMI Training Range)', 'Northern Mariana Islands', 'Proposed live-fire training range on Pagan Island. Part of USMC Pacific buildup.', 18.1220, 145.7710, 'Access Agreement', 'Marines', 'Active', 2015
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Pagan Island (CNMI Training Range)' AND country_name = 'Northern Mariana Islands');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Angaur Airfield (Palau)', 'Palau', 'US compact access to WWII-era airfield on Angaur Island. Strategic Pacific positioning.', 6.9100, 134.1420, 'Access Agreement', 'Multi-service', 'Active', 1994
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Angaur Airfield (Palau)' AND country_name = 'Palau');

-- ================================================================
-- ADDITIONAL EUROPE - Smaller/newer installations
-- ================================================================

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Bemowo Piskie Training Area', 'Poland', 'US Army enhanced forward presence battlegroup location in northeastern Poland near Kaliningrad.', 53.8700, 21.5500, 'Small', 'Army', 'Active', 2017
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Bemowo Piskie Training Area' AND country_name = 'Poland');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Cincu Training Center', 'Romania', 'NATO Multinational Division Southeast training center with US rotation.', 45.9480, 24.6650, 'Small', 'Army', 'Active', 2017
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Cincu Training Center' AND country_name = 'Romania');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Novo Selo Range (Bulgaria Annex)', 'Bulgaria', 'Additional US training range area adjacent to Novo Selo. Live-fire exercises.', 42.0900, 26.1500, 'Small', 'Army', 'Active', 2006
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Novo Selo Range (Bulgaria Annex)' AND country_name = 'Bulgaria');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Skanderborg Barracks', 'Denmark', 'US forward presence rotation in Denmark under Defense Cooperation Agreement signed 2023.', 56.0380, 9.9270, 'Access Agreement', 'Army', 'Active', 2023
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Skanderborg Barracks' AND country_name = 'Denmark');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Bondsteel Annex (Kosovo)', 'Kosovo', 'Support annex near Camp Bondsteel for logistics operations.', 42.3560, 21.2520, 'Small', 'Army', 'Active', 1999
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Bondsteel Annex (Kosovo)' AND country_name = 'Kosovo');

-- ================================================================
-- AUSTRALIA - Additional AUKUS-era facilities
-- ================================================================

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Robertson Barracks (Darwin)', 'Australia', 'US Marine Rotational Force-Darwin (MRF-D) base. Up to 2,500 Marines rotating annually.', -12.4380, 130.8720, 'Medium', 'Marines', 'Active', 2012
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Robertson Barracks (Darwin)' AND country_name = 'Australia');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Cocos (Keeling) Islands Airfield', 'Australia', 'USAF access to remote Indian Ocean airfield under AUKUS force posture initiatives.', -12.1880, 96.8340, 'Access Agreement', 'Air Force', 'Active', 2023
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Cocos (Keeling) Islands Airfield' AND country_name = 'Australia');

-- ================================================================
-- THAILAND - Additional historical (some were already included)
-- ================================================================

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Don Muang Royal Thai Air Force Base', 'Thailand', 'USAF operations base in Bangkok during Vietnam War. Major airlift hub.', 13.9130, 100.6010, 'Medium', 'Air Force', 'Closed', 1962
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Don Muang Royal Thai Air Force Base' AND country_name = 'Thailand');

-- ================================================================
-- SPAIN - Additional
-- ================================================================

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'San Pablo Air Base (Seville)', 'Spain', 'Former US Air Force base near Seville. Major Cold War strategic bomber base until 1992.', 37.4180, -5.8930, 'Medium', 'Air Force', 'Closed', 1953
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'San Pablo Air Base (Seville)' AND country_name = 'Spain');

-- ================================================================
-- GREECE - Additional
-- ================================================================

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Litochoro Training Site', 'Greece', 'US Army firing range and training site near Mount Olympus under US-Greece MDCA.', 40.1040, 22.4960, 'Small', 'Army', 'Active', 2022
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Litochoro Training Site' AND country_name = 'Greece');

-- ================================================================
-- PHILIPPINES - Additional EDCA sites
-- ================================================================

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Melchor dela Cruz', 'Philippines', 'Enhanced Defense Cooperation Agreement (EDCA) site in Gamu, Isabela. Expanded 2023.', 17.0530, 121.8320, 'Access Agreement', 'Multi-service', 'Active', 2023
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Melchor dela Cruz' AND country_name = 'Philippines');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Naval Base Camilo Osias (Santa Ana)', 'Philippines', 'EDCA naval site in Santa Ana, Cagayan facing the Luzon Strait. Closest EDCA site to Taiwan.', 18.4930, 122.1530, 'Access Agreement', 'Navy', 'Active', 2023
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Naval Base Camilo Osias (Santa Ana)' AND country_name = 'Philippines');

-- ================================================================
-- JAPAN - Even more facilities from the USFJ list
-- ================================================================

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Sagamihara Housing Area', 'Japan', 'US Army family housing area in Sagamihara, Kanagawa.', 35.5550, 139.3960, 'Small', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Sagamihara Housing Area' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kawakami Ammunition Depot', 'Japan', 'US Army ammunition storage in Higashihiroshima, Hiroshima.', 34.4160, 132.6830, 'Small', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kawakami Ammunition Depot' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Hiro Ammunition Depot', 'Japan', 'US Army ammunition storage in Kure, Hiroshima.', 34.2310, 132.5870, 'Small', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Hiro Ammunition Depot' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kure Pier No. 6', 'Japan', 'US Army port facility in Kure, Hiroshima.', 34.2350, 132.5640, 'Small', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kure Pier No. 6' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Haigamine Communication Site', 'Japan', 'US Army communications facility in Kure, Hiroshima.', 34.2540, 132.5710, 'Small', 'Army', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Haigamine Communication Site' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Tokorozawa Communications Station', 'Japan', 'USAF transmitter site in Tokorozawa, Saitama.', 35.7900, 139.4700, 'Small', 'Air Force', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Tokorozawa Communications Station' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Sofu Communication Site (Iwakuni)', 'Japan', 'USAF communications facility supporting MCAS Iwakuni.', 34.1440, 132.2350, 'Small', 'Air Force', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Sofu Communication Site (Iwakuni)' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Sefurisan Liaison Annex', 'Japan', 'USAF communications station in Kanzaki, Saga Prefecture.', 33.4240, 130.3150, 'Small', 'Air Force', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Sefurisan Liaison Annex' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Tsushima Communication Site', 'Japan', 'USAF communications facility on Tsushima Island, Nagasaki.', 34.2000, 129.3500, 'Small', 'Air Force', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Tsushima Communication Site' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Kisarazu Auxiliary Landing Field', 'Japan', 'US Navy air facility in Kisarazu, Chiba. Auxiliary landing field for V-22 Osprey operations.', 35.3980, 139.9100, 'Small', 'Navy', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Kisarazu Auxiliary Landing Field' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Ikego Housing Area', 'Japan', 'US Navy family housing and annex in Zushi, Kanagawa.', 35.3050, 139.5800, 'Small', 'Navy', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Ikego Housing Area' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Numazu Training Area', 'Japan', 'USMC training area in Numazu, Shizuoka.', 35.1130, 138.8730, 'Small', 'Marines', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Numazu Training Area' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Tsuken Jima Training Area', 'Japan', 'USMC training area on Tsuken Island, Uruma, Okinawa.', 26.3280, 127.8680, 'Small', 'Marines', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Tsuken Jima Training Area' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Hachinohe POL Depot', 'Japan', 'US Navy petroleum/oil/lubricants storage in Hachinohe, Aomori.', 40.5320, 141.5020, 'Small', 'Navy', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Hachinohe POL Depot' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Navy NCTS Sicily (Niscemi)', 'Italy', 'US Navy satellite communications station (MUOS) near Niscemi, Sicily. Global satellite relay.', 37.1230, 14.3640, 'Medium', 'Navy', 'Active', 1991
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Navy NCTS Sicily (Niscemi)' AND country_name = 'Italy');

-- ================================================================
-- ADDITIONAL FORMER/HISTORICAL bases with documented significance
-- ================================================================

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Torrejon Air Base', 'Spain', 'Former USAF major air base near Madrid. 401st Tactical Fighter Wing. Closed after Cold War.', 40.4970, -3.4460, 'Major', 'Air Force', 'Closed', 1953
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Torrejon Air Base' AND country_name = 'Spain');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Hellenikon Air Base', 'Greece', 'Former USAF base near Athens. Major Cold War presence in the eastern Mediterranean.', 37.8930, 23.7260, 'Medium', 'Air Force', 'Closed', 1947
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Hellenikon Air Base' AND country_name = 'Greece');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Subic Bay Naval Base', 'Philippines', 'Former major US Navy base in the Philippines. Largest overseas naval installation. Closed 1992 after Mt. Pinatubo and Philippine Senate vote.', 14.7940, 120.2830, 'Major', 'Navy', 'Closed', 1885
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Subic Bay Naval Base' AND country_name = 'Philippines');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Clark Air Base', 'Philippines', 'Former major USAF base in the Philippines. Largest US overseas air base. Closed after Mt. Pinatubo eruption.', 15.1860, 120.5600, 'Major', 'Air Force', 'Closed', 1903
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Clark Air Base' AND country_name = 'Philippines');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Keflavik Naval Air Station', 'Iceland', 'Former US Navy/NATO air base in Keflavik. Critical Cold War GIUK gap patrol base. Closed 2006.', 63.9850, -22.6060, 'Major', 'Navy', 'Closed', 1951
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Keflavik Naval Air Station' AND country_name = 'Iceland');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Naha Air Base', 'Japan', 'Former USAF base in Naha, Okinawa. Returned to Japan in 1972 reversion.', 26.1960, 127.6460, 'Major', 'Air Force', 'Closed', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Naha Air Base' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Tachikawa Air Base', 'Japan', 'Former USAF air base in Tachikawa, Tokyo. Major Vietnam War logistics hub. Returned 1977.', 35.7090, 139.4030, 'Major', 'Air Force', 'Closed', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Tachikawa Air Base' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Johnson Air Base', 'Japan', 'Former USAF base in Iruma, Saitama. 5th Air Force headquarters until 1974.', 35.8390, 139.4100, 'Major', 'Air Force', 'Closed', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Johnson Air Base' AND country_name = 'Japan');

-- ================================================================
-- MISCELLANEOUS - Other documented installations
-- ================================================================

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Lemonnier Expansion', 'Djibouti', 'Major expansion area of Camp Lemonnier including new aircraft parking and operational facilities.', 11.5470, 43.1540, 'Medium', 'Multi-service', 'Active', 2013
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Lemonnier Expansion' AND country_name = 'Djibouti');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Yokota JASDF Fuchu Annex', 'Japan', 'Joint use facility near Yokota Air Base. US-Japan bilateral operations center.', 35.7250, 139.4640, 'Small', 'Air Force', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Yokota JASDF Fuchu Annex' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Misawa ATG Range (Draughon Range)', 'Japan', 'US Navy air-to-ground weapons training range near Misawa Air Base.', 40.7030, 141.3830, 'Small', 'Navy', 'Active', 1945
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Misawa ATG Range (Draughon Range)' AND country_name = 'Japan');

INSERT INTO military_bases (name, country_name, description, latitude, longitude, category, branch, status, year_established)
SELECT 'Camp Darby Livorno', 'Italy', 'US Army pre-positioned stocks facility near Livorno. Largest US Army munitions depot south of the Alps.', 43.5650, 10.3370, 'Medium', 'Army', 'Active', 1951
WHERE NOT EXISTS (SELECT 1 FROM military_bases WHERE name = 'Camp Darby Livorno' AND country_name = 'Italy');

END $$;
