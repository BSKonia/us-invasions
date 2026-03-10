-- =============================================================================
-- US Interventions - Comprehensive Seed File
-- Generated for Supabase SQL Editor (bypasses RLS)
-- Sources: Harvard DRCLAS, Congressional Research Service, Zoltan Grossman list
-- =============================================================================

-- Step 1: Insert new intervention types (skip if they already exist)
INSERT INTO intervention_types (name, color_code) VALUES
  ('Operación Naval', '#0088ff'),
  ('Operación Encubierta', '#aa00ff')
ON CONFLICT (name) DO NOTHING;

-- Step 2: Insert all new interventions using a DO block
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
  -- ERA 1: 1798–1849 (27 interventions)
  -- =========================================================================

  -- 1. France 1798 - Quasi-War
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Quasi-War naval operations', 'France', 'Undeclared naval war (Quasi-War). Marines land in Puerto Plata.', 1798, 1800,
         46.2 + (random() - 0.5) * 0.6, 2.2 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'France' AND start_year = 1798);

  -- 2. Tripoli 1801 - First Barbary War
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'First Barbary War', 'Tripoli', 'First Barbary War against Tripoli (Libya).', 1801, 1805,
         32.9 + (random() - 0.5) * 0.6, 13.2 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Tripoli' AND start_year = 1801);

  -- 3. Mexico 1806 - Rio Grande incursion
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Rio Grande military incursion', 'Mexico', 'Military force enters Spanish territory at headwaters of the Rio Grande.', 1806, NULL,
         23.6 + (random() - 0.5) * 0.6, -102.5 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Mexico' AND start_year = 1806);

  -- 4. Caribbean 1806 - Naval attacks on French/Spanish shipping
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Caribbean naval operations', 'Caribbean', 'US naval vessels attack French and Spanish shipping in the Caribbean.', 1806, 1810,
         17.0 + (random() - 0.5) * 0.6, -68.0 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Caribbean' AND start_year = 1806);

  -- 5. Spain (West Florida) 1810
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Seizure of West Florida', 'Spain (West Florida)', 'Troops invade and seize Western Florida, a Spanish possession.', 1810, NULL,
         30.4 + (random() - 0.5) * 0.6, -87.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Spain (West Florida)' AND start_year = 1810);

  -- 6. Spain (East Florida) 1812
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Seizure of East Florida territories', 'Spain (East Florida)', 'Troops seize Amelia Island and adjacent territories in Spanish East Florida.', 1812, NULL,
         29.7 + (random() - 0.5) * 0.6, -81.7 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Spain (East Florida)' AND start_year = 1812);

  -- 7. Marquesas Islands 1813
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Seizure of Nukahiva', 'Marquesas Islands', 'Forces seize Nukahiva and establish first US naval base in the Pacific.', 1813, NULL,
         -9.0 + (random() - 0.5) * 0.6, -139.5 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Marquesas Islands' AND start_year = 1813);

  -- 8. Spain (East Florida) 1814
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Seizure of Pensacola', 'Spain (East Florida)', 'Troops seize Pensacola in Spanish East Florida.', 1814, NULL,
         29.7 + (random() - 0.5) * 0.6, -81.7 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Spain (East Florida)' AND start_year = 1814);

  -- 9. Caribbean 1814 - Naval operations
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Caribbean naval squadron operations', 'Caribbean', 'US naval squadron engages French, British and Spanish shipping.', 1814, 1825,
         17.0 + (random() - 0.5) * 0.6, -68.0 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Caribbean' AND start_year = 1814);

  -- 10. Algiers 1815 - Second Barbary War
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Second Barbary War', 'Algiers', 'Second Barbary War. US naval fleet under Capt. Decatur in North Africa.', 1815, NULL,
         36.7 + (random() - 0.5) * 0.6, 3.1 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Algiers' AND start_year = 1815);

  -- 11. Spain (East Florida) 1816
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'East Florida operations and cession', 'Spain (East Florida)', 'Troops attack Nicholls Fort, Amelia Island. Spain cedes East Florida.', 1816, 1819,
         29.7 + (random() - 0.5) * 0.6, -81.7 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Spain (East Florida)' AND start_year = 1816);

  -- 12. Cuba 1822 - Marines land in Spanish Cuba
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines land in Spanish Cuba', 'Cuba', 'Marines land in numerous cities in Spanish Cuba and Puerto Rico.', 1822, 1825,
         21.5 + (random() - 0.5) * 0.6, -77.8 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Cuba' AND start_year = 1822);

  -- 13. Greece 1827 - Marines invade Greek islands
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines invade Greek islands', 'Greece', 'Marines invade the Greek islands of Argentiere, Miconi and Andross.', 1827, NULL,
         39.0 + (random() - 0.5) * 0.6, 22.0 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Greece' AND start_year = 1827);

  -- 14. Falkland Islands 1831
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Naval aggression in Falklands', 'Falkland Islands', 'US naval squadrons aggress the Falkland Islands.', 1831, NULL,
         -51.8 + (random() - 0.5) * 0.6, -59.0 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Falkland Islands' AND start_year = 1831);

  -- 15. Sumatra 1832
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Naval attack on Qallah Battoo', 'Sumatra', 'US naval squadrons attack Qallah Battoo in the Dutch East Indies.', 1832, NULL,
         0.6 + (random() - 0.5) * 0.6, 101.3 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Sumatra' AND start_year = 1832);

  -- 16. Argentina 1833
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Forces land in Buenos Aires', 'Argentina', 'Forces land in Buenos Aires and engage local combatants.', 1833, NULL,
         -38.4 + (random() - 0.5) * 0.6, -63.6 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Argentina' AND start_year = 1833);

  -- 17. Peru 1835
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Counter-insurgency operations', 'Peru', 'Troops dispatched twice for counter-insurgency operations.', 1835, 1836,
         -9.2 + (random() - 0.5) * 0.6, -75.0 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Peru' AND start_year = 1835);

  -- 18. Mexico 1836 - Texas independence
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Assistance to Texas independence', 'Mexico', 'Troops assist Texas war for independence from Mexico.', 1836, NULL,
         23.6 + (random() - 0.5) * 0.6, -102.5 + (random() - 0.5) * 0.6, t_injerencia
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Mexico' AND start_year = 1836);

  -- 19. Canada 1837
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Naval border incident', 'Canada', 'Naval incident on border leads to mobilization of force to invade Canada. War narrowly averted.', 1837, NULL,
         56.1 + (random() - 0.5) * 0.6, -106.3 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Canada' AND start_year = 1837);

  -- 20. Sumatra 1838
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Punitive naval expedition', 'Sumatra', 'US naval forces sent to Sumatra for punitive expedition.', 1838, NULL,
         0.6 + (random() - 0.5) * 0.6, 101.3 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Sumatra' AND start_year = 1838);

  -- 21. Fiji 1840
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Naval forces deployed in Fiji', 'Fiji', 'Naval forces deployed, marines land.', 1840, 1841,
         -17.7 + (random() - 0.5) * 0.6, 178.1 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Fiji' AND start_year = 1840);

  -- 22. Samoa 1841
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Naval forces deployed in Samoa', 'Samoa', 'Naval forces deployed, marines land.', 1841, NULL,
         -13.8 + (random() - 0.5) * 0.6, -172.0 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Samoa' AND start_year = 1841);

  -- 23. Mexico 1842 - Seizure of Monterey/San Diego
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Seizure of Monterey and San Diego', 'Mexico', 'Naval forces temporarily seize cities of Monterey and San Diego.', 1842, NULL,
         23.6 + (random() - 0.5) * 0.6, -102.5 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Mexico' AND start_year = 1842);

  -- 24. China 1843 - Marines land in Canton
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines land in Canton', 'China', 'Marines land in Canton.', 1843, NULL,
         35.9 + (random() - 0.5) * 0.6, 104.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'China' AND start_year = 1843);

  -- 25. Ivory Coast 1843
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines land on Ivory Coast', 'Ivory Coast', 'Marines land on the Ivory Coast.', 1843, NULL,
         7.5 + (random() - 0.5) * 0.6, -5.5 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Ivory Coast' AND start_year = 1843);

  -- 26. Mexico 1846 - Mexican-American War
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Mexican-American War', 'Mexico', 'Full-scale Mexican-American War. Mexico cedes half its territory by Treaty of Guadalupe Hidalgo.', 1846, 1848,
         23.6 + (random() - 0.5) * 0.6, -102.5 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Mexico' AND start_year = 1846);

  -- 27. Turkey 1849
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Naval force to Smyrna', 'Turkey', 'Naval force dispatched to Smyrna in the Ottoman Empire.', 1849, NULL,
         38.9 + (random() - 0.5) * 0.6, 35.2 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Turkey' AND start_year = 1849);

  -- =========================================================================
  -- ERA 2: 1850–1899 (51 interventions)
  -- =========================================================================

  -- 28. Argentina 1852
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines land in Buenos Aires', 'Argentina', 'Marines land in Buenos Aires.', 1852, 1853,
         -38.4 + (random() - 0.5) * 0.6, -63.6 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Argentina' AND start_year = 1852);

  -- 29. Nicaragua 1854 - Bombardment of San Juan del Norte
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Bombardment of San Juan del Norte', 'Nicaragua', 'Navy bombards and destroys city of San Juan del Norte. Marines land and burn the city.', 1854, NULL,
         12.9 + (random() - 0.5) * 0.6, -85.2 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Nicaragua' AND start_year = 1854);

  -- 30. Japan 1854 - Perry expedition
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Perry expedition to Japan', 'Japan', 'Commodore Perry and fleet deploy at Yokohama, forcing open of trade.', 1854, NULL,
         36.2 + (random() - 0.5) * 0.6, 138.3 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Japan' AND start_year = 1854);

  -- 31. Uruguay 1855
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines land in Montevideo', 'Uruguay', 'Marines land in Montevideo.', 1855, NULL,
         -32.5 + (random() - 0.5) * 0.6, -55.7 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Uruguay' AND start_year = 1855);

  -- 32. Colombia 1856 - Panama counter-insurgency
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines in Panama counter-insurgency', 'Colombia', 'Marines land in Panama region for counter-insurgency.', 1856, NULL,
         4.6 + (random() - 0.5) * 0.6, -74.1 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Colombia' AND start_year = 1856);

  -- 33. China 1856
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines deployed in Canton', 'China', 'Marines deployed in Canton.', 1856, NULL,
         35.9 + (random() - 0.5) * 0.6, 104.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'China' AND start_year = 1856);

  -- 34. Hawaii 1856
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Seizure of Pacific islands', 'Hawaii', 'Naval forces seize islands of Jarvis, Baker and Howland.', 1856, NULL,
         19.9 + (random() - 0.5) * 0.6, -155.6 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Hawaii' AND start_year = 1856);

  -- 35. Nicaragua 1857
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines land in Nicaragua', 'Nicaragua', 'Marines land in Nicaragua.', 1857, NULL,
         12.9 + (random() - 0.5) * 0.6, -85.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Nicaragua' AND start_year = 1857);

  -- 36. Uruguay 1858
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines land in Montevideo', 'Uruguay', 'Marines land in Montevideo.', 1858, NULL,
         -32.5 + (random() - 0.5) * 0.6, -55.7 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Uruguay' AND start_year = 1858);

  -- 37. Fiji 1858
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines land in Fiji', 'Fiji', 'Marines land in Fiji.', 1858, NULL,
         -17.7 + (random() - 0.5) * 0.6, 178.1 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Fiji' AND start_year = 1858);

  -- 38. Paraguay 1859
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Naval force vs Paraguay', 'Paraguay', 'Large naval force deployed against Paraguay.', 1859, NULL,
         -23.2 + (random() - 0.5) * 0.6, -58.1 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Paraguay' AND start_year = 1859);

  -- 39. China 1859
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Troops enter Shanghai', 'China', 'Troops enter Shanghai.', 1859, NULL,
         35.9 + (random() - 0.5) * 0.6, 104.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'China' AND start_year = 1859);

  -- 40. Mexico 1859 - Northern Mexico incursion
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Military force enters northern Mexico', 'Mexico', 'Military force enters northern Mexico.', 1859, NULL,
         23.6 + (random() - 0.5) * 0.6, -102.5 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Mexico' AND start_year = 1859);

  -- 41. Portuguese West Africa 1860
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Troops land at Kissembo', 'Portuguese West Africa', 'Troops land at Kissembo.', 1860, NULL,
         -8.8 + (random() - 0.5) * 0.6, 13.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Portuguese West Africa' AND start_year = 1860);

  -- 42. Colombia 1860
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Troops in Panama region', 'Colombia', 'Troops and naval forces deployed in Panama region.', 1860, NULL,
         4.6 + (random() - 0.5) * 0.6, -74.1 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Colombia' AND start_year = 1860);

  -- 43. Japan 1863
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Troops land at Shimonoseki', 'Japan', 'Troops land at Shimonoseki.', 1863, NULL,
         36.2 + (random() - 0.5) * 0.6, 138.3 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Japan' AND start_year = 1863);

  -- 44. Japan 1864
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Troops land in Yedo (Tokyo)', 'Japan', 'Troops land in Yedo (Tokyo).', 1864, NULL,
         36.2 + (random() - 0.5) * 0.6, 138.3 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Japan' AND start_year = 1864);

  -- 45. Colombia 1865
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines in Panama region', 'Colombia', 'Marines land in Panama region.', 1865, NULL,
         4.6 + (random() - 0.5) * 0.6, -74.1 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Colombia' AND start_year = 1865);

  -- 46. China 1866
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines land in Newchwang', 'China', 'Marines land in Newchwang.', 1866, NULL,
         35.9 + (random() - 0.5) * 0.6, 104.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'China' AND start_year = 1866);

  -- 47. Nicaragua 1867
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines land in Managua and Leon', 'Nicaragua', 'Marines land in Managua and Leon.', 1867, NULL,
         12.9 + (random() - 0.5) * 0.6, -85.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Nicaragua' AND start_year = 1867);

  -- 48. Formosa 1867
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines land on Formosa', 'Formosa', 'Marines land on Formosa Island (Taiwan).', 1867, NULL,
         23.7 + (random() - 0.5) * 0.6, 120.9 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Formosa' AND start_year = 1867);

  -- 49. Midway Island 1867
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Seizure of Midway Island', 'Midway Island', 'Naval forces seize Midway Island for a naval base.', 1867, NULL,
         28.2 + (random() - 0.5) * 0.6, -177.4 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Midway Island' AND start_year = 1867);

  -- 50. Japan 1868
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Naval forces in multiple Japanese ports', 'Japan', 'Naval forces deployed at Osaka, Hiogo, Nagasaki, Yokohama and Negata.', 1868, NULL,
         36.2 + (random() - 0.5) * 0.6, 138.3 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Japan' AND start_year = 1868);

  -- 51. Uruguay 1868
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines land in Montevideo', 'Uruguay', 'Marines land at Montevideo.', 1868, NULL,
         -32.5 + (random() - 0.5) * 0.6, -55.7 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Uruguay' AND start_year = 1868);

  -- 52. Colombia 1870
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines land in Colombia', 'Colombia', 'Marines land in Colombia.', 1870, NULL,
         4.6 + (random() - 0.5) * 0.6, -74.1 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Colombia' AND start_year = 1870);

  -- 53. Korea 1871
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'US forces land in Korea', 'Korea', 'US forces land in Korea.', 1871, NULL,
         37.0 + (random() - 0.5) * 0.6, 127.5 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Korea' AND start_year = 1871);

  -- 54. Colombia 1873
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines in Panama region', 'Colombia', 'Marines land in Panama region.', 1873, NULL,
         4.6 + (random() - 0.5) * 0.6, -74.1 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Colombia' AND start_year = 1873);

  -- 55. Hawaii 1874
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Sailors and marines land in Hawaii', 'Hawaii', 'Sailors and marines land in Hawaii.', 1874, NULL,
         19.9 + (random() - 0.5) * 0.6, -155.6 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Hawaii' AND start_year = 1874);

  -- 56. Mexico 1876 - Matamoros occupation
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Army occupies Matamoros', 'Mexico', 'Army occupies Matamoros.', 1876, NULL,
         23.6 + (random() - 0.5) * 0.6, -102.5 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Mexico' AND start_year = 1876);

  -- 57. Egypt 1882
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Troops land in Egypt', 'Egypt', 'Troops land in British Egypt.', 1882, NULL,
         26.8 + (random() - 0.5) * 0.6, 30.8 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Egypt' AND start_year = 1882);

  -- 58. Colombia 1885
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Troops in Colon and Panama City', 'Colombia', 'Troops land in Colon and Panama City.', 1885, NULL,
         4.6 + (random() - 0.5) * 0.6, -74.1 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Colombia' AND start_year = 1885);

  -- 59. Samoa 1885
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Naval force in Samoa', 'Samoa', 'Naval force deployed in Samoa.', 1885, NULL,
         -13.8 + (random() - 0.5) * 0.6, -172.0 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Samoa' AND start_year = 1885);

  -- 60. Hawaii 1887
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Pearl Harbor naval base rights', 'Hawaii', 'Navy gains right to build permanent base at Pearl Harbor.', 1887, NULL,
         19.9 + (random() - 0.5) * 0.6, -155.6 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Hawaii' AND start_year = 1887);

  -- 61. Haiti 1888
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Troops land in Haiti', 'Haiti', 'Troops land in Haiti.', 1888, NULL,
         19.0 + (random() - 0.5) * 0.6, -72.3 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Haiti' AND start_year = 1888);

  -- 62. Samoa 1888
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines land in Samoa', 'Samoa', 'Marines land in Samoa.', 1888, NULL,
         -13.8 + (random() - 0.5) * 0.6, -172.0 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Samoa' AND start_year = 1888);

  -- 63. Samoa 1889
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Naval clash with Germany in Samoa', 'Samoa', 'Naval clash with German forces in Samoa.', 1889, NULL,
         -13.8 + (random() - 0.5) * 0.6, -172.0 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Samoa' AND start_year = 1889);

  -- 64. Argentina 1890
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Sailors land in Buenos Aires', 'Argentina', 'US sailors land in Buenos Aires to protect interests.', 1890, NULL,
         -38.4 + (random() - 0.5) * 0.6, -63.6 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Argentina' AND start_year = 1890);

  -- 65. Chile 1891
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Sailors land in Valparaiso', 'Chile', 'US sailors land in Valparaiso. Marines clash with nationalist rebels.', 1891, NULL,
         -35.7 + (random() - 0.5) * 0.6, -71.5 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Chile' AND start_year = 1891);

  -- 66. Haiti 1891
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines on Navassa Island', 'Haiti', 'Marines land on US-claimed Navassa Island.', 1891, NULL,
         19.0 + (random() - 0.5) * 0.6, -72.3 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Haiti' AND start_year = 1891);

  -- 67. Hawaii 1893 - Overthrow of monarchy
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Overthrow of Hawaiian monarchy', 'Hawaii', 'Marines and naval forces overthrow the Hawaiian monarchy.', 1893, NULL,
         19.9 + (random() - 0.5) * 0.6, -155.6 + (random() - 0.5) * 0.6, t_golpe
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Hawaii' AND start_year = 1893);

  -- 68. Nicaragua 1894
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines at Bluefields', 'Nicaragua', 'Marines land at Bluefields on the eastern coast.', 1894, NULL,
         12.9 + (random() - 0.5) * 0.6, -85.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Nicaragua' AND start_year = 1894);

  -- 69. China 1894
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines in Tientsin and Beijing', 'China', 'Marines stationed at Tientsin and Beijing during Sino-Japanese War.', 1894, 1895,
         35.9 + (random() - 0.5) * 0.6, 104.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'China' AND start_year = 1894);

  -- 70. Korea 1894
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines in Seoul', 'Korea', 'Marines land and remain in Seoul.', 1894, 1896,
         37.0 + (random() - 0.5) * 0.6, 127.5 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Korea' AND start_year = 1894);

  -- 71. Colombia 1895
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines to Bocas del Toro', 'Colombia', 'Marines sent to Bocas del Toro.', 1895, NULL,
         4.6 + (random() - 0.5) * 0.6, -74.1 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Colombia' AND start_year = 1895);

  -- 72. Nicaragua 1896
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines at Corinto', 'Nicaragua', 'Marines land in port of Corinto.', 1896, NULL,
         12.9 + (random() - 0.5) * 0.6, -85.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Nicaragua' AND start_year = 1896);

  -- 73. Nicaragua 1898
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines at San Juan del Sur', 'Nicaragua', 'Marines land at port of San Juan del Sur.', 1898, NULL,
         12.9 + (random() - 0.5) * 0.6, -85.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Nicaragua' AND start_year = 1898);

  -- 74. Guam 1898
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Seizure of Guam', 'Guam', 'Naval forces seize Guam from Spain. US holds island permanently.', 1898, NULL,
         13.4 + (random() - 0.5) * 0.6, 144.8 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Guam' AND start_year = 1898);

  -- 75. Puerto Rico 1898
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Seizure of Puerto Rico', 'Puerto Rico', 'Naval and land forces seize Puerto Rico from Spain permanently.', 1898, NULL,
         18.2 + (random() - 0.5) * 0.6, -66.6 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Puerto Rico' AND start_year = 1898);

  -- 76. Philippines 1898 - Spanish-American War / Counter-insurgency
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Conquest of the Philippines', 'Philippines', 'Naval forces defeat Spanish fleet. US takes control; 600,000 Filipinos killed in counter-insurgency.', 1898, 1910,
         12.9 + (random() - 0.5) * 0.6, 121.8 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Philippines' AND start_year = 1898);

  -- 77. Samoa 1899
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Naval forces in Samoa', 'Samoa', 'Naval forces land in Samoa.', 1899, NULL,
         -13.8 + (random() - 0.5) * 0.6, -172.0 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Samoa' AND start_year = 1899);

  -- 78. Nicaragua 1899
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines at Bluefields', 'Nicaragua', 'Marines land at Bluefields.', 1899, NULL,
         12.9 + (random() - 0.5) * 0.6, -85.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Nicaragua' AND start_year = 1899);

  -- =========================================================================
  -- ERA 3: 1900–1945 (40 interventions)
  -- =========================================================================

  -- 79. China 1900 - Boxer Rebellion
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Boxer Rebellion intervention', 'China', 'US forces intervene in several Chinese cities during Boxer Rebellion.', 1900, NULL,
         35.9 + (random() - 0.5) * 0.6, 104.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'China' AND start_year = 1900);

  -- 80. Colombia 1901
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines in Panama region', 'Colombia', 'Marines land in Panama region.', 1901, NULL,
         4.6 + (random() - 0.5) * 0.6, -74.1 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Colombia' AND start_year = 1901);

  -- 81. Colombia 1902
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Forces in Bocas de Toro', 'Colombia', 'US forces land in Bocas de Toro.', 1902, NULL,
         4.6 + (random() - 0.5) * 0.6, -74.1 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Colombia' AND start_year = 1902);

  -- 82. Panama 1903 - Independence and Canal Zone
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Panama independence and Canal Zone', 'Panama', 'US backs Panama independence from Colombia. Canal Zone annexed, canal opened 1914.', 1903, 1914,
         8.5 + (random() - 0.5) * 0.6, -80.8 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Panama' AND start_year = 1903);

  -- 83. Guam 1903
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Naval base development at Apra Harbor', 'Guam', 'Navy begins development of permanent base at Apra Harbor.', 1903, NULL,
         13.4 + (random() - 0.5) * 0.6, 144.8 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Guam' AND start_year = 1903);

  -- 84. Honduras 1903
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines at Puerto Cortez', 'Honduras', 'Marines go ashore at Puerto Cortez during revolution.', 1903, NULL,
         15.2 + (random() - 0.5) * 0.6, -86.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Honduras' AND start_year = 1903);

  -- 85. Dominican Rep 1903
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines in Santo Domingo', 'Dominican Rep', 'Marines land in Santo Domingo to protect US interests.', 1903, 1904,
         18.7 + (random() - 0.5) * 0.6, -70.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Dominican Rep' AND start_year = 1903);

  -- 86. Korea 1904
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines in Seoul during Russo-Japanese War', 'Korea', 'Marines land and stay in Seoul during Russo-Japanese War.', 1904, 1905,
         37.0 + (random() - 0.5) * 0.6, 127.5 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Korea' AND start_year = 1904);

  -- 87. Cuba 1906 - Occupation and Guantanamo
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Occupation and Guantanamo Bay base', 'Cuba', 'Marines land and occupy. US builds major base at Guantanamo Bay.', 1906, 1909,
         21.5 + (random() - 0.5) * 0.6, -77.8 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Cuba' AND start_year = 1906);

  -- 88. Nicaragua 1907
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Dollar Diplomacy protectorate', 'Nicaragua', 'Troops seize major centers. Dollar Diplomacy protectorate established.', 1907, NULL,
         12.9 + (random() - 0.5) * 0.6, -85.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Nicaragua' AND start_year = 1907);

  -- 89. Honduras 1907
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines in multiple Honduran cities', 'Honduras', 'Marines land in Trujillo, Ceiba, Puerto Cortez and other cities.', 1907, NULL,
         15.2 + (random() - 0.5) * 0.6, -86.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Honduras' AND start_year = 1907);

  -- 90. Panama 1908
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines during election', 'Panama', 'Marines land and carry out operations during election.', 1908, NULL,
         8.5 + (random() - 0.5) * 0.6, -80.8 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Panama' AND start_year = 1908);

  -- 91. Nicaragua 1909
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Support for rebels against Zelaya', 'Nicaragua', 'US supports rebels against Zelaya government.', 1909, NULL,
         12.9 + (random() - 0.5) * 0.6, -85.2 + (random() - 0.5) * 0.6, t_injerencia
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Nicaragua' AND start_year = 1909);

  -- 92. Nicaragua 1910
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines in Bluefields and Corinto', 'Nicaragua', 'Marines land in Bluefields and Corinto.', 1910, NULL,
         12.9 + (random() - 0.5) * 0.6, -85.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Nicaragua' AND start_year = 1910);

  -- 93. Honduras 1911
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines intervene in civil war', 'Honduras', 'Marines intervene to protect US interests in civil war.', 1911, NULL,
         15.2 + (random() - 0.5) * 0.6, -86.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Honduras' AND start_year = 1911);

  -- 94. China 1911 - Long-term military presence
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Long-term military presence in China', 'China', 'US builds military presence to 5,000 troops and 44 vessels patrolling coast and rivers.', 1911, 1941,
         35.9 + (random() - 0.5) * 0.6, 104.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'China' AND start_year = 1911);

  -- 95. Cuba 1912
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Army troops in Havana', 'Cuba', 'US sends army troops into combat in Havana.', 1912, NULL,
         21.5 + (random() - 0.5) * 0.6, -77.8 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Cuba' AND start_year = 1912);

  -- 96. Panama 1912
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Army intervention during election', 'Panama', 'Army troops intervene during heated election.', 1912, NULL,
         8.5 + (random() - 0.5) * 0.6, -80.8 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Panama' AND start_year = 1912);

  -- 97. Honduras 1912
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines protect US economic interests', 'Honduras', 'Marines land to protect US economic interests.', 1912, NULL,
         15.2 + (random() - 0.5) * 0.6, -86.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Honduras' AND start_year = 1912);

  -- 98. Nicaragua 1912 - 20-year occupation
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT '20-year occupation of Nicaragua', 'Nicaragua', 'Marines intervene. 20-year occupation fighting Sandinista rebels.', 1912, 1933,
         12.9 + (random() - 0.5) * 0.6, -85.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Nicaragua' AND start_year = 1912);

  -- 99. Mexico 1913 - Coup against Madero
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Coup against President Madero', 'Mexico', 'US Amb. H.L. Wilson organizes coup vs Pres. Madero. Marines land.', 1913, NULL,
         23.6 + (random() - 0.5) * 0.6, -102.5 + (random() - 0.5) * 0.6, t_golpe
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Mexico' AND start_year = 1913);

  -- 100. Dominican Rep 1914 - Naval battles
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Naval battles in Santo Domingo', 'Dominican Rep', 'Naval forces engage in battles in Santo Domingo.', 1914, NULL,
         18.7 + (random() - 0.5) * 0.6, -70.2 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Dominican Rep' AND start_year = 1914);

  -- 101. Mexico 1914 - Veracruz occupation
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Veracruz occupation and interventions', 'Mexico', 'US forces seize and occupy Veracruz. Series of interventions against nationalists.', 1914, 1918,
         23.6 + (random() - 0.5) * 0.6, -102.5 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Mexico' AND start_year = 1914);

  -- 102. Haiti 1914 - 19-year occupation
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT '19-year occupation of Haiti', 'Haiti', 'Troops land, aerial bombardment. 19-year military occupation.', 1914, 1934,
         19.0 + (random() - 0.5) * 0.6, -72.3 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Haiti' AND start_year = 1914);

  -- 103. Mexico 1915 - Pershing expedition
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Pershing expeditionary force', 'Mexico', 'Expeditionary force under Gen. Pershing penetrates hundreds of miles into Mexico. Over 11,000 troops.', 1915, 1916,
         23.6 + (random() - 0.5) * 0.6, -102.5 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Mexico' AND start_year = 1915);

  -- 104. Dominican Rep 1916 - 8-year occupation
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT '8-year occupation of Dominican Republic', 'Dominican Rep', 'Military intervention leading to 8-year occupation.', 1916, 1924,
         18.7 + (random() - 0.5) * 0.6, -70.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Dominican Rep' AND start_year = 1916);

  -- 105. Cuba 1917 - 15-year occupation
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT '15-year occupation of Cuba', 'Cuba', 'Landing of naval forces. 15-year occupation.', 1917, 1933,
         21.5 + (random() - 0.5) * 0.6, -77.8 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Cuba' AND start_year = 1917);

  -- 106. Panama 1918 - Police duty
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Troops on police duty', 'Panama', 'Troops intervene, remain on police duty for over 2 years.', 1918, 1920,
         8.5 + (random() - 0.5) * 0.6, -80.8 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Panama' AND start_year = 1918);

  -- 107. Russia 1918 - Bolshevik intervention
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Intervention during Bolshevik Revolution', 'Russia', 'Naval forces and army troops fight battles during Bolshevik Revolution.', 1918, 1922,
         61.5 + (random() - 0.5) * 0.6, 105.3 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Russia' AND start_year = 1918);

  -- 108. Yugoslavia 1919
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines in Dalmatia', 'Yugoslavia', 'Marines intervene in Dalmatia for Italy against Serbs.', 1919, NULL,
         44.0 + (random() - 0.5) * 0.6, 21.0 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Yugoslavia' AND start_year = 1919);

  -- 109. Honduras 1919
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines during election', 'Honduras', 'Marines land during election campaign.', 1919, NULL,
         15.2 + (random() - 0.5) * 0.6, -86.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Honduras' AND start_year = 1919);

  -- 110. Guatemala 1920
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Intervention against unionists', 'Guatemala', '2-week intervention against unionists.', 1920, NULL,
         15.8 + (random() - 0.5) * 0.6, -90.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Guatemala' AND start_year = 1920);

  -- 111. Turkey 1922
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines in Smyrna (Izmir)', 'Turkey', 'Marines engaged in operations in Smyrna (Izmir) against Turkish nationalists.', 1922, NULL,
         38.9 + (random() - 0.5) * 0.6, 35.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Turkey' AND start_year = 1922);

  -- 112. China 1922 - Nationalist revolt
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Forces during nationalist revolt', 'China', 'Naval forces and troops deployed during nationalist revolt.', 1922, 1927,
         35.9 + (random() - 0.5) * 0.6, 104.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'China' AND start_year = 1922);

  -- 113. Honduras 1924
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Troops during election strife', 'Honduras', 'Troops land twice during election strife.', 1924, 1925,
         15.2 + (random() - 0.5) * 0.6, -86.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Honduras' AND start_year = 1924);

  -- 114. Panama 1925 - General strike suppression
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines suppress general strike', 'Panama', 'Marines suppress general strike.', 1925, NULL,
         8.5 + (random() - 0.5) * 0.6, -80.8 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Panama' AND start_year = 1925);

  -- 115. China 1927 - Marines stationed
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines and naval forces throughout China', 'China', 'Marines and naval forces stationed throughout China.', 1927, 1934,
         35.9 + (random() - 0.5) * 0.6, 104.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'China' AND start_year = 1927);

  -- 116. El Salvador 1932
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Naval intervention during Marti revolt', 'El Salvador', 'Naval forces intervene during Farabundo Marti revolt.', 1932, NULL,
         13.8 + (random() - 0.5) * 0.6, -88.9 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'El Salvador' AND start_year = 1932);

  -- 117. Cuba 1933 - Abandons Machado
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Withdrawal of support for Machado', 'Cuba', 'US abandons support for Pres. Machado.', 1933, NULL,
         21.5 + (random() - 0.5) * 0.6, -77.8 + (random() - 0.5) * 0.6, t_injerencia
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Cuba' AND start_year = 1933);

  -- 118. Cuba 1934 - Batista coup
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Batista coup against Grau', 'Cuba', 'US sponsors coup by Col. Batista to oust Pres. Grau.', 1934, NULL,
         21.5 + (random() - 0.5) * 0.6, -77.8 + (random() - 0.5) * 0.6, t_golpe
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Cuba' AND start_year = 1934);

  -- 119. China 1934 - Marines in Foochow
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines land in Foochow', 'China', 'Marines land in Foochow.', 1934, NULL,
         35.9 + (random() - 0.5) * 0.6, 104.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'China' AND start_year = 1934);

  -- =========================================================================
  -- ERA 4: 1946–1959 (13 interventions)
  -- =========================================================================

  -- 120. Iran 1946
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Troops in northern Iran', 'Iran', 'Troops deployed in northern province. Soviets pressured to withdraw.', 1946, NULL,
         32.4 + (random() - 0.5) * 0.6, 53.7 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Iran' AND start_year = 1946);

  -- 121. Yugoslavia 1946
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Naval response to plane shoot-down', 'Yugoslavia', 'Naval response to shoot-down of US plane.', 1946, NULL,
         44.0 + (random() - 0.5) * 0.6, 21.0 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Yugoslavia' AND start_year = 1946);

  -- 122. Italy 1948
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'CIA election interference', 'Italy', 'Heavy CIA involvement in national elections to prevent Communist victory.', 1948, NULL,
         41.9 + (random() - 0.5) * 0.6, 12.5 + (random() - 0.5) * 0.6, t_injerencia
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Italy' AND start_year = 1948);

  -- 123. China 1948
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Major army presence before Communist victory', 'China', 'Major US army presence ~100,000 troops. Marines evacuate before Communist victory.', 1948, 1949,
         35.9 + (random() - 0.5) * 0.6, 104.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'China' AND start_year = 1948);

  -- 124. Philippines 1948 - Huk Rebellion
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'CIA operations against Huk Rebellion', 'Philippines', 'CIA directs commando operations and secret war against Huk Rebellion.', 1948, 1954,
         12.9 + (random() - 0.5) * 0.6, 121.8 + (random() - 0.5) * 0.6, t_encubierta
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Philippines' AND start_year = 1948);

  -- 125. Puerto Rico 1950
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Independence rebellion crushed', 'Puerto Rico', 'Independence rebellion crushed in Ponce.', 1950, NULL,
         18.2 + (random() - 0.5) * 0.6, -66.6 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Puerto Rico' AND start_year = 1950);

  -- 126. North Korea 1950 - Korean War (Ocupación Militar variant)
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Korean War ground operations', 'North Korea', 'Korean War. US/South Korea vs China/North Korea. Nuclear threats.', 1950, 1953,
         40.3 + (random() - 0.5) * 0.6, 127.5 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'North Korea' AND start_year = 1950 AND type_id = t_ocupacion);

  -- 127. Vietnam 1954 - Dien Bien Phu support
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Support for French at Dien Bien Phu', 'Vietnam', 'Financial and materiel support for French colonial operations at Dien Bien Phu.', 1954, NULL,
         14.1 + (random() - 0.5) * 0.6, 108.3 + (random() - 0.5) * 0.6, t_injerencia
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Vietnam' AND start_year = 1954);

  -- 128. Egypt 1956 - Suez Crisis
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Suez Crisis response', 'Egypt', 'Soviets told to keep out of Suez Crisis. Marines evacuate foreigners.', 1956, NULL,
         26.8 + (random() - 0.5) * 0.6, 30.8 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Egypt' AND start_year = 1956);

  -- 129. Lebanon 1958
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines and army land against rebels', 'Lebanon', 'US marines and army (14,000 troops) land against rebels.', 1958, NULL,
         33.9 + (random() - 0.5) * 0.6, 35.9 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Lebanon' AND start_year = 1958);

  -- 130. Iraq 1958 - Kuwait warning
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Warning against invading Kuwait', 'Iraq', 'Iraq warned against invading Kuwait. Nuclear threat.', 1958, NULL,
         33.2 + (random() - 0.5) * 0.6, 43.7 + (random() - 0.5) * 0.6, t_injerencia
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Iraq' AND start_year = 1958);

  -- 131. Panama 1958 - Canal Zone confrontation
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Canal Zone flag confrontation', 'Panama', 'Flag protests erupt into Canal Zone confrontation.', 1958, NULL,
         8.5 + (random() - 0.5) * 0.6, -80.8 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Panama' AND start_year = 1958);

  -- 132. Cuba 1959 - Haiti marines
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines land in Haiti (regional instability)', 'Cuba', 'Marines land in Haiti (response to regional instability).', 1959, NULL,
         21.5 + (random() - 0.5) * 0.6, -77.8 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Cuba' AND start_year = 1959);

  -- =========================================================================
  -- ERA 5: 1960–1979 (15 interventions)
  -- =========================================================================

  -- 133. Vietnam 1960 - Full-scale war
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Vietnam War ground operations', 'Vietnam', 'Full-scale war. Up to 500,000+ troops. 1 million+ killed.', 1960, 1975,
         14.1 + (random() - 0.5) * 0.6, 108.3 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Vietnam' AND start_year = 1960);

  -- 134. Cuba 1961 - Bay of Pigs
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Bay of Pigs invasion', 'Cuba', 'CIA-directed Bay of Pigs exile invasion fails.', 1961, NULL,
         21.5 + (random() - 0.5) * 0.6, -77.8 + (random() - 0.5) * 0.6, t_encubierta
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Cuba' AND start_year = 1961);

  -- 135. Cuba 1962 - Missile Crisis
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Cuban Missile Crisis blockade', 'Cuba', 'Nuclear threat and naval blockade during missile crisis. Near-war with Soviets.', 1962, NULL,
         21.5 + (random() - 0.5) * 0.6, -77.8 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Cuba' AND start_year = 1962);

  -- 136. Laos 1962 - CIA buildup
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'CIA military buildup', 'Laos', 'CIA-backed military buildup during Pathet Lao guerrilla war.', 1962, NULL,
         19.9 + (random() - 0.5) * 0.6, 102.5 + (random() - 0.5) * 0.6, t_encubierta
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Laos' AND start_year = 1962);

  -- 137. Iraq 1963 - CIA coup
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'CIA coup brings Baath Party to power', 'Iraq', 'CIA organizes coup that kills president, brings Baath Party to power with Saddam Hussein.', 1963, NULL,
         33.2 + (random() - 0.5) * 0.6, 43.7 + (random() - 0.5) * 0.6, t_golpe
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Iraq' AND start_year = 1963);

  -- 138. Ecuador 1963 - CIA-backed coup
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'CIA-backed military overthrow', 'Ecuador', 'CIA backs military overthrow of President Jose Maria Velasco Ibarra.', 1963, NULL,
         -1.8 + (random() - 0.5) * 0.6, -78.2 + (random() - 0.5) * 0.6, t_golpe
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Ecuador' AND start_year = 1963);

  -- 139. Panama 1964 - Canal Zone clashes
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Canal Zone clashes', 'Panama', 'Panamanians shot for urging canals return. Clashes with US forces.', 1964, NULL,
         8.5 + (random() - 0.5) * 0.6, -80.8 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Panama' AND start_year = 1964);

  -- 140. Indonesia 1965 - CIA coup against Sukarno
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'CIA-assisted coup against Sukarno', 'Indonesia', 'CIA-assisted army coup overthrows Pres. Sukarno. 1 million+ killed.', 1965, NULL,
         -0.8 + (random() - 0.5) * 0.6, 113.9 + (random() - 0.5) * 0.6, t_golpe
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Indonesia' AND start_year = 1965);

  -- 141. Congo 1965 - Mobutu coup
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'CIA-backed Mobutu coup', 'Congo', 'CIA-backed coup overthrows Pres. Kasavubu. Mobutu takes power.', 1965, NULL,
         -4.0 + (random() - 0.5) * 0.6, 21.7 + (random() - 0.5) * 0.6, t_golpe
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Congo' AND start_year = 1965);

  -- 142. Laos 1965 - Carpet bombing
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Carpet bombing of Ho Chi Minh Trail', 'Laos', 'Bombing campaign lasting eight years. Carpet-bombing along Ho Chi Minh Trail.', 1965, 1973,
         19.9 + (random() - 0.5) * 0.6, 102.5 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Laos' AND start_year = 1965);

  -- 143. Ghana 1966 - CIA coup
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'CIA-backed coup against Nkrumah', 'Ghana', 'CIA-backed military coup ousts President Kwame Nkrumah.', 1966, NULL,
         7.9 + (random() - 0.5) * 0.6, -1.0 + (random() - 0.5) * 0.6, t_golpe
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Ghana' AND start_year = 1966);

  -- 144. Guatemala 1966 - Counter-insurgency
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Green Beret counter-insurgency', 'Guatemala', 'Extensive counter-insurgency operation with Green Berets.', 1966, 1967,
         15.8 + (random() - 0.5) * 0.6, -90.2 + (random() - 0.5) * 0.6, t_encubierta
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Guatemala' AND start_year = 1966);

  -- 145. Oman 1970
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'US-directed Iranian marine invasion', 'Oman', 'US directs Iranian marine invasion for counter-insurgency.', 1970, NULL,
         21.5 + (random() - 0.5) * 0.6, 55.9 + (random() - 0.5) * 0.6, t_encubierta
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Oman' AND start_year = 1970);

  -- 146. Laos 1971 - South Vietnamese invasion
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'US-directed South Vietnamese invasion', 'Laos', 'US directs South Vietnamese invasion.', 1971, 1973,
         19.9 + (random() - 0.5) * 0.6, 102.5 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Laos' AND start_year = 1971);

  -- 147. Cambodia 1975 - Mayaguez incident
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Mayaguez incident', 'Cambodia', 'Marines land, engage in combat. Gassing of captured ship Mayaguez.', 1975, NULL,
         12.6 + (random() - 0.5) * 0.6, 104.9 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Cambodia' AND start_year = 1975);

  -- =========================================================================
  -- ERA 6: 1980–1989 (10 interventions)
  -- =========================================================================

  -- 148. Iran 1980 - Hostage rescue
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Embassy hostage rescue raid', 'Iran', 'Raid to rescue embassy hostages. 8 troops die in helicopter crash.', 1980, NULL,
         32.4 + (random() - 0.5) * 0.6, 53.7 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Iran' AND start_year = 1980);

  -- 149. Libya 1981 - Naval clash
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Libyan jets shot down', 'Libya', 'Two Libyan jets shot down in naval maneuvers over Mediterranean.', 1981, NULL,
         26.3 + (random() - 0.5) * 0.6, 17.2 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Libya' AND start_year = 1981);

  -- 150. El Salvador 1981 - CIA counterinsurgency
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'CIA and Special Forces counterinsurgency', 'El Salvador', 'CIA and Special Forces wage long counterinsurgency campaign.', 1981, 1992,
         13.8 + (random() - 0.5) * 0.6, -88.9 + (random() - 0.5) * 0.6, t_encubierta
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'El Salvador' AND start_year = 1981);

  -- 151. Lebanon 1982 - Marines and Navy
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines and Navy in Lebanon', 'Lebanon', 'Marines expel PLO. Navy shells Muslim rebels. 241 Marines killed in barracks bombing.', 1982, 1984,
         33.9 + (random() - 0.5) * 0.6, 35.9 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Lebanon' AND start_year = 1982);

  -- 152. Honduras 1983 - Military buildup
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Military buildup near Nicaragua', 'Honduras', 'Large military assistance program. Maneuvers build bases near Nicaragua.', 1983, 1989,
         15.2 + (random() - 0.5) * 0.6, -86.2 + (random() - 0.5) * 0.6, t_injerencia
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Honduras' AND start_year = 1983);

  -- 153. Iran 1984 - Jets shot down
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Iranian jets shot down', 'Iran', 'Two Iranian jets shot down over Persian Gulf.', 1984, NULL,
         32.4 + (random() - 0.5) * 0.6, 53.7 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Iran' AND start_year = 1984);

  -- 154. Bolivia 1986 - Drug raids
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Special Forces cocaine raids', 'Bolivia', 'Special Forces assist raids on cocaine-producing region.', 1986, NULL,
         -16.3 + (random() - 0.5) * 0.6, -68.1 + (random() - 0.5) * 0.6, t_encubierta
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Bolivia' AND start_year = 1986);

  -- 155. Iran 1987 - Operation Praying Mantis
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Operation Praying Mantis', 'Iran', 'Naval forces block Iranian shipping. Civilian airliner shot down (Operation Praying Mantis).', 1987, 1988,
         32.4 + (random() - 0.5) * 0.6, 53.7 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Iran' AND start_year = 1987 AND type_id = t_naval);

  -- 156. Libya 1989 - Jets shot down
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Libyan jets shot down over Gulf of Sidra', 'Libya', 'Two Libyan jets shot down over Gulf of Sidra.', 1989, NULL,
         26.3 + (random() - 0.5) * 0.6, 17.2 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Libya' AND start_year = 1989);

  -- 157. Philippines 1989 - Air cover
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Air cover against coup attempt', 'Philippines', 'Air cover provided for government against coup attempt.', 1989, NULL,
         12.9 + (random() - 0.5) * 0.6, 121.8 + (random() - 0.5) * 0.6, t_injerencia
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Philippines' AND start_year = 1989);

  -- 158. Panama 1989 - Invasion (Ocupación Militar variant)
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Invasion of Panama - 27,000 troops', 'Panama', '27,000 troops invade. Noriega govt ousted. 2,000+ killed.', 1989, 1990,
         8.5 + (random() - 0.5) * 0.6, -80.8 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Panama' AND start_year = 1989 AND type_id = t_ocupacion);

  -- =========================================================================
  -- ERA 7: 1990–1999 (14 interventions)
  -- =========================================================================

  -- 159. Liberia 1990
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Troops evacuate foreigners', 'Liberia', 'Troops deployed to evacuate foreigners during civil war.', 1990, NULL,
         6.4 + (random() - 0.5) * 0.6, -9.4 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Liberia' AND start_year = 1990);

  -- 160. Saudi Arabia 1990 - Desert Shield
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Desert Shield troop deployment', 'Saudi Arabia', '540,000 troops stationed. Also deployed in Oman, Qatar, Bahrain, UAE, Israel.', 1990, 1991,
         23.9 + (random() - 0.5) * 0.6, 45.1 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Saudi Arabia' AND start_year = 1990);

  -- 161. Iraq 1990 - Gulf War
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Gulf War', 'Iraq', 'Gulf War. Blockade, air strikes, ground invasion. 200,000+ killed.', 1990, 1991,
         33.2 + (random() - 0.5) * 0.6, 43.7 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Iraq' AND start_year = 1990);

  -- 162. Kuwait 1991
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Kuwait liberation', 'Kuwait', 'Kuwait royal family restored to throne after Iraqi occupation.', 1991, NULL,
         29.3 + (random() - 0.5) * 0.6, 47.5 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Kuwait' AND start_year = 1991);

  -- 163. Iraq 1991 - No-fly zones
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'No-fly zones and sanctions', 'Iraq', 'No-fly zones over Kurdish north and Shia south. Constant air strikes and sanctions.', 1991, 2003,
         33.2 + (random() - 0.5) * 0.6, 43.7 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Iraq' AND start_year = 1991 AND type_id = t_bombardeo);

  -- 164. Haiti 1991 - CIA coup
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'CIA-backed coup against Aristide', 'Haiti', 'CIA-backed military coup ousts President Aristide.', 1991, NULL,
         19.0 + (random() - 0.5) * 0.6, -72.3 + (random() - 0.5) * 0.6, t_golpe
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Haiti' AND start_year = 1991);

  -- 165. Yugoslavia 1992 - NATO blockade
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'NATO blockade of Serbia/Montenegro', 'Yugoslavia', 'Major role in NATO blockade of Serbia and Montenegro.', 1992, 1994,
         44.0 + (random() - 0.5) * 0.6, 21.0 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Yugoslavia' AND start_year = 1992);

  -- 166. Bosnia 1993 - No-fly zone
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'No-fly zone and bombing of Serbs', 'Bosnia', 'No-fly zone. Downed jets, bombed Serbs (Operation Deliberate Force).', 1993, 1995,
         43.9 + (random() - 0.5) * 0.6, 17.7 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Bosnia' AND start_year = 1993);

  -- 167. Croatia 1995
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Krajina Serb airfields attacked', 'Croatia', 'Krajina Serb airfields attacked.', 1995, NULL,
         45.1 + (random() - 0.5) * 0.6, 15.2 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Croatia' AND start_year = 1995);

  -- 168. Zaire 1996
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Marines in eastern Congo', 'Zaire', 'Marines involved in operations in eastern Congo.', 1996, 1997,
         -4.0 + (random() - 0.5) * 0.6, 21.7 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Zaire' AND start_year = 1996);

  -- 169. Liberia 1997
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Troops under fire during evacuation', 'Liberia', 'Troops deployed. Soldiers under fire during evacuation.', 1997, NULL,
         6.4 + (random() - 0.5) * 0.6, -9.4 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Liberia' AND start_year = 1997);

  -- 170. Albania 1997
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Evacuation under fire', 'Albania', 'Soldiers under fire during evacuation of foreigners.', 1997, NULL,
         41.2 + (random() - 0.5) * 0.6, 20.2 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Albania' AND start_year = 1997);

  -- 171. Afghanistan 1998 - Missile attack
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Missile attack on Al Qaeda camps', 'Afghanistan', 'Missile attack on former CIA training camps used by Al Qaeda.', 1998, NULL,
         33.9 + (random() - 0.5) * 0.6, 67.7 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Afghanistan' AND start_year = 1998);

  -- =========================================================================
  -- ERA 8: 2000–Present (15 interventions)
  -- =========================================================================

  -- 172. Yemen 2000 - USS Cole
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'USS Cole incident', 'Yemen', 'USS Cole bombed by Al Qaeda in port of Aden.', 2000, NULL,
         15.5 + (random() - 0.5) * 0.6, 48.5 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Yemen' AND start_year = 2000);

  -- 173. Macedonia 2001
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'NATO disarms Albanian rebels', 'Macedonia', 'NATO troops disarm and relocate Kosovo Albanian rebels.', 2001, NULL,
         41.5 + (random() - 0.5) * 0.6, 21.7 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Macedonia' AND start_year = 2001);

  -- 174. Philippines 2002 - Mindanao
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Combat missions in Mindanao', 'Philippines', 'Training mission evolves into combat missions in Mindanao vs Abu Sayyaf.', 2002, NULL,
         12.9 + (random() - 0.5) * 0.6, 121.8 + (random() - 0.5) * 0.6, t_encubierta
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Philippines' AND start_year = 2002);

  -- 175. Colombia 2003 - Pipeline protection
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Special Forces protect oil pipeline', 'Colombia', 'Special Forces protect oil pipeline and back Colombian military vs rebels.', 2003, 2022,
         4.6 + (random() - 0.5) * 0.6, -74.1 + (random() - 0.5) * 0.6, t_encubierta
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Colombia' AND start_year = 2003);

  -- 176. Liberia 2003 - Peacekeeping
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Peacekeeping force', 'Liberia', 'Troops in peacekeeping force as rebels expel leader.', 2003, NULL,
         6.4 + (random() - 0.5) * 0.6, -9.4 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Liberia' AND start_year = 2003);

  -- 177. Haiti 2004 - Aristide ousted again
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'CIA-backed forces oust Aristide', 'Haiti', 'Marines and Army land after CIA-backed forces oust President Aristide.', 2004, 2005,
         19.0 + (random() - 0.5) * 0.6, -72.3 + (random() - 0.5) * 0.6, t_golpe
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Haiti' AND start_year = 2004);

  -- 178. Pakistan 2005 - CIA drone strikes
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'CIA drone strikes and Special Forces raids', 'Pakistan', 'CIA drone strikes, air strikes, Special Forces raids. Hundreds of civilians killed.', 2005, 2021,
         30.4 + (random() - 0.5) * 0.6, 69.3 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Pakistan' AND start_year = 2005);

  -- 179. Somalia 2006 - Ethiopian invasion support
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Support for Ethiopian invasion', 'Somalia', 'Special Forces advise Ethiopian invasion. AC-130 strikes, cruise missiles vs Al Shabab.', 2006, NULL,
         5.2 + (random() - 0.5) * 0.6, 46.2 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Somalia' AND start_year = 2006);

  -- 180. Syria 2008 - Special Forces raid
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Special Forces helicopter raid', 'Syria', 'Special Forces helicopter raid near Iraq border kills 8 civilians.', 2008, NULL,
         34.8 + (random() - 0.5) * 0.6, 39.0 + (random() - 0.5) * 0.6, t_encubierta
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Syria' AND start_year = 2008);

  -- 181. Yemen 2009 - Cruise missiles and Saudi backing
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Cruise missile attacks and Saudi backing', 'Yemen', 'Cruise missile attacks on Al Qaeda. Backing Saudi-Yemeni attacks on Houthi rebels.', 2009, 2021,
         15.5 + (random() - 0.5) * 0.6, 48.5 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Yemen' AND start_year = 2009);

  -- 182. Iraq 2014 - Air strikes vs Islamic State
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Air strikes vs Islamic State', 'Iraq', 'Air strikes and Special Forces vs Islamic State. Strikes on pro-Iran militia 2019-20.', 2014, NULL,
         33.2 + (random() - 0.5) * 0.6, 43.7 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Iraq' AND start_year = 2014);

  -- 183. Niger 2017
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Special Forces vs Islamist insurgents', 'Niger', 'Special Forces combat Islamist insurgents, fly drones.', 2017, NULL,
         17.6 + (random() - 0.5) * 0.6, 8.1 + (random() - 0.5) * 0.6, t_encubierta
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Niger' AND start_year = 2017);

  -- 184. Saudi Arabia 2019
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Troop mobilization against Iran', 'Saudi Arabia', 'Troop mobilization against Iran after drone attacks on Saudi oil infrastructure.', 2019, 2020,
         23.9 + (random() - 0.5) * 0.6, 45.1 + (random() - 0.5) * 0.6, t_ocupacion
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Saudi Arabia' AND start_year = 2019);

  -- 185. Yemen 2023
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Attacks on Houthi vessels and sites', 'Yemen', 'US-UK attacks on Houthi vessels and sites after attacks on Red Sea shipping.', 2023, NULL,
         15.5 + (random() - 0.5) * 0.6, 48.5 + (random() - 0.5) * 0.6, t_bombardeo
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Yemen' AND start_year = 2023);

  -- 186. Israel 2024 - Iranian missile defense
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Defense against Iranian missiles/drones', 'Israel', 'US, UK, Jordanian forces shoot down Iranian missiles/drones retaliating for Israeli bombing.', 2024, NULL,
         31.0 + (random() - 0.5) * 0.6, 34.8 + (random() - 0.5) * 0.6, t_naval
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Israel' AND start_year = 2024);

  -- =========================================================================
  -- ERA 9: Additional Harvard DRCLAS interventions (8 interventions)
  -- =========================================================================

  -- 187. Dominican Rep 1914 - Ouster of Bordas (Injerencia)
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Ouster of Gen. Bordas', 'Dominican Rep', 'US secures ouster of Gen. Jose Bordas.', 1914, NULL,
         18.7 + (random() - 0.5) * 0.6, -70.2 + (random() - 0.5) * 0.6, t_injerencia
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Dominican Rep' AND start_year = 1914 AND type_id = t_injerencia);

  -- 188. Dominican Rep 1961 - Trujillo assassination
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Assassination of Trujillo', 'Dominican Rep', 'Assassination of Pres. Trujillo.', 1961, NULL,
         18.7 + (random() - 0.5) * 0.6, -70.2 + (random() - 0.5) * 0.6, t_golpe
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Dominican Rep' AND start_year = 1961);

  -- 189. El Salvador 1980
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Creation of Christian Democrat junta', 'El Salvador', 'US creates and aids new Christian Democrat junta.', 1980, NULL,
         13.8 + (random() - 0.5) * 0.6, -88.9 + (random() - 0.5) * 0.6, t_injerencia
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'El Salvador' AND start_year = 1980);

  -- 190. Guatemala 1982
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Coup against Gen. Lucas Garcia', 'Guatemala', 'US supports coup vs Gen. Lucas Garcia.', 1982, NULL,
         15.8 + (random() - 0.5) * 0.6, -90.2 + (random() - 0.5) * 0.6, t_golpe
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Guatemala' AND start_year = 1982);

  -- 191. Guatemala 1983
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Coup against Gen. Rios Montt', 'Guatemala', 'US supports coup vs Gen. Rios Montt.', 1983, NULL,
         15.8 + (random() - 0.5) * 0.6, -90.2 + (random() - 0.5) * 0.6, t_golpe
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Guatemala' AND start_year = 1983);

  -- 192. Nicaragua 1979
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Pressure on Somoza to leave', 'Nicaragua', 'US pressures Pres. Somoza to leave.', 1979, NULL,
         12.9 + (random() - 0.5) * 0.6, -85.2 + (random() - 0.5) * 0.6, t_injerencia
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Nicaragua' AND start_year = 1979);

  -- 193. Panama 1949
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Coup ousting VP Chanis', 'Panama', 'US supports coup ousting constitutional govt of VP Chanis.', 1949, NULL,
         8.5 + (random() - 0.5) * 0.6, -80.8 + (random() - 0.5) * 0.6, t_golpe
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Panama' AND start_year = 1949);

  -- 194. Panama 1969
  INSERT INTO interventions (title, country_name, description, start_year, end_year, latitude, longitude, type_id)
  SELECT 'Torrijos coup', 'Panama', 'US supports coup by Gen. Torrijos.', 1969, NULL,
         8.5 + (random() - 0.5) * 0.6, -80.8 + (random() - 0.5) * 0.6, t_golpe
  WHERE NOT EXISTS (SELECT 1 FROM interventions WHERE country_name = 'Panama' AND start_year = 1969);

  RAISE NOTICE 'All new interventions inserted successfully.';
END $$;
