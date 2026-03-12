-- ============================================================
-- MILITARY BASES: Table schema
-- Run this FIRST, then the seed files
-- ============================================================

-- Create the military_bases table
CREATE TABLE IF NOT EXISTS military_bases (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country_name VARCHAR(100) NOT NULL,
    description TEXT,
    latitude NUMERIC(10, 6) NOT NULL,
    longitude NUMERIC(10, 6) NOT NULL,
    category VARCHAR(50) NOT NULL DEFAULT 'Small',  -- Major, Medium, Small, Lily-pad, Access Agreement
    branch VARCHAR(100),  -- Army, Navy, Air Force, Marines, Joint, etc.
    status VARCHAR(20) NOT NULL DEFAULT 'Active',  -- Active, Closed, Reduced
    year_established INTEGER,
    year_closed INTEGER,
    ai_summary TEXT,
    ai_sources JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add unique constraint to avoid duplicates
ALTER TABLE military_bases ADD CONSTRAINT military_bases_name_country_unique UNIQUE (name, country_name);

-- Enable Row Level Security
ALTER TABLE military_bases ENABLE ROW LEVEL SECURITY;

-- Allow public read access
CREATE POLICY "Allow public read access on military_bases"
    ON military_bases FOR SELECT
    USING (true);

-- Create comments table for bases
CREATE TABLE IF NOT EXISTS base_comments (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    base_id UUID REFERENCES military_bases(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE base_comments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read access on base_comments"
    ON base_comments FOR SELECT USING (true);

CREATE POLICY "Allow authenticated insert on base_comments"
    ON base_comments FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- Create votes table for bases
CREATE TABLE IF NOT EXISTS base_votes (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    base_id UUID REFERENCES military_bases(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    category VARCHAR(50) NOT NULL,
    score INTEGER NOT NULL CHECK (score >= 1 AND score <= 5),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(base_id, user_id, category)
);

ALTER TABLE base_votes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read access on base_votes"
    ON base_votes FOR SELECT USING (true);

CREATE POLICY "Allow authenticated insert on base_votes"
    ON base_votes FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- Create view for base comments with usernames
-- Ensure profiles table exists (safe: IF NOT EXISTS won't duplicate)
CREATE TABLE IF NOT EXISTS profiles (
    id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE OR REPLACE VIEW base_comments_with_users AS
SELECT 
    bc.id,
    bc.base_id,
    bc.user_id,
    bc.content,
    bc.created_at,
    p.username
FROM base_comments bc
LEFT JOIN profiles p ON bc.user_id = p.id
ORDER BY bc.created_at DESC;
