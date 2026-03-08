INSERT INTO intervention_types (name, color_code) VALUES
('Golpe de Estado', '#ff0000'),
('Bombardeo', '#ff5500'),
('Ocupación Militar', '#ff0055'),
('Injerencia Política', '#ffaa00')
ON CONFLICT DO NOTHING;

-- You can run this directly in Supabase SQL editor to bypass RLS
