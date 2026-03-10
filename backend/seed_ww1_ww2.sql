-- ============================================================
-- SEED: Intervenciones WW1 y WW2 de Estados Unidos
-- Ejecutar en Supabase SQL Editor
-- ============================================================
DO $$
DECLARE
  t_ww1 UUID;
  t_ww2 UUID;
BEGIN

  -- 1. Crear los nuevos tipos de intervención (si no existen)
  INSERT INTO intervention_types (name, color_code)
  VALUES ('Acciones WW1', '#006400')
  ON CONFLICT (name) DO NOTHING;

  INSERT INTO intervention_types (name, color_code)
  VALUES ('Acciones WW2', '#32CD32')
  ON CONFLICT (name) DO NOTHING;

  -- 2. Obtener los IDs
  SELECT id INTO t_ww1 FROM intervention_types WHERE name = 'Acciones WW1';
  SELECT id INTO t_ww2 FROM intervention_types WHERE name = 'Acciones WW2';

  -- ============================================================
  -- WORLD WAR 1 (14 intervenciones)
  -- ============================================================

  -- WW1-1. US Entry into World War 1
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'US Entry into World War 1', 'France', 'The United States declared war on Germany on April 6, 1917, and began deploying the American Expeditionary Forces to France.', 1917, 1918,
         48.86 + (random() - 0.5) * 0.3, 2.35 + (random() - 0.5) * 0.3, t_ww1
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'US Entry into World War 1');

  -- WW1-2. Battle of Cantigny
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Battle of Cantigny', 'France', 'First major American offensive of the war; the US 1st Division captured the village of Cantigny on May 28, 1918.', 1918, NULL,
         49.87 + (random() - 0.5) * 0.2, 2.49 + (random() - 0.5) * 0.2, t_ww1
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Battle of Cantigny');

  -- WW1-3. Battle of Belleau Wood
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Battle of Belleau Wood', 'France', 'US Marines fought a fierce month-long battle against German forces near Château-Thierry, a defining moment for the Marine Corps.', 1918, NULL,
         49.07 + (random() - 0.5) * 0.2, 3.29 + (random() - 0.5) * 0.2, t_ww1
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Battle of Belleau Wood');

  -- WW1-4. Battle of Château-Thierry
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Battle of Château-Thierry', 'France', 'US forces helped block the German advance toward Paris along the Marne River in late May and early June 1918.', 1918, NULL,
         49.05 + (random() - 0.5) * 0.2, 3.40 + (random() - 0.5) * 0.2, t_ww1
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Battle of Château-Thierry');

  -- WW1-5. Second Battle of the Marne
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Second Battle of the Marne', 'France', 'American divisions played a crucial role in the Allied counter-offensive that turned the tide of the war in July-August 1918.', 1918, NULL,
         49.15 + (random() - 0.5) * 0.2, 3.50 + (random() - 0.5) * 0.2, t_ww1
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Second Battle of the Marne');

  -- WW1-6. Battle of Hamel
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Battle of Hamel', 'France', 'US infantry companies fought alongside Australian forces in a highly coordinated assault on July 4, 1918.', 1918, NULL,
         49.88 + (random() - 0.5) * 0.2, 2.55 + (random() - 0.5) * 0.2, t_ww1
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Battle of Hamel');

  -- WW1-7. Saint-Mihiel Offensive
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Saint-Mihiel Offensive', 'France', 'The first large-scale independent American operation reduced the Saint-Mihiel salient in just four days in September 1918.', 1918, NULL,
         48.89 + (random() - 0.5) * 0.2, 5.54 + (random() - 0.5) * 0.2, t_ww1
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Saint-Mihiel Offensive');

  -- WW1-8. Meuse-Argonne Offensive
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Meuse-Argonne Offensive', 'France', 'The largest American military operation in WW1, involving over 1 million troops in the final Allied offensive that helped end the war.', 1918, NULL,
         49.32 + (random() - 0.5) * 0.2, 5.09 + (random() - 0.5) * 0.2, t_ww1
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Meuse-Argonne Offensive');

  -- WW1-9. Battle of Blanc Mont Ridge
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Battle of Blanc Mont Ridge', 'France', 'The US 2nd Division captured a strategically vital ridge in Champagne in October 1918, breaking through the Hindenburg Line.', 1918, NULL,
         49.20 + (random() - 0.5) * 0.2, 4.45 + (random() - 0.5) * 0.2, t_ww1
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Battle of Blanc Mont Ridge');

  -- WW1-10. Battle of the Selle
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Battle of the Selle', 'France', 'American forces crossed the Selle River and advanced against German positions in mid-October 1918 as part of the Hundred Days Offensive.', 1918, NULL,
         50.12 + (random() - 0.5) * 0.2, 3.58 + (random() - 0.5) * 0.2, t_ww1
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Battle of the Selle');

  -- WW1-11. US Navy Convoy Operations in the Atlantic
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'US Navy Atlantic Convoy Operations', 'Atlantic Ocean', 'The US Navy escorted troop and supply convoys across the Atlantic, implementing the convoy system that reduced shipping losses to U-boats.', 1917, 1918,
         47.0 + (random() - 0.5) * 2.0, -30.0 + (random() - 0.5) * 2.0, t_ww1
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'US Navy Atlantic Convoy Operations');

  -- WW1-12. US Navy Mine Barrage in the North Sea
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'North Sea Mine Barrage', 'United Kingdom', 'The US Navy laid over 56,000 mines between Scotland and Norway to contain German submarines.', 1918, NULL,
         59.0 + (random() - 0.5) * 0.5, -1.0 + (random() - 0.5) * 0.5, t_ww1
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'North Sea Mine Barrage');

  -- WW1-13. Polar Bear Expedition (Northern Russia)
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Polar Bear Expedition', 'Russia', 'US troops deployed to Archangelsk in northern Russia to guard Allied supplies and support anti-Bolshevik forces.', 1918, 1919,
         64.54 + (random() - 0.5) * 0.3, 40.54 + (random() - 0.5) * 0.3, t_ww1
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Polar Bear Expedition');

  -- WW1-14. American Expeditionary Force Siberia
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'American Expeditionary Force Siberia', 'Russia', 'US troops sent to Vladivostok to safeguard Allied interests and assist Czechoslovak Legion evacuation during the Russian Civil War.', 1918, 1920,
         43.12 + (random() - 0.5) * 0.3, 131.89 + (random() - 0.5) * 0.3, t_ww1
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'American Expeditionary Force Siberia');

  -- ============================================================
  -- WORLD WAR 2 (27 intervenciones)
  -- ============================================================

  -- WW2-1. Attack on Pearl Harbor (response)
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Attack on Pearl Harbor', 'United States (Hawaii)', 'Japan''s surprise attack on the US Pacific Fleet at Pearl Harbor on December 7, 1941, brought the United States into World War 2.', 1941, NULL,
         21.365 + (random() - 0.5) * 0.1, -157.95 + (random() - 0.5) * 0.1, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Attack on Pearl Harbor');

  -- WW2-2. Battle of the Coral Sea
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Battle of the Coral Sea', 'Papua New Guinea', 'The first naval battle fought entirely by carrier aircraft; US forces checked the Japanese advance toward Australia in May 1942.', 1942, NULL,
         -15.5 + (random() - 0.5) * 1.0, 153.0 + (random() - 0.5) * 1.0, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Battle of the Coral Sea');

  -- WW2-3. Battle of Midway
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Battle of Midway', 'United States (Midway)', 'A decisive naval battle in June 1942 where the US Navy sank four Japanese carriers, turning the tide of the Pacific war.', 1942, NULL,
         28.21 + (random() - 0.5) * 0.3, -177.37 + (random() - 0.5) * 0.3, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Battle of Midway');

  -- WW2-4. Guadalcanal Campaign
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Guadalcanal Campaign', 'Solomon Islands', 'The first major Allied ground offensive in the Pacific; US forces fought for six months to secure this strategically vital island.', 1942, 1943,
         -9.44 + (random() - 0.5) * 0.3, 160.02 + (random() - 0.5) * 0.3, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Guadalcanal Campaign');

  -- WW2-5. Operation Torch (North Africa)
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Operation Torch - North Africa', 'Morocco', 'US and British forces landed in French North Africa in November 1942, opening a second front against the Axis powers.', 1942, 1943,
         33.57 + (random() - 0.5) * 0.5, -7.59 + (random() - 0.5) * 0.5, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Operation Torch - North Africa');

  -- WW2-6. Tunisia Campaign
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Tunisia Campaign', 'Tunisia', 'US forces fought through harsh terrain against Rommel''s Afrika Korps, culminating in Axis surrender in North Africa in May 1943.', 1943, NULL,
         35.69 + (random() - 0.5) * 0.5, 9.17 + (random() - 0.5) * 0.5, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Tunisia Campaign');

  -- WW2-7. Invasion of Sicily (Operation Husky)
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Invasion of Sicily (Operation Husky)', 'Italy', 'US and British forces invaded Sicily in July 1943, leading to Mussolini''s fall and Italy''s eventual surrender.', 1943, NULL,
         37.50 + (random() - 0.5) * 0.3, 14.00 + (random() - 0.5) * 0.3, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Invasion of Sicily (Operation Husky)');

  -- WW2-8. Italian Campaign (Salerno and Anzio)
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Italian Campaign - Salerno and Anzio', 'Italy', 'US forces landed at Salerno and later Anzio, fighting a grueling campaign up the Italian peninsula against entrenched German defenses.', 1943, 1945,
         40.68 + (random() - 0.5) * 0.3, 14.77 + (random() - 0.5) * 0.3, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Italian Campaign - Salerno and Anzio');

  -- WW2-9. Battle of Monte Cassino
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Battle of Monte Cassino', 'Italy', 'Four costly Allied assaults over five months were needed to break through the German Gustav Line south of Rome.', 1944, NULL,
         41.49 + (random() - 0.5) * 0.2, 13.81 + (random() - 0.5) * 0.2, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Battle of Monte Cassino');

  -- WW2-10. Strategic Bombing of Germany
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Strategic Bombing of Germany', 'Germany', 'The US Eighth Air Force conducted massive daylight bombing raids against German industrial and military targets from bases in England.', 1942, 1945,
         52.52 + (random() - 0.5) * 1.0, 13.41 + (random() - 0.5) * 1.0, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Strategic Bombing of Germany');

  -- WW2-11. Battle of the Atlantic (US Naval Operations)
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Battle of the Atlantic - US Naval Operations', 'Atlantic Ocean', 'US Navy warships and aircraft played a critical role in the anti-submarine war that safeguarded Allied supply lines across the Atlantic.', 1941, 1945,
         45.0 + (random() - 0.5) * 2.0, -35.0 + (random() - 0.5) * 2.0, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Battle of the Atlantic - US Naval Operations');

  -- WW2-12. D-Day (Normandy Invasion)
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'D-Day - Normandy Invasion', 'France', 'On June 6, 1944, US forces stormed Utah and Omaha beaches as part of the largest amphibious invasion in history.', 1944, NULL,
         49.36 + (random() - 0.5) * 0.2, -0.87 + (random() - 0.5) * 0.2, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'D-Day - Normandy Invasion');

  -- WW2-13. Battle of the Hedgerows (Normandy)
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Battle of the Hedgerows', 'France', 'US forces fought through dense bocage terrain in Normandy during June-July 1944 before the breakout at Operation Cobra.', 1944, NULL,
         49.18 + (random() - 0.5) * 0.2, -1.09 + (random() - 0.5) * 0.2, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Battle of the Hedgerows');

  -- WW2-14. Liberation of Paris
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Liberation of Paris', 'France', 'US and Free French forces liberated Paris on August 25, 1944, ending four years of German occupation.', 1944, NULL,
         48.86 + (random() - 0.5) * 0.1, 2.35 + (random() - 0.5) * 0.1, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Liberation of Paris');

  -- WW2-15. Operation Market Garden
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Operation Market Garden', 'Netherlands', 'A bold but ultimately unsuccessful airborne operation in September 1944 to secure bridges across the Rhine.', 1944, NULL,
         51.98 + (random() - 0.5) * 0.3, 5.91 + (random() - 0.5) * 0.3, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Operation Market Garden');

  -- WW2-16. Battle of Hürtgen Forest
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Battle of Hürtgen Forest', 'Germany', 'One of the longest and bloodiest battles fought by US forces in WW2, lasting from September 1944 to February 1945 in dense forest.', 1944, 1945,
         50.68 + (random() - 0.5) * 0.2, 6.37 + (random() - 0.5) * 0.2, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Battle of Hürtgen Forest');

  -- WW2-17. Battle of the Bulge
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Battle of the Bulge', 'Belgium', 'Germany''s last major western offensive in December 1944; US forces, including the 101st Airborne at Bastogne, held firm and counterattacked.', 1944, 1945,
         50.00 + (random() - 0.5) * 0.3, 5.72 + (random() - 0.5) * 0.3, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Battle of the Bulge');

  -- WW2-18. Crossing of the Rhine (Remagen)
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Crossing of the Rhine at Remagen', 'Germany', 'US forces captured the intact Ludendorff Bridge at Remagen in March 1945, establishing a critical bridgehead across the Rhine.', 1945, NULL,
         50.57 + (random() - 0.5) * 0.2, 7.23 + (random() - 0.5) * 0.2, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Crossing of the Rhine at Remagen');

  -- WW2-19. Battle of Tarawa
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Battle of Tarawa', 'Kiribati', 'A fierce amphibious assault on the heavily fortified atoll in November 1943 that provided harsh lessons for future Pacific operations.', 1943, NULL,
         1.45 + (random() - 0.5) * 0.2, 173.0 + (random() - 0.5) * 0.2, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Battle of Tarawa');

  -- WW2-20. Battle of Saipan
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Battle of Saipan', 'Northern Mariana Islands', 'US forces captured Saipan in June-July 1944, bringing Japan within range of B-29 strategic bombers.', 1944, NULL,
         15.19 + (random() - 0.5) * 0.2, 145.75 + (random() - 0.5) * 0.2, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Battle of Saipan');

  -- WW2-21. Battle of Leyte Gulf
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Battle of Leyte Gulf', 'Philippines', 'The largest naval battle in history in October 1944, securing US return to the Philippines and destroying the Japanese fleet.', 1944, NULL,
         10.50 + (random() - 0.5) * 0.5, 125.50 + (random() - 0.5) * 0.5, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Battle of Leyte Gulf');

  -- WW2-22. Liberation of the Philippines
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Liberation of the Philippines', 'Philippines', 'US forces under MacArthur fought from October 1944 to August 1945 to liberate the Philippine archipelago from Japanese occupation.', 1944, 1945,
         14.60 + (random() - 0.5) * 0.3, 120.98 + (random() - 0.5) * 0.3, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Liberation of the Philippines');

  -- WW2-23. Battle of Iwo Jima
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Battle of Iwo Jima', 'Japan', 'US Marines captured the heavily fortified volcanic island in February-March 1945, immortalized by the flag-raising on Mount Suribachi.', 1945, NULL,
         24.76 + (random() - 0.5) * 0.1, 141.29 + (random() - 0.5) * 0.1, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Battle of Iwo Jima');

  -- WW2-24. Battle of Okinawa
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Battle of Okinawa', 'Japan', 'The largest amphibious assault in the Pacific, lasting from April to June 1945, with enormous casualties on both sides.', 1945, NULL,
         26.33 + (random() - 0.5) * 0.2, 127.75 + (random() - 0.5) * 0.2, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Battle of Okinawa');

  -- WW2-25. Strategic Bombing of Japan (B-29)
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Strategic Bombing of Japan', 'Japan', 'US B-29 bombers conducted devastating firebombing raids on Japanese cities from late 1944, destroying vast urban areas and industrial capacity.', 1944, 1945,
         35.68 + (random() - 0.5) * 0.5, 139.65 + (random() - 0.5) * 0.5, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Strategic Bombing of Japan');

  -- WW2-26. Atomic Bombing of Hiroshima
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Atomic Bombing of Hiroshima', 'Japan', 'The first atomic bomb was dropped on Hiroshima on August 6, 1945, destroying the city and killing an estimated 80,000 people instantly.', 1945, NULL,
         34.39 + (random() - 0.5) * 0.05, 132.46 + (random() - 0.5) * 0.05, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Atomic Bombing of Hiroshima');

  -- WW2-27. Atomic Bombing of Nagasaki
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Atomic Bombing of Nagasaki', 'Japan', 'The second atomic bomb was dropped on Nagasaki on August 9, 1945, leading directly to Japan''s unconditional surrender.', 1945, NULL,
         32.75 + (random() - 0.5) * 0.05, 129.88 + (random() - 0.5) * 0.05, t_ww2
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Atomic Bombing of Nagasaki');

END $$;
