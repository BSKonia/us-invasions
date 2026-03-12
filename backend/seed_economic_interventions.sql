-- =============================================
-- INTERVENCIONES ECONÓMICAS DE EE.UU. (1798-2026)
-- Fuentes: OFAC, William Blum, Stephen Kinzer, National Security Archive,
-- CRS Report R42738, metaphorician.com
-- =============================================
-- EJECUTAR DESPUÉS de seed_economic_types.sql
-- Usa DO $$ ... END $$ con WHERE NOT EXISTS para evitar duplicados

DO $$
DECLARE
  v_embargo_id UUID;
  v_desestab_id UUID;
  v_sanciones_id UUID;
BEGIN
  SELECT id INTO v_embargo_id FROM intervention_types WHERE name = 'Embargo';
  SELECT id INTO v_desestab_id FROM intervention_types WHERE name = 'Desestabilización';
  SELECT id INTO v_sanciones_id FROM intervention_types WHERE name = 'Sanciones';

  -- ============================================================
  -- EMBARGOS
  -- ============================================================

  -- Francia - Cuasi-Guerra (1798)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Cuasi-guerra económica con Francia' AND country_name = 'Francia') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Cuasi-guerra económica con Francia', 'Embargo comercial y congelación de relaciones durante la Cuasi-Guerra con Francia, primer conflicto económico internacional de EE.UU. El Congreso autorizó la captura de buques franceses y suspendió el comercio bilateral en respuesta a los ataques franceses contra la marina mercante estadounidense.', 'Francia', 1798, 1800, 48.8566, 2.3522, v_embargo_id);
  END IF;

  -- Gran Bretaña - Ley de Embargo (1807)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Ley de Embargo contra Gran Bretaña' AND country_name = 'Gran Bretaña') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Ley de Embargo contra Gran Bretaña', 'Embargo comercial total contra Gran Bretaña y Francia impuesto por el presidente Jefferson en respuesta al reclutamiento forzado de marineros estadounidenses. El embargo dañó severamente la economía estadounidense y fue derogado en 1809, pero estableció precedentes sobre el uso de la coerción económica como instrumento de política exterior.', 'Gran Bretaña', 1807, 1809, 51.5074, -0.1278, v_embargo_id);
  END IF;

  -- Confederación - Bloqueo Naval (1861)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Bloqueo naval contra la Confederación' AND country_name = 'Estados Confederados') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Bloqueo naval contra la Confederación', 'Bloqueo naval de la Unión contra los puertos confederados durante la Guerra Civil estadounidense. Aunque fue una acción interna, estableció precedentes legales sobre guerra económica y bloqueos comerciales que serían utilizados en intervenciones internacionales posteriores.', 'Estados Confederados', 1861, 1865, 32.7767, -79.9309, v_embargo_id);
  END IF;

  -- Japón - Pre-WWII (1940)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Embargo contra Japón (pre-WWII)' AND country_name = 'Japón') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Embargo contra Japón (pre-WWII)', 'EE.UU. impuso un embargo de petróleo, acero y chatarra contra Japón en respuesta a su expansión militar en Asia y la ocupación de Indochina francesa. El embargo fue un factor determinante en la decisión japonesa de atacar Pearl Harbor en diciembre de 1941.', 'Japón', 1940, 1941, 35.6762, 139.6503, v_embargo_id);
  END IF;

  -- Corea del Norte (1950)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Embargo contra Corea del Norte' AND country_name = 'Corea del Norte') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Embargo contra Corea del Norte', 'Bloqueo económico casi total iniciado durante la Guerra de Corea mediante el Trading with the Enemy Act. Las restricciones se han intensificado progresivamente con múltiples resoluciones del Consejo de Seguridad de la ONU, convirtiendo a Corea del Norte en una de las economías más aisladas del mundo.', 'Corea del Norte', 1950, NULL, 39.0392, 125.7625, v_embargo_id);
  END IF;

  -- Cuba (1962)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Embargo contra Cuba' AND country_name = 'Cuba') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Embargo contra Cuba', 'Embargo económico integral impuesto por EE.UU. que prohíbe prácticamente todo comercio bilateral. Es el embargo más prolongado de la historia moderna, codificado por la Ley Helms-Burton de 1996, y ha causado pérdidas estimadas en más de 150.000 millones de dólares a la economía cubana.', 'Cuba', 1962, NULL, 23.1136, -82.3666, v_embargo_id);
  END IF;

  -- Irán (1979)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Embargo contra Irán' AND country_name = 'Irán') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Embargo contra Irán', 'Restricciones comerciales integrales iniciadas tras la crisis de los rehenes de la embajada estadounidense en Teherán. Ampliadas drásticamente en 2012 con sanciones al sector petrolero y al banco central, y reforzadas en 2018 tras la retirada de EE.UU. del acuerdo nuclear JCPOA.', 'Irán', 1979, NULL, 35.6892, 51.3890, v_embargo_id);
  END IF;

  -- Libia - Gadafi (1986)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Embargo contra Libia (Gadafi)' AND country_name = 'Libia') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Embargo contra Libia (Gadafi)', 'Sanciones comerciales integrales impuestas tras los atentados terroristas de Lockerbie y la discoteca La Belle en Berlín. Incluían congelación de activos y prohibición de importación de petróleo libio; fueron levantadas progresivamente a partir de 2004 tras el acuerdo de desnuclearización de Gadafi.', 'Libia', 1986, 2004, 32.9022, 13.1800, v_embargo_id);
  END IF;

  -- Irak (1990)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Embargo contra Irak' AND country_name = 'Irak') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Embargo contra Irak', 'Embargo integral impuesto tras la invasión iraquí de Kuwait, respaldado por la Resolución 661 del Consejo de Seguridad de la ONU. UNICEF estimó que contribuyó a la muerte de cientos de miles de niños por desnutrición y falta de medicinas; el programa Petróleo por Alimentos fue una respuesta parcial a la crisis humanitaria.', 'Irak', 1990, 2003, 33.3152, 44.3661, v_embargo_id);
  END IF;

  -- Myanmar (1997)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Embargo contra Myanmar' AND country_name = 'Myanmar') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Embargo contra Myanmar', 'Restricciones comerciales integrales impuestas tras la represión militar contra el movimiento prodemocrático. Levantadas parcialmente entre 2012-2016 durante la apertura democrática, fueron reimplantadas con fuerza tras el golpe de Estado militar de febrero de 2021.', 'Myanmar', 1997, NULL, 19.7633, 96.0785, v_embargo_id);
  END IF;

  -- Sudán (1997)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Embargo contra Sudán' AND country_name = 'Sudán') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Embargo contra Sudán', 'Embargo económico integral impuesto por acusaciones de apoyo al terrorismo internacional, incluyendo la presencia de Osama bin Laden en los años 90. Las sanciones más amplias fueron levantadas en 2017, pero se reimplantaron restricciones parciales tras el conflicto interno de 2023.', 'Sudán', 1997, 2017, 15.5007, 32.5599, v_embargo_id);
  END IF;

  -- Siria (2011)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Embargo contra Siria' AND country_name = 'Siria') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Embargo contra Siria', 'Sanciones ampliadas a un bloqueo económico casi total mediante la Ley César de 2020, que penaliza a terceros países que comercien con el gobierno sirio. Las restricciones abarcan el sector energético, financiero y militar, agravando significativamente la crisis humanitaria del conflicto civil.', 'Siria', 2011, NULL, 33.5138, 36.2765, v_embargo_id);
  END IF;

  -- Libia 2011
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Embargo contra Libia (2011)' AND country_name = 'Libia') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Embargo contra Libia (2011)', 'Nuevas sanciones integrales impuestas durante la guerra civil libia, incluyendo congelación de activos del régimen de Gadafi y embargo de armas. Las restricciones contribuyeron al colapso económico del gobierno y persisten parcialmente debido a la fragmentación política del país.', 'Libia', 2011, NULL, 32.9022, 13.1800, v_embargo_id);
  END IF;

  -- Venezuela (2017)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Embargo contra Venezuela' AND country_name = 'Venezuela') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Embargo contra Venezuela', 'Embargo de facto que comenzó con sanciones sectoriales en 2015 y se expandió a un bloqueo casi total del sector petrolero y financiero mediante órdenes ejecutivas en 2017-2019. Ha causado una drástica caída en los ingresos petroleros del país, agravando la crisis económica y humanitaria venezolana.', 'Venezuela', 2017, NULL, 10.4806, -66.9036, v_embargo_id);
  END IF;

  -- ============================================================
  -- DESESTABILIZACIÓN ECONÓMICA
  -- ============================================================

  -- Irán - Mosaddeq (1951)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Desestabilización económica de Irán (Mosaddeq)' AND country_name = 'Irán') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Desestabilización económica de Irán (Mosaddeq)', 'Tras la nacionalización del petróleo iraní por el primer ministro Mosaddeq, Gran Bretaña impuso un boicot petrolero con apoyo estadounidense. La CIA ejecutó la Operación Ajax, combinando guerra económica con operaciones encubiertas para restaurar al Sha en el poder en 1953.', 'Irán', 1951, 1953, 35.6892, 51.3890, v_desestab_id);
  END IF;

  -- Guatemala (1952)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Desestabilización económica de Guatemala' AND country_name = 'Guatemala') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Desestabilización económica de Guatemala', 'La CIA, en alianza con la United Fruit Company, orquestó una campaña de presión económica y guerra psicológica contra el gobierno de Jacobo Árbenz. La reforma agraria que afectaba tierras de la compañía fue el detonante del golpe de 1954 que instaló una dictadura militar.', 'Guatemala', 1952, 1954, 14.6349, -90.5069, v_desestab_id);
  END IF;

  -- Guyana Británica (1953)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Desestabilización económica de Guyana Británica' AND country_name = 'Guyana') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Desestabilización económica de Guyana Británica', 'La CIA financió huelgas generales y disturbios raciales para derrocar al gobierno de Cheddi Jagan en la entonces Guyana Británica. La desestabilización económica y social forzó un cambio en el sistema electoral que aseguró la derrota de Jagan antes de la independencia.', 'Guyana', 1953, 1964, 6.8013, -58.1551, v_desestab_id);
  END IF;

  -- Indonesia (1957)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Desestabilización económica de Indonesia' AND country_name = 'Indonesia') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Desestabilización económica de Indonesia', 'La CIA canalizó fondos a militares y grupos opositores al presidente Sukarno, cuyas políticas nacionalistas amenazaban intereses económicos occidentales. La desestabilización contribuyó al golpe de 1965 y la masacre de entre 500.000 y un millón de personas bajo el régimen de Suharto.', 'Indonesia', 1957, 1965, -6.2088, 106.8456, v_desestab_id);
  END IF;

  -- Cuba pre-embargo (1960)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Desestabilización económica de Cuba (pre-embargo)' AND country_name = 'Cuba') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Desestabilización económica de Cuba (pre-embargo)', 'Antes del embargo formal, EE.UU. redujo la cuota azucarera cubana y ejecutó operaciones de sabotaje económico como parte de la Operación Mangosta. Se buscaba crear descontento popular para facilitar el derrocamiento del gobierno de Fidel Castro, complementando la fallida invasión de Bahía de Cochinos.', 'Cuba', 1960, 1962, 23.1136, -82.3666, v_desestab_id);
  END IF;

  -- Congo (1960)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Desestabilización económica del Congo' AND country_name = 'Congo') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Desestabilización económica del Congo', 'EE.UU. y Bélgica conspiraron para desestabilizar al gobierno de Patrice Lumumba, cuya nacionalización de recursos mineros amenazaba intereses occidentales. La CIA participó en el asesinato de Lumumba e instaló a Mobutu, quien permitió la explotación económica extranjera durante tres décadas.', 'Congo', 1960, 1965, -4.4419, 15.2663, v_desestab_id);
  END IF;

  -- República Dominicana (1960)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Desestabilización económica de República Dominicana' AND country_name = 'República Dominicana') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Desestabilización económica de República Dominicana', 'EE.UU. impuso sanciones económicas contra el régimen de Trujillo cuando este dejó de ser un aliado conveniente, y luego intervino económica y militarmente tras la revolución constitucionalista de 1965. La intervención buscaba evitar "otra Cuba" en el Caribe.', 'República Dominicana', 1960, 1966, 18.4861, -69.9312, v_desestab_id);
  END IF;

  -- Ecuador (1960)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Desestabilización económica de Ecuador' AND country_name = 'Ecuador') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Desestabilización económica de Ecuador', 'La CIA intervino para debilitar al gobierno de José María Velasco Ibarra y luego apoyó gobiernos militares alineados con intereses estadounidenses. Las presiones económicas incluyeron condicionamiento de ayuda y manipulación de préstamos internacionales para asegurar políticas favorables a empresas estadounidenses.', 'Ecuador', 1960, 1963, -0.1807, -78.4678, v_desestab_id);
  END IF;

  -- Ghana (1960)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Desestabilización económica de Ghana' AND country_name = 'Ghana') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Desestabilización económica de Ghana', 'EE.UU. condicionó ayuda económica y presionó al FMI contra el gobierno de Kwame Nkrumah por sus políticas panafricanistas y socialistas. La caída del precio del cacao y las presiones financieras contribuyeron al golpe militar de 1966 mientras Nkrumah visitaba China.', 'Ghana', 1960, 1966, 5.6037, -0.1870, v_desestab_id);
  END IF;

  -- Laos (1960)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Desestabilización económica de Laos' AND country_name = 'Laos') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Desestabilización económica de Laos', 'Operaciones encubiertas de la CIA que incluyeron la financiación de un ejército secreto Hmong y la manipulación del comercio de opio. La guerra secreta devastó la economía laosiana y desplazó a cientos de miles de personas durante más de una década.', 'Laos', 1960, 1975, 17.9757, 102.6331, v_desestab_id);
  END IF;

  -- Brasil (1961)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Desestabilización económica de Brasil' AND country_name = 'Brasil') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Desestabilización económica de Brasil', 'EE.UU. cortó la ayuda económica y presionó a instituciones financieras contra el gobierno de João Goulart, cuyas reformas eran consideradas amenazas comunistas. La Operación Brother Sam preparó apoyo militar mientras la desestabilización económica facilitó el golpe militar de 1964.', 'Brasil', 1961, 1964, -15.7975, -47.8919, v_desestab_id);
  END IF;

  -- Chile (1970)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Desestabilización económica de Chile' AND country_name = 'Chile') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Desestabilización económica de Chile', 'La administración Nixon ordenó "hacer chillar la economía" para derrocar al gobierno de Salvador Allende. La CIA financió huelgas de camioneros, bloqueó créditos internacionales y manipuló el mercado del cobre, contribuyendo al golpe de Estado de Pinochet en septiembre de 1973.', 'Chile', 1970, 1973, -33.4489, -70.6693, v_desestab_id);
  END IF;

  -- Angola (1975)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Desestabilización económica de Angola' AND country_name = 'Angola') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Desestabilización económica de Angola', 'EE.UU. financió al movimiento rebelde UNITA de Jonas Savimbi durante la guerra civil angoleña como parte de la estrategia de la Guerra Fría contra el gobierno del MPLA apoyado por la Unión Soviética y Cuba. La guerra prolongada devastó la infraestructura económica del país durante décadas.', 'Angola', 1975, 1993, -8.8390, 13.2894, v_desestab_id);
  END IF;

  -- Jamaica (1976)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Desestabilización económica de Jamaica' AND country_name = 'Jamaica') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Desestabilización económica de Jamaica', 'Durante el gobierno socialista democrático de Michael Manley, EE.UU. presionó al FMI para imponer condiciones draconianas y la CIA fomentó desestabilización. La fuga de capitales y la violencia política orquestada contribuyeron a la derrota electoral de Manley en 1980.', 'Jamaica', 1976, 1980, 18.1096, -77.2975, v_desestab_id);
  END IF;

  -- Mozambique (1977)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Desestabilización económica de Mozambique' AND country_name = 'Mozambique') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Desestabilización económica de Mozambique', 'EE.UU. apoyó indirectamente a la guerrilla RENAMO, que destruyó infraestructura económica del gobierno del FRELIMO durante la guerra civil. Junto con Sudáfrica, la desestabilización convirtió a Mozambique en uno de los países más pobres del mundo.', 'Mozambique', 1977, 1992, -25.9692, 32.5732, v_desestab_id);
  END IF;

  -- Afganistán (1979)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Desestabilización económica de Afganistán' AND country_name = 'Afganistán') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Desestabilización económica de Afganistán', 'A través de la Operación Ciclón, EE.UU. canalizó miles de millones de dólares a los muyahidines para desestabilizar al gobierno prosoviético y agotar económicamente a la URSS. El programa encubierto más costoso de la CIA transformó la economía afgana hacia la dependencia de la guerra y el opio.', 'Afganistán', 1979, 1989, 34.5553, 69.2075, v_desestab_id);
  END IF;

  -- Nicaragua (1981)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Desestabilización económica de Nicaragua' AND country_name = 'Nicaragua') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Desestabilización económica de Nicaragua', 'EE.UU. financió a la guerrilla Contra, minó puertos nicaragüenses y bloqueó préstamos de organismos internacionales contra el gobierno sandinista. La guerra económica combinada con el conflicto armado devastó la economía, contribuyendo a la derrota electoral sandinista en 1990.', 'Nicaragua', 1981, 1990, 12.1150, -86.2362, v_desestab_id);
  END IF;

  -- Haití - Aristide (2000)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Desestabilización económica de Haití (Aristide)' AND country_name = 'Haití') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Desestabilización económica de Haití (Aristide)', 'EE.UU. financió a la oposición y bloqueó préstamos internacionales al gobierno democráticamente electo de Jean-Bertrand Aristide. La asfixia económica y el apoyo a paramilitares culminaron en el derrocamiento y exilio forzado de Aristide en 2004.', 'Haití', 2000, 2004, 18.5944, -72.3074, v_desestab_id);
  END IF;

  -- Venezuela - Chávez/Maduro (2002)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Desestabilización económica de Venezuela' AND country_name = 'Venezuela') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Desestabilización económica de Venezuela', 'Financiamiento de organizaciones opositoras a través de USAID y la NED, apoyo al golpe de 2002, y presión económica sostenida contra los gobiernos de Chávez y Maduro. Las operaciones precedieron y complementaron las sanciones formales posteriores.', 'Venezuela', 2002, NULL, 10.4806, -66.9036, v_desestab_id);
  END IF;

  -- Bolivia (2006)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Desestabilización económica de Bolivia' AND country_name = 'Bolivia') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Desestabilización económica de Bolivia', 'EE.UU. condicionó la ayuda económica y presionó a organismos internacionales contra el gobierno de Evo Morales tras la nacionalización de hidrocarburos. La expulsión del embajador estadounidense en 2008 y las tensiones sobre la política antidrogas marcaron un periodo de presión económica sostenida.', 'Bolivia', 2006, 2019, -16.4897, -68.1193, v_desestab_id);
  END IF;

  -- ============================================================
  -- SANCIONES
  -- ============================================================

  -- Camboya (1975)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Camboya' AND country_name = 'Camboya') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Camboya', 'Embargo comercial impuesto durante el régimen genocida de los Jemeres Rojos y mantenido durante la ocupación vietnamita. Las sanciones se levantaron gradualmente tras los Acuerdos de Paz de París de 1991 que establecieron un proceso de transición supervisado por la ONU.', 'Camboya', 1975, 1992, 11.5564, 104.9282, v_sanciones_id);
  END IF;

  -- Uganda - Idi Amin (1978)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Uganda (Idi Amin)' AND country_name = 'Uganda') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Uganda (Idi Amin)', 'Embargo comercial contra el régimen de Idi Amin tras atrocidades masivas contra la población civil ugandesa. La Trade Embargo Act de 1978 prohibió las importaciones de café ugandés, principal fuente de divisas del régimen.', 'Uganda', 1978, 1979, 0.3476, 32.5825, v_sanciones_id);
  END IF;

  -- Sudáfrica - Apartheid (1986)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Sudáfrica (Apartheid)' AND country_name = 'Sudáfrica') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Sudáfrica (Apartheid)', 'La Ley Integral contra el Apartheid de 1986 prohibió nuevas inversiones, préstamos bancarios e importaciones clave de Sudáfrica. Las sanciones, aprobadas por el Congreso anulando el veto de Reagan, contribuyeron significativamente al fin del régimen del apartheid y la liberación de Nelson Mandela.', 'Sudáfrica', 1986, 1991, -25.7479, 28.2293, v_sanciones_id);
  END IF;

  -- Panamá (1988)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Panamá' AND country_name = 'Panamá') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Panamá', 'Sanciones económicas y congelación de activos panameños en bancos estadounidenses para presionar al general Noriega. Las restricciones devastaron el sector bancario panameño y precedieron la invasión militar de diciembre de 1989 (Operación Causa Justa).', 'Panamá', 1988, 1990, 8.9824, -79.5199, v_sanciones_id);
  END IF;

  -- China - Tiananmén (1989)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra China (Tiananmén)' AND country_name = 'China') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra China (Tiananmén)', 'Embargo de armas y sanciones impuestas tras la masacre de la Plaza de Tiananmén en junio de 1989. El embargo de armas permanece vigente y constituyó una de las primeras respuestas occidentales coordinadas contra China por violaciones de derechos humanos.', 'China', 1989, NULL, 39.9042, 116.4074, v_sanciones_id);
  END IF;

  -- Myanmar temprano (1990)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Myanmar (1990)' AND country_name = 'Myanmar') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Myanmar (1990)', 'Primeras sanciones impuestas tras la anulación de las elecciones de 1990 ganadas por la Liga Nacional para la Democracia de Aung San Suu Kyi. Incluyeron prohibición de nuevas inversiones estadounidenses y restricciones de visado a la junta militar SLORC.', 'Myanmar', 1990, 1997, 19.7633, 96.0785, v_sanciones_id);
  END IF;

  -- Haití (1991)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Haití' AND country_name = 'Haití') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Haití', 'Sanciones económicas y embargo comercial impuestos tras el golpe militar que derrocó al presidente Aristide en 1991. Las restricciones buscaban forzar la restauración del gobierno democrático, objetivo logrado con la intervención militar de 1994.', 'Haití', 1991, 1994, 18.5944, -72.3074, v_sanciones_id);
  END IF;

  -- Yugoslavia (1992)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Yugoslavia' AND country_name = 'Yugoslavia') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Yugoslavia', 'Sanciones económicas integrales impuestas durante las guerras yugoslavas, incluyendo embargo comercial y congelación de activos. Contribuyeron al deterioro económico de Serbia y presionaron hacia los acuerdos de Dayton que pusieron fin a la guerra de Bosnia.', 'Yugoslavia', 1992, 1996, 44.7866, 20.4489, v_sanciones_id);
  END IF;

  -- Perú (1992)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Perú' AND country_name = 'Perú') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Perú', 'Suspensión parcial de ayuda militar y económica durante el autogolpe de Fujimori en 1992. Las presiones económicas y diplomáticas forzaron al gobierno a convocar elecciones para una Asamblea Constituyente como condición para restaurar la cooperación.', 'Perú', 1992, 1993, -12.0464, -77.0428, v_sanciones_id);
  END IF;

  -- Colombia (1996)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Colombia (Descertificación)' AND country_name = 'Colombia') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Colombia (Descertificación)', 'EE.UU. descertificó a Colombia en la lucha antinarcóticos durante el gobierno de Ernesto Samper, cortando ayuda económica y presionando comercialmente. La presión económica buscaba forzar una mayor cooperación en la guerra contra las drogas y debilitar al gobierno señalado de recibir fondos del Cartel de Cali.', 'Colombia', 1996, 1998, 4.7110, -74.0721, v_sanciones_id);
  END IF;

  -- Serbia - Kosovo (1998)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Serbia (Kosovo)' AND country_name = 'Serbia') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Serbia (Kosovo)', 'Nuevas sanciones impuestas durante la crisis de Kosovo por la campaña de limpieza étnica del régimen de Milošević. Combinadas con la campaña de bombardeos de la OTAN, contribuyeron a la retirada serbia de Kosovo y eventualmente a la caída del régimen.', 'Serbia', 1998, 2001, 44.7866, 20.4489, v_sanciones_id);
  END IF;

  -- India/Pakistán nucleares (1998)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra India (nucleares)' AND country_name = 'India') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra India (nucleares)', 'Sanciones impuestas tras las pruebas nucleares de Pokhran-II en mayo de 1998, incluyendo restricciones a préstamos bancarios y exportaciones tecnológicas. Las sanciones fueron levantadas gradualmente como parte del acercamiento estratégico bilateral formalizado con el acuerdo nuclear civil de 2005.', 'India', 1998, 2001, 28.6139, 77.2090, v_sanciones_id);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Pakistán (nucleares)' AND country_name = 'Pakistán') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Pakistán (nucleares)', 'Sanciones nucleares impuestas tras las pruebas atómicas de 1998 bajo la Enmienda Pressler y la Enmienda Glenn. Las restricciones fueron parcialmente levantadas tras el 11 de septiembre de 2001 a cambio de la cooperación de Pakistán en la guerra contra el terrorismo.', 'Pakistán', 1998, 2001, 33.6844, 73.0479, v_sanciones_id);
  END IF;

  -- Zimbabue (2003)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Zimbabue' AND country_name = 'Zimbabue') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Zimbabue', 'Sanciones dirigidas impuestas por violaciones de derechos humanos y erosión democrática bajo el gobierno de Robert Mugabe. Las restricciones incluyen prohibiciones de viaje y congelación de activos de funcionarios del gobierno y del partido ZANU-PF.', 'Zimbabue', 2003, NULL, -17.8292, 31.0522, v_sanciones_id);
  END IF;

  -- Irak post-invasión (2003)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Irak (post-invasión)' AND country_name = 'Irak') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Irak (post-invasión)', 'Sanciones remanentes y control de activos iraquíes tras la invasión de 2003, incluyendo restricciones al antiguo régimen baazista. EE.UU. mantuvo el control del Fondo de Desarrollo de Irak y condicionó la reconstrucción económica a reformas políticas y de mercado.', 'Irak', 2003, 2010, 33.3152, 44.3661, v_sanciones_id);
  END IF;

  -- Bielorrusia (2006)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Bielorrusia' AND country_name = 'Bielorrusia') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Bielorrusia', 'Sanciones ampliadas drásticamente tras las elecciones fraudulentas de 2020 y la brutal represión del movimiento prodemocrático. Reforzadas en 2022 por el papel de Bielorrusia como plataforma para la invasión rusa de Ucrania, incluyen restricciones financieras y comerciales.', 'Bielorrusia', 2006, NULL, 53.9045, 27.5615, v_sanciones_id);
  END IF;

  -- RDC (2006)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra la RD del Congo' AND country_name = 'República Democrática del Congo') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra la RD del Congo', 'Sanciones dirigidas contra líderes de grupos armados y funcionarios involucrados en el conflicto del este del Congo. Las medidas buscan cortar el financiamiento de la violencia vinculada a la explotación ilegal de minerales como el coltán y los diamantes.', 'República Democrática del Congo', 2006, NULL, -4.4419, 15.2663, v_sanciones_id);
  END IF;

  -- Eritrea (2009)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Eritrea' AND country_name = 'Eritrea') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Eritrea', 'Sanciones impuestas por el apoyo de Eritrea a grupos armados en la región del Cuerno de África y violaciones de derechos humanos. Incluyen embargo de armas y restricciones a funcionarios del gobierno de Isaias Afwerki.', 'Eritrea', 2009, NULL, 15.3229, 38.9251, v_sanciones_id);
  END IF;

  -- Somalia (2010)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Somalia' AND country_name = 'Somalia') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Somalia', 'Sanciones dirigidas contra el grupo Al-Shabaab y señores de la guerra que obstaculizan la paz en Somalia. Incluyen congelación de activos, embargo de armas y restricciones de viaje a individuos y entidades designados.', 'Somalia', 2010, NULL, 2.0469, 45.3182, v_sanciones_id);
  END IF;

  -- Mali (2012)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Mali' AND country_name = 'Mali') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Mali', 'Sanciones impuestas tras sucesivos golpes militares y la creciente influencia de grupos armados vinculados a Al Qaeda. Las restricciones se intensificaron tras el golpe de 2020 y la contratación del grupo paramilitar ruso Wagner por la junta militar.', 'Mali', 2012, NULL, 12.6392, -8.0029, v_sanciones_id);
  END IF;

  -- Rusia (2014)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Rusia' AND country_name = 'Rusia') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Rusia', 'Sanciones sectoriales impuestas tras la anexión de Crimea en 2014, masivamente expandidas en 2022 tras la invasión de Ucrania. Incluyen congelación de reservas del banco central, exclusión del sistema SWIFT, restricciones tecnológicas y sanciones a oligarcas, constituyendo el paquete más extenso contra una gran potencia.', 'Rusia', 2014, NULL, 55.7558, 37.6173, v_sanciones_id);
  END IF;

  -- República Centroafricana (2014)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra República Centroafricana' AND country_name = 'República Centroafricana') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra República Centroafricana', 'Sanciones impuestas tras el golpe de la coalición Séléka en 2013 y la posterior violencia sectaria. Las restricciones incluyen embargo de armas y sanciones individuales a líderes de grupos armados que perpetúan el conflicto.', 'República Centroafricana', 2014, NULL, 4.3947, 18.5582, v_sanciones_id);
  END IF;

  -- Yemen (2014)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Yemen (Hutíes)' AND country_name = 'Yemen') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Yemen (Hutíes)', 'Sanciones dirigidas contra los líderes hutíes y entidades vinculadas a la desestabilización de Yemen. Las restricciones incluyen congelación de activos y prohibiciones de viaje, intensificadas tras los ataques hutíes contra el tráfico marítimo en el Mar Rojo.', 'Yemen', 2014, NULL, 15.3694, 44.1910, v_sanciones_id);
  END IF;

  -- Sudán del Sur (2014)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Sudán del Sur' AND country_name = 'Sudán del Sur') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Sudán del Sur', 'Sanciones impuestas tras el estallido de la guerra civil en 2013 entre facciones del gobierno. Incluyen embargo de armas y sanciones individuales a comandantes militares responsables de atrocidades contra civiles.', 'Sudán del Sur', 2014, NULL, 4.8594, 31.5713, v_sanciones_id);
  END IF;

  -- Líbano/Hezbolá (2015)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Líbano (Hezbolá)' AND country_name = 'Líbano') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Líbano (Hezbolá)', 'Sanciones financieras dirigidas contra Hezbolá y entidades libanesas vinculadas al grupo, bajo la Ley de Prevención del Financiamiento Internacional de Hezbolá. Las medidas han restringido el acceso del sistema bancario libanés al sistema financiero estadounidense, afectando la economía del país.', 'Líbano', 2015, NULL, 33.8938, 35.5018, v_sanciones_id);
  END IF;

  -- China moderna (2018)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra China (Guerra Comercial)' AND country_name = 'China') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra China (Guerra Comercial)', 'Restricciones comerciales y tecnológicas significativamente ampliadas desde 2018 en el marco de la guerra comercial. Incluyen aranceles masivos, restricciones a Huawei y empresas tecnológicas, y sanciones por la situación en Xinjiang y Hong Kong.', 'China', 2018, NULL, 39.9042, 116.4074, v_sanciones_id);
  END IF;

  -- Nicaragua - Ortega (2018)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Nicaragua (Ortega)' AND country_name = 'Nicaragua') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Nicaragua (Ortega)', 'Sanciones selectivas contra funcionarios del gobierno de Daniel Ortega por represión de protestas ciudadanas y erosión democrática. Ampliadas mediante la Ley RENACER de 2021, incluyen restricciones financieras y presión sobre préstamos de organismos multilaterales.', 'Nicaragua', 2018, NULL, 12.1150, -86.2362, v_sanciones_id);
  END IF;

  -- México (2018)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Presión económica contra México' AND country_name = 'México') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Presión económica contra México', 'Amenazas arancelarias y presión económica contra México vinculadas a disputas migratorias, comerciales y de seguridad fronteriza. Incluyen la imposición de aranceles bajo la Sección 232 durante la renegociación del TLCAN y amenazas recurrentes de cierre fronterizo.', 'México', 2018, NULL, 19.4326, -99.1332, v_sanciones_id);
  END IF;

  -- Turquía (2019)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Turquía' AND country_name = 'Turquía') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Turquía', 'Sanciones selectivas impuestas por la compra del sistema de defensa antiaéreo ruso S-400 y la ofensiva militar en el norte de Siria. Incluyen exclusión del programa del caza F-35 y sanciones bajo CAATSA contra la industria de defensa turca.', 'Turquía', 2019, NULL, 39.9334, 32.8597, v_sanciones_id);
  END IF;

  -- Etiopía (2021)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Etiopía' AND country_name = 'Etiopía') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Etiopía', 'Sanciones selectivas impuestas durante el conflicto del Tigray, incluyendo restricciones a la ayuda económica y militar. Las medidas buscaban presionar al gobierno etíope para permitir acceso humanitario y cesar hostilidades contra la población civil de la región.', 'Etiopía', 2021, NULL, 9.0250, 38.7469, v_sanciones_id);
  END IF;

  -- Afganistán - Talibán (2021)
  IF NOT EXISTS (SELECT 1 FROM interventions WHERE title = 'Sanciones contra Afganistán (Talibán)' AND country_name = 'Afganistán') THEN
    INSERT INTO interventions (title, description, country_name, start_year, end_year, latitude, longitude, type_id)
    VALUES ('Sanciones contra Afganistán (Talibán)', 'Congelación de miles de millones de dólares en reservas del banco central afgano tras la toma del poder por los talibanes. Las sanciones han paralizado el sistema bancario y agravado la crisis humanitaria, con millones de afganos enfrentando inseguridad alimentaria severa.', 'Afganistán', 2021, NULL, 34.5553, 69.2075, v_sanciones_id);
  END IF;

  RAISE NOTICE 'Intervenciones económicas insertadas correctamente.';
END $$;
