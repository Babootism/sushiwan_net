-- ==========================================
-- SCRIPT D'INITIALISATION SUSHIWAN DATABASE
-- ==========================================
-- Ce script s'exécute automatiquement au premier démarrage de PostgreSQL
-- Il prépare la base de données avec les extensions et configurations nécessaires

-- Connexion à la base principale
\c sushiwan_db;

-- ==========================================
-- INSTALLATION DES EXTENSIONS POSTGRESQL
-- ==========================================

-- Extension UUID pour générer des identifiants uniques
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
-- Usage : uuid_generate_v4() pour créer des UUIDs

-- Extension pour les fonctions de texte avancées
CREATE EXTENSION IF NOT EXISTS "unaccent";
-- Usage : recherche insensible aux accents (café = cafe)

-- Extension pour la recherche full-text multilingue
CREATE EXTENSION IF NOT EXISTS "pg_trgm";
-- Usage : recherche floue et suggestion de produits

-- ==========================================
-- CONFIGURATION DES PARAMÈTRES
-- ==========================================

-- Définir le fuseau horaire par défaut (Tunisie)
SET timezone = 'Africa/Tunis';

-- Configuration pour le support multilingue optimal
SET client_encoding = 'UTF8';

-- ==========================================
-- FONCTIONS UTILITAIRES PERSONNALISÉES
-- ==========================================

-- Fonction pour nettoyer et normaliser les chaînes de recherche
CREATE OR REPLACE FUNCTION normalize_search_text(input_text TEXT)
RETURNS TEXT AS $$
BEGIN
    -- Convertir en minuscules, supprimer accents et caractères spéciaux
    RETURN lower(unaccent(trim(input_text)));
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- Fonction pour générer des slugs (URLs amicales)
CREATE OR REPLACE FUNCTION generate_slug(input_text TEXT)
RETURNS TEXT AS $$
BEGIN
    -- Convertir en slug : "Sushi Délicieux" -> "sushi-delicieux"
    RETURN lower(
        regexp_replace(
            unaccent(trim(input_text)), 
            '[^a-zA-Z0-9]+', 
            '-', 
            'g'
        )
    );
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- Fonction pour calculer la distance de recherche
CREATE OR REPLACE FUNCTION search_similarity(text1 TEXT, text2 TEXT)
RETURNS FLOAT AS $$
BEGIN
    -- Utilise l'extension pg_trgm pour calculer la similarité
    RETURN similarity(normalize_search_text(text1), normalize_search_text(text2));
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- ==========================================
-- TRIGGERS POUR AUDIT ET LOGGING
-- ==========================================

-- Fonction générique pour audit des modifications
CREATE OR REPLACE FUNCTION audit_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
    -- Pour les UPDATE, log les anciennes et nouvelles valeurs
    IF TG_OP = 'UPDATE' THEN
        INSERT INTO audit_log (
            table_name,
            operation,
            old_values,
            new_values,
            user_id,
            timestamp
        ) VALUES (
            TG_TABLE_NAME,
            TG_OP,
            row_to_json(OLD),
            row_to_json(NEW),
            current_setting('app.current_user_id', true)::INTEGER,
            NOW()
        );
        RETURN NEW;
    END IF;
    
    -- Pour les INSERT
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit_log (
            table_name,
            operation,
            new_values,
            user_id,
            timestamp
        ) VALUES (
            TG_TABLE_NAME,
            TG_OP,
            row_to_json(NEW),
            current_setting('app.current_user_id', true)::INTEGER,
            NOW()
        );
        RETURN NEW;
    END IF;
    
    -- Pour les DELETE
    IF TG_OP = 'DELETE' THEN
        INSERT INTO audit_log (
            table_name,
            operation,
            old_values,
            user_id,
            timestamp
        ) VALUES (
            TG_TABLE_NAME,
            TG_OP,
            row_to_json(OLD),
            current_setting('app.current_user_id', true)::INTEGER,
            NOW()
        );
        RETURN OLD;
    END IF;
    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- ==========================================
-- INDEXES PRÉLIMINAIRES POUR PERFORMANCE
-- ==========================================

-- Ces indexes seront recréés automatiquement par Sequelize
-- mais on peut en définir des spécifiques ici

-- Notification de fin d'initialisation
DO $$
BEGIN
    RAISE NOTICE '✅ Base de données SushiWan initialisée avec succès !';
    RAISE NOTICE '🏷️  Extensions installées : uuid-ossp, unaccent, pg_trgm';
    RAISE NOTICE '⚙️  Fonctions utilitaires créées';
    RAISE NOTICE '📍 Fuseau horaire : Africa/Tunis';
END $$;
