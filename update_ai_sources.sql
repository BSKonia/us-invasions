-- ==========================================
-- SCRIPT SQL PARA AÑADIR CACHÉ DE FUENTES IA
-- Ejecutar en el SQL Editor de Supabase
-- ==========================================

-- Añadir columna para guardar el array JSON de las fuentes generadas por IA
ALTER TABLE public.interventions 
ADD COLUMN IF NOT EXISTS ai_sources JSONB;
