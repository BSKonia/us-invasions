-- 1. Crear tabla de perfiles públicos
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    username VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Activar RLS
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public profiles are viewable by everyone." ON public.profiles FOR SELECT USING (true);
CREATE POLICY "Users can insert their own profile." ON public.profiles FOR INSERT WITH CHECK (auth.uid() = id);
CREATE POLICY "Users can update own profile." ON public.profiles FOR UPDATE USING (auth.uid() = id);

-- 3. Crear un trigger para insertar automáticamente el perfil en el signup (opcional pero recomendado)
-- O podemos simplemente hacerlo desde el Frontend. Lo haremos desde el frontend por simplicidad.

-- 4. Modificar las tablas sociales para hacer JOIN fácilmente con el username
-- Si es muy complejo cambiar las foreign keys existentes (debido a datos),
-- podemos simplemente crear una vista (view) que una la información para el frontend.
CREATE OR REPLACE VIEW public.comments_with_users AS
SELECT c.*, p.username 
FROM public.intervention_comments c
LEFT JOIN public.profiles p ON c.user_id = p.id;

