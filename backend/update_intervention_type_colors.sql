-- Update intervention_types color_code to match new unified palette
-- Militar (reds family)
UPDATE intervention_types SET color_code = '#CC2200' WHERE name = 'Bombardeo';
UPDATE intervention_types SET color_code = '#E63600' WHERE name = 'Ocupación Militar';
UPDATE intervention_types SET color_code = '#FF4D2A' WHERE name = 'Operación Naval';
UPDATE intervention_types SET color_code = '#D9004C' WHERE name = 'Operación Encubierta';
UPDATE intervention_types SET color_code = '#B33A3A' WHERE name = 'Acciones WW1';
UPDATE intervention_types SET color_code = '#FF6666' WHERE name = 'Acciones WW2';

-- Político (amber/orange family)
UPDATE intervention_types SET color_code = '#E67700' WHERE name = 'Golpe de Estado';
UPDATE intervention_types SET color_code = '#FFA033' WHERE name = 'Injerencia Política';

-- Económico (no changes, but ensuring consistency)
UPDATE intervention_types SET color_code = '#00C853' WHERE name = 'Embargo';
UPDATE intervention_types SET color_code = '#00E676' WHERE name = 'Desestabilización';
UPDATE intervention_types SET color_code = '#69F0AE' WHERE name = 'Sanciones';
