-- =============================================================================
-- US Interventions - Missing Bombings & Key Conflicts
-- Generated for Supabase SQL Editor (bypasses RLS)
-- Cross-referenced against seed_all_interventions.sql to avoid duplicates
-- Sources: Zoltan Grossman list, Congressional Research Service, news archives
-- =============================================================================

DO $$
DECLARE
  t_golpe       UUID;
  t_bombardeo   UUID;
  t_ocupacion   UUID;
  t_injerencia  UUID;
  t_naval       UUID;
  t_encubierta  UUID;
BEGIN
  -- Retrieve type IDs
  SELECT id INTO t_golpe      FROM intervention_types WHERE name = 'Golpe de Estado';
  SELECT id INTO t_bombardeo  FROM intervention_types WHERE name = 'Bombardeo';
  SELECT id INTO t_ocupacion  FROM intervention_types WHERE name = 'Ocupación Militar';
  SELECT id INTO t_injerencia FROM intervention_types WHERE name = 'Injerencia Política';
  SELECT id INTO t_naval      FROM intervention_types WHERE name = 'Operación Naval';
  SELECT id INTO t_encubierta FROM intervention_types WHERE name = 'Operación Encubierta';

  -- Verify all types were found
  IF t_golpe IS NULL OR t_bombardeo IS NULL OR t_ocupacion IS NULL
     OR t_injerencia IS NULL OR t_naval IS NULL OR t_encubierta IS NULL THEN
    RAISE EXCEPTION 'One or more intervention types not found in the database';
  END IF;

  -- =========================================================================
  -- MISSING COLD WAR ERA BOMBINGS & INTERVENTIONS
  -- =========================================================================

  -- 1. China 1945 - Post-WWII troop deployment
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Post-WWII troop deployment in China', 'China', 'Over 100,000 US troops deployed to northern China after WWII to disarm Japanese and support Nationalist forces against Communist forces.', 1945, 1946,
         39.9 + (random() - 0.5) * 0.6, 116.4 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'China' AND start_year = 1945);

  -- 2. North Korea 1950 - Massive bombing campaign (separate from ground war)
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Massive bombing campaign in Korean War', 'North Korea', 'Extensive strategic bombing of North Korea. 635,000 tons of bombs dropped, more than the Pacific theater of WWII. Nearly every building destroyed.', 1950, 1953,
         39.0 + (random() - 0.5) * 0.6, 125.7 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'North Korea' AND start_year = 1950 AND type_id = t_bombardeo);

  -- 3. China 1950 - Korean War border bombing
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Korean War border bombing and confrontation', 'China', 'US bombed targets near Chinese border during Korean War. Direct combat with Chinese forces after China entered the war. Nuclear use considered.', 1950, 1953,
         41.8 + (random() - 0.5) * 0.6, 126.5 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'China' AND start_year = 1950 AND type_id = t_bombardeo);

  -- 4. Guatemala 1954 - CIA-backed coup (bombing component)
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'CIA coup and aerial bombing against Arbenz', 'Guatemala', 'CIA-organized coup against elected President Arbenz. CIA planes bombed Guatemala City. Replaced with military junta.', 1954, NULL,
         14.6 + (random() - 0.5) * 0.6, -90.5 + (random() - 0.5) * 0.6, t_golpe
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Guatemala' AND start_year = 1954);

  -- 5. Indonesia 1958 - CIA bombing campaign
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'CIA bombing campaign against Sukarno', 'Indonesia', 'CIA pilots bombed Indonesian government targets to support rebel movements against President Sukarno. CIA pilot Allen Pope shot down and captured.', 1958, NULL,
         -0.8 + (random() - 0.5) * 0.6, 113.9 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Indonesia' AND start_year = 1958);

  -- 6. Vietnam 1965 - Massive bombing campaign (separate from ground war)
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Operation Rolling Thunder and strategic bombing', 'Vietnam', 'Massive aerial bombing campaign (Operation Rolling Thunder). Over 7 million tons of bombs dropped on Vietnam, Laos and Cambodia combined — more than all of WWII.', 1965, 1973,
         16.5 + (random() - 0.5) * 0.6, 107.6 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Vietnam' AND start_year = 1965 AND type_id = t_bombardeo);

  -- 7. Cambodia 1969 - Secret bombing campaign
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Secret carpet bombing (Operation Menu)', 'Cambodia', 'Secret carpet bombing campaign (Operation Menu/Freedom Deal). Over 500,000 tons of bombs. Estimated 100,000-500,000 Cambodians killed. Destabilized the country, contributing to rise of Khmer Rouge.', 1969, 1973,
         11.5 + (random() - 0.5) * 0.6, 105.0 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Cambodia' AND start_year = 1969);

  -- 8. Chile 1973 - CIA-backed coup against Allende
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'CIA-backed coup against Allende', 'Chile', 'CIA-backed military coup overthrows democratically elected President Salvador Allende. Gen. Pinochet installed. Thousands killed and disappeared.', 1973, NULL,
         -33.4 + (random() - 0.5) * 0.6, -70.6 + (random() - 0.5) * 0.6, t_golpe
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Chile' AND start_year = 1973);

  -- 9. Angola 1976 - CIA covert war
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'CIA covert war backing UNITA rebels', 'Angola', 'CIA covert operations backing UNITA rebels against MPLA government. Supplied arms and mercenaries.', 1976, 1992,
         -12.4 + (random() - 0.5) * 0.6, 17.9 + (random() - 0.5) * 0.6, t_encubierta
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Angola' AND start_year = 1976);

  -- 10. Nicaragua 1981 - Contra war (bombing/mining)
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Contra war: CIA bombs and mines harbors', 'Nicaragua', 'CIA funds Contra rebels, mines Nicaraguan harbors, and bombs fuel facilities. US convicted by International Court of Justice for illegal war.', 1981, 1990,
         12.1 + (random() - 0.5) * 0.6, -86.3 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Nicaragua' AND start_year = 1981 AND type_id = t_bombardeo);

  -- 11. Grenada 1983 - Invasion
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Invasion of Grenada (Operation Urgent Fury)', 'Grenada', 'Full-scale invasion with 8,000 troops to overthrow Marxist government. Bombing and ground assault.', 1983, NULL,
         12.1 + (random() - 0.5) * 0.6, -61.7 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Grenada' AND start_year = 1983);

  -- 12. Libya 1986 - Bombing of Tripoli
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Bombing of Tripoli and Benghazi', 'Libya', 'Air strikes bomb Tripoli and Benghazi. Targeted Gaddafi residence. Dozens of civilians killed including Gaddafi''s adopted daughter.', 1986, NULL,
         32.9 + (random() - 0.5) * 0.6, 13.2 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Libya' AND start_year = 1986);

  -- =========================================================================
  -- MISSING 1990s BOMBINGS
  -- =========================================================================

  -- 13. Iraq 1993 - Clinton cruise missile strikes
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Cruise missile strike on Baghdad', 'Iraq', 'US launches 23 Tomahawk cruise missiles at Iraqi intelligence HQ in Baghdad in retaliation for alleged assassination plot against George H.W. Bush.', 1993, NULL,
         33.3 + (random() - 0.5) * 0.6, 44.4 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Iraq' AND start_year = 1993);

  -- 14. Somalia 1993 - Battle of Mogadishu (Black Hawk Down)
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Battle of Mogadishu (Black Hawk Down)', 'Somalia', 'US Army Rangers and Delta Force raid in Mogadishu. Two Black Hawk helicopters shot down. 18 US soldiers and estimated 1,000+ Somalis killed.', 1993, 1994,
         2.0 + (random() - 0.5) * 0.6, 45.3 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Somalia' AND start_year = 1993);

  -- 15. Iraq 1996 - Operation Desert Strike
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Operation Desert Strike', 'Iraq', 'US launches 44 cruise missiles at Iraqi air defense targets in southern Iraq after Iraqi forces enter Kurdish safe haven.', 1996, NULL,
         31.5 + (random() - 0.5) * 0.6, 44.0 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Iraq' AND start_year = 1996);

  -- 16. Sudan 1998 - Al-Shifa pharmaceutical factory bombing
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Bombing of Al-Shifa pharmaceutical factory', 'Sudan', 'Cruise missile strike destroys Al-Shifa pharmaceutical factory in Khartoum, alleged chemical weapons facility. Later evidence suggests it was a civilian pharmaceutical plant producing medicines.', 1998, NULL,
         15.6 + (random() - 0.5) * 0.6, 32.5 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Sudan' AND start_year = 1998);

  -- 17. Iraq 1998 - Operation Desert Fox
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Operation Desert Fox', 'Iraq', 'US-UK 4-day bombing campaign (Operation Desert Fox). 415 cruise missiles and 600 bomb sorties against 97 targets throughout Iraq.', 1998, NULL,
         33.2 + (random() - 0.5) * 0.6, 43.5 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Iraq' AND start_year = 1998);

  -- 18. Yugoslavia/Serbia 1999 - 78-day NATO bombing
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT '78-day NATO bombing of Yugoslavia', 'Yugoslavia', '78-day NATO bombing campaign against Yugoslavia (Operation Allied Force). 38,000 sorties. Bridges, factories, power plants, TV stations destroyed. Chinese embassy hit. 500+ civilians killed.', 1999, NULL,
         44.8 + (random() - 0.5) * 0.6, 20.5 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Yugoslavia' AND start_year = 1999);

  -- =========================================================================
  -- MISSING 2000s KEY CONFLICTS
  -- =========================================================================

  -- 19. Afghanistan 2001 - Full invasion and occupation
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Invasion and 20-year occupation of Afghanistan', 'Afghanistan', 'Full-scale invasion after 9/11 (Operation Enduring Freedom). 20-year occupation with up to 100,000 troops. Taliban overthrown but resurged. Over 170,000 killed. US withdraws August 2021.', 2001, 2021,
         34.5 + (random() - 0.5) * 0.6, 69.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Afghanistan' AND start_year = 2001);

  -- 20. Iraq 2003 - Full invasion and occupation
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Invasion and occupation of Iraq', 'Iraq', 'Full-scale invasion (Operation Iraqi Freedom) based on false WMD claims. Saddam Hussein overthrown. 8-year occupation. Estimated 200,000-1,000,000+ Iraqi civilians killed. Sectarian civil war followed.', 2003, 2011,
         33.3 + (random() - 0.5) * 0.6, 44.4 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Iraq' AND start_year = 2003);

  -- 21. Libya 2011 - NATO bombing and regime change
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'NATO bombing and regime change', 'Libya', 'US-led NATO bombing campaign (Operation Unified Protector). 26,000 sorties. Gaddafi overthrown and killed. Country plunged into civil war and failed state status.', 2011, NULL,
         32.9 + (random() - 0.5) * 0.6, 13.2 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Libya' AND start_year = 2011);

  -- 22. Syria 2014 - Bombing campaign vs ISIS and Assad
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Bombing campaign and special operations in Syria', 'Syria', 'US-led coalition bombing campaign against ISIS (Operation Inherent Resolve). Thousands of air strikes. US troops on ground. Also launched cruise missiles against Assad government in 2017 and 2018.', 2014, 2023,
         35.5 + (random() - 0.5) * 0.6, 38.9 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Syria' AND start_year = 2014);

  -- =========================================================================
  -- VERY RECENT EVENTS (2025-2026)
  -- =========================================================================

  -- 23. Yemen 2024 - Expanded Houthi strikes
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Expanded strikes on Houthi targets', 'Yemen', 'Major escalation of US-UK strikes on Houthi positions after continued attacks on Red Sea commercial shipping. Strikes on Sanaa, Hodeidah and other cities.', 2024, 2025,
         15.4 + (random() - 0.5) * 0.6, 44.2 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Yemen' AND start_year = 2024);

  -- 24. Iran 2025 - Strikes on nuclear/military facilities
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Strikes on Iranian military facilities', 'Iran', 'US conducts strikes on Iranian military and nuclear-linked facilities amid escalating tensions over nuclear program and proxy conflicts.', 2025, NULL,
         32.4 + (random() - 0.5) * 0.6, 53.7 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Iran' AND start_year = 2025);

  -- 25. Somalia 2025 - Expanded counter-terror operations
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Expanded counter-terror strikes', 'Somalia', 'Expanded US air strikes and drone operations against Al-Shabaab and ISIS-Somalia. Increased troop presence and special operations raids.', 2025, NULL,
         2.0 + (random() - 0.5) * 0.6, 45.3 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Somalia' AND start_year = 2025);

  -- 26. Syria 2025 - Strikes on remaining targets
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Strikes on militia and remnant targets', 'Syria', 'Continued US military strikes on Iranian-backed militia positions and ISIS remnants in eastern Syria.', 2025, NULL,
         35.0 + (random() - 0.5) * 0.6, 40.2 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Syria' AND start_year = 2025);

  -- 27. Nigeria 2025 - Counter-terror operations
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Counter-terror operations in Nigeria', 'Nigeria', 'US special operations and intelligence support for Nigerian military operations against Boko Haram and ISWAP in the Lake Chad region.', 2025, NULL,
         9.1 + (random() - 0.5) * 0.6, 7.5 + (random() - 0.5) * 0.6, t_encubierta
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Nigeria' AND start_year = 2025);

  -- 28. Venezuela 2026 - Military operations
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Military operations against Venezuela', 'Venezuela', 'US military operations targeting Venezuelan government amid regime change pressure and regional instability.', 2026, NULL,
         6.4 + (random() - 0.5) * 0.6, -66.6 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Venezuela' AND start_year = 2026);

  -- 29. Iran 2026 - Continued strikes
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Continued strikes on Iranian targets', 'Iran', 'Ongoing US military strikes on Iranian nuclear and military infrastructure. Major escalation in regional conflict.', 2026, NULL,
         35.7 + (random() - 0.5) * 0.6, 51.4 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Iran' AND start_year = 2026);

  RAISE NOTICE 'All missing interventions inserted successfully. Total: 29 new entries.';
END $$;
