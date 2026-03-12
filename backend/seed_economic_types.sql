-- =============================================
-- PASO 1: Añadir 3 nuevos tipos económicos
-- PASO 2: Actualizar colores de WW1/WW2 (de verde a khaki/dorado)
-- =============================================

-- Nuevos tipos de intervención económica
INSERT INTO intervention_types (name, color_code)
VALUES
  ('Embargo', '#00C853'),
  ('Desestabilización', '#00E676'),
  ('Sanciones', '#69F0AE')
ON CONFLICT (name) DO NOTHING;

-- Actualizar colores WW1/WW2 (antes eran verdes, ahora khaki/dorado para dejar verde a los económicos)
UPDATE intervention_types SET color_code = '#8B6914' WHERE name = 'Acciones WW1';
UPDATE intervention_types SET color_code = '#B8860B' WHERE name = 'Acciones WW2';
