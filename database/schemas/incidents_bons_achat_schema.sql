--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-1.pgdg120+1)
-- Dumped by pg_dump version 15.13 (Debian 15.13-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: communication_frequency; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.communication_frequency AS ENUM (
    'jamais',
    'rare',
    'normale',
    'frequente'
);


ALTER TYPE public.communication_frequency OWNER TO sushiwan_admin;

--
-- Name: enum_ingredients_categorie_ingredient; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.enum_ingredients_categorie_ingredient AS ENUM (
    'POISSON',
    'CRUSTACE',
    'VIANDE',
    'LEGUME',
    'FRUIT',
    'SAUCE',
    'EPICE',
    'CEREALE',
    'PRODUIT_LAITIER',
    'AUTRE'
);


ALTER TYPE public.enum_ingredients_categorie_ingredient OWNER TO sushiwan_admin;

--
-- Name: genre_client; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.genre_client AS ENUM (
    'M',
    'F',
    'Autre'
);


ALTER TYPE public.genre_client OWNER TO sushiwan_admin;

--
-- Name: interaction_type; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.interaction_type AS ENUM (
    'email',
    'sms',
    'call',
    'visite_site',
    'commande',
    'chat',
    'social'
);


ALTER TYPE public.interaction_type OWNER TO sushiwan_admin;

--
-- Name: langue_client; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.langue_client AS ENUM (
    'FR',
    'EN',
    'TN',
    'JP'
);


ALTER TYPE public.langue_client OWNER TO sushiwan_admin;

--
-- Name: mission_type_enum; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.mission_type_enum AS ENUM (
    'commandes_sans_incident',
    'montant_cumule',
    'fidelite_temps',
    'parrainage_amis',
    'avis_positifs',
    'premiere_commande_mensuelle',
    'commande_weekend',
    'plats_varies'
);


ALTER TYPE public.mission_type_enum OWNER TO sushiwan_admin;

--
-- Name: mode_paiement_enum; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.mode_paiement_enum AS ENUM (
    'Especes',
    'TPE',
    'Konnect'
);


ALTER TYPE public.mode_paiement_enum OWNER TO sushiwan_admin;

--
-- Name: origine_bon_enum; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.origine_bon_enum AS ENUM (
    'incident_compensation',
    'conversion_points',
    'cadeau_restaurant',
    'jeu_concours',
    'promotion_marketing',
    'parrainage',
    'cadeau_staff',
    'anniversaire_client',
    'premiere_commande',
    'fidelite_milestone'
);


ALTER TYPE public.origine_bon_enum OWNER TO sushiwan_admin;

--
-- Name: priorite_incident; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.priorite_incident AS ENUM (
    'basse',
    'normale',
    'haute',
    'critique'
);


ALTER TYPE public.priorite_incident OWNER TO sushiwan_admin;

--
-- Name: priorite_incident_enum; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.priorite_incident_enum AS ENUM (
    'basse',
    'normale',
    'haute',
    'critique'
);


ALTER TYPE public.priorite_incident_enum OWNER TO sushiwan_admin;

--
-- Name: source_commande_enum; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.source_commande_enum AS ENUM (
    'site_web',
    'mobile_app',
    'qr_table',
    'whatsapp',
    'telephone',
    'sur_place'
);


ALTER TYPE public.source_commande_enum OWNER TO sushiwan_admin;

--
-- Name: statut_approbation_enum; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.statut_approbation_enum AS ENUM (
    'en_attente',
    'approuve',
    'rejete',
    'auto_approuve'
);


ALTER TYPE public.statut_approbation_enum OWNER TO sushiwan_admin;

--
-- Name: statut_client; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.statut_client AS ENUM (
    'Actif',
    'Inactif',
    'VIP',
    'Blacklisté'
);


ALTER TYPE public.statut_client OWNER TO sushiwan_admin;

--
-- Name: statut_commande_enum; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.statut_commande_enum AS ENUM (
    'Recu',
    'Confirme',
    'Preparation',
    'Pret',
    'En_route',
    'Livre',
    'Annule'
);


ALTER TYPE public.statut_commande_enum OWNER TO sushiwan_admin;

--
-- Name: statut_incident; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.statut_incident AS ENUM (
    'ouvert',
    'en_cours',
    'resolu',
    'annule',
    'escalade'
);


ALTER TYPE public.statut_incident OWNER TO sushiwan_admin;

--
-- Name: statut_incident_enum; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.statut_incident_enum AS ENUM (
    'ouvert',
    'en_cours',
    'resolu',
    'annule',
    'escalade'
);


ALTER TYPE public.statut_incident_enum OWNER TO sushiwan_admin;

--
-- Name: sync_status_type; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.sync_status_type AS ENUM (
    'synced',
    'pending',
    'error',
    'manual'
);


ALTER TYPE public.sync_status_type OWNER TO sushiwan_admin;

--
-- Name: taux_tva_tunisien; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.taux_tva_tunisien AS ENUM (
    '0',
    '7',
    '13',
    '19'
);


ALTER TYPE public.taux_tva_tunisien OWNER TO sushiwan_admin;

--
-- Name: transaction_status_enum; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.transaction_status_enum AS ENUM (
    'en_attente',
    'paye',
    'echec',
    'rembourse'
);


ALTER TYPE public.transaction_status_enum OWNER TO sushiwan_admin;

--
-- Name: type_adresse; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.type_adresse AS ENUM (
    'Domicile',
    'Travail',
    'Temporaire',
    'Famille',
    'Autre'
);


ALTER TYPE public.type_adresse OWNER TO sushiwan_admin;

--
-- Name: type_bon_enum; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.type_bon_enum AS ENUM (
    'montant_fixe',
    'remise_pourcentage',
    'livraison_gratuite',
    'produit_gratuit'
);


ALTER TYPE public.type_bon_enum OWNER TO sushiwan_admin;

--
-- Name: type_client; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.type_client AS ENUM (
    'Sur place',
    'Livraison',
    'Emporter',
    'Mixte'
);


ALTER TYPE public.type_client OWNER TO sushiwan_admin;

--
-- Name: type_commande_enum; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.type_commande_enum AS ENUM (
    'Sur place',
    'Emporter',
    'Livraison'
);


ALTER TYPE public.type_commande_enum OWNER TO sushiwan_admin;

--
-- Name: type_compensation_enum; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.type_compensation_enum AS ENUM (
    'remboursement_partiel',
    'remboursement_total',
    'bon_reduction',
    'produit_gratuit',
    'livraison_gratuite',
    'aucune',
    'bon_achat',
    'points_fidelite',
    'bon_achat_et_points'
);


ALTER TYPE public.type_compensation_enum OWNER TO sushiwan_admin;

--
-- Name: type_incident; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.type_incident AS ENUM (
    'retard_preparation',
    'retard_livraison',
    'produit_manquant',
    'erreur_commande',
    'probleme_paiement',
    'client_absent',
    'adresse_introuvable',
    'produit_defectueux',
    'allergie_oubliee',
    'autre'
);


ALTER TYPE public.type_incident OWNER TO sushiwan_admin;

--
-- Name: type_incident_enum; Type: TYPE; Schema: public; Owner: sushiwan_admin
--

CREATE TYPE public.type_incident_enum AS ENUM (
    'retard_preparation',
    'retard_livraison',
    'produit_manquant',
    'erreur_commande',
    'probleme_paiement',
    'client_absent',
    'adresse_introuvable',
    'produit_defectueux',
    'allergie_oubliee'
);


ALTER TYPE public.type_incident_enum OWNER TO sushiwan_admin;

--
-- Name: audit_trigger_function(); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.audit_trigger_function() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.audit_trigger_function() OWNER TO sushiwan_admin;

--
-- Name: calculer_frais_livraison_par_zone(public.type_commande_enum, uuid, numeric); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.calculer_frais_livraison_par_zone(p_type_commande public.type_commande_enum, p_adresse_id uuid, p_sous_total_ttc numeric) RETURNS TABLE(frais_ht numeric, frais_tva numeric)
    LANGUAGE plpgsql
    AS $$
DECLARE
    zone_livraison VARCHAR(50) := 'Centre-ville';  -- Défaut
    frais_base_ht DECIMAL(6,2) := 0.00;
    seuil_gratuit DECIMAL(8,2) := 50.00;
    tva_frais DECIMAL(6,2);
BEGIN
    -- Pas de frais pour sur place ou emporter
    IF p_type_commande != 'Livraison' THEN
        RETURN QUERY SELECT 0.00::DECIMAL(6,2), 0.00::DECIMAL(6,2);
        RETURN;
    END IF;
    
    -- Récupérer zone depuis adresse (si table customer_addresses a ce champ)
    -- Sinon utiliser logique par défaut
    
    -- Tarifs par zone (montants HT)
    CASE zone_livraison
        WHEN 'Centre-ville' THEN 
            frais_base_ht := 2.52;  -- 3.00 TTC avec TVA 19%
            seuil_gratuit := 40.00;
        WHEN 'Banlieue' THEN 
            frais_base_ht := 4.20;  -- 5.00 TTC avec TVA 19%
            seuil_gratuit := 50.00;
        WHEN 'Exterieur' THEN 
            frais_base_ht := 6.72;  -- 8.00 TTC avec TVA 19%
            seuil_gratuit := 60.00;
        ELSE 
            frais_base_ht := 4.20;  -- Défaut
            seuil_gratuit := 50.00;
    END CASE;
    
    -- Livraison gratuite si seuil atteint
    IF p_sous_total_ttc >= seuil_gratuit THEN
        frais_base_ht := 0.00;
    END IF;
    
    -- Calculer TVA (19% sur frais livraison)
    tva_frais := calculer_tva_frais_livraison(frais_base_ht);
    
    RETURN QUERY SELECT frais_base_ht, tva_frais;
END;
$$;


ALTER FUNCTION public.calculer_frais_livraison_par_zone(p_type_commande public.type_commande_enum, p_adresse_id uuid, p_sous_total_ttc numeric) OWNER TO sushiwan_admin;

--
-- Name: calculer_ht_depuis_ttc(numeric, public.taux_tva_tunisien); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.calculer_ht_depuis_ttc(p_montant_ttc numeric, p_taux_tva public.taux_tva_tunisien) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN ROUND(
        p_montant_ttc / (1 + (CAST(p_taux_tva::TEXT AS DECIMAL) / 100)), 
        3
    );
END;
$$;


ALTER FUNCTION public.calculer_ht_depuis_ttc(p_montant_ttc numeric, p_taux_tva public.taux_tva_tunisien) OWNER TO sushiwan_admin;

--
-- Name: calculer_risk_score(uuid); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.calculer_risk_score(p_customer_id uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_risk_score INTEGER := 0;
    v_incidents_30j INTEGER;
    v_montant_compensations_30j NUMERIC;
    v_frequence_incidents NUMERIC;
    v_client_age_jours INTEGER;
    v_total_commandes INTEGER;
    v_satisfaction_moyenne NUMERIC;
BEGIN
    -- Calculer l'âge du client en jours (CORRIGÉ)
    SELECT (CURRENT_DATE - created_at::date) 
    INTO v_client_age_jours
    FROM customers 
    WHERE id = p_customer_id;
    
    -- Sécurité si client pas trouvé
    IF v_client_age_jours IS NULL THEN
        v_client_age_jours := 0;
    END IF;
    
    -- Compter les incidents des 30 derniers jours
    SELECT COUNT(*), COALESCE(SUM(montant_compensation), 0)
    INTO v_incidents_30j, v_montant_compensations_30j
    FROM order_incidents oi
    JOIN orders o ON oi.order_id = o.id
    WHERE o.customer_id = p_customer_id
    AND oi.created_at >= CURRENT_DATE - INTERVAL '30 days';
    
    -- Calculer la fréquence d'incidents par mois
    IF v_client_age_jours > 0 THEN
        v_frequence_incidents := (v_incidents_30j::NUMERIC / GREATEST(v_client_age_jours, 1)) * 30;
    ELSE
        v_frequence_incidents := 0;
    END IF;
    
    -- Compter le total de commandes du client
    SELECT COUNT(*) INTO v_total_commandes
    FROM orders
    WHERE customer_id = p_customer_id;
    
    -- Calculer la satisfaction moyenne
    SELECT AVG(note_satisfaction) INTO v_satisfaction_moyenne
    FROM order_incidents
    WHERE customer_id = p_customer_id
    AND note_satisfaction IS NOT NULL;
    
    -- === CALCUL DU RISK SCORE ===
    v_risk_score := v_risk_score + (v_incidents_30j * 20);
    v_risk_score := v_risk_score + v_montant_compensations_30j::INTEGER;
    v_risk_score := v_risk_score + (v_frequence_incidents * 10)::INTEGER;
    
    IF v_total_commandes > 0 AND (v_incidents_30j::NUMERIC / v_total_commandes) > 0.2 THEN
        v_risk_score := v_risk_score + 30;
    END IF;
    
    IF v_satisfaction_moyenne IS NOT NULL AND v_satisfaction_moyenne > 3 THEN
        v_risk_score := v_risk_score - ((v_satisfaction_moyenne - 3) * 10)::INTEGER;
    END IF;
    
    IF v_client_age_jours <= 30 THEN
        v_risk_score := v_risk_score - 10;
    END IF;
    
    v_risk_score := GREATEST(0, LEAST(100, v_risk_score));
    
    RETURN v_risk_score;
END;
$$;


ALTER FUNCTION public.calculer_risk_score(p_customer_id uuid) OWNER TO sushiwan_admin;

--
-- Name: calculer_totaux_commande_depuis_ttc(jsonb); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.calculer_totaux_commande_depuis_ttc(p_items jsonb) RETURNS TABLE(sous_total_ht numeric, tva_montant_total numeric, sous_total_ttc numeric, tva_details jsonb)
    LANGUAGE plpgsql
    AS $$
DECLARE
    item JSONB;
    product_tva taux_tva_tunisien;
    prix_unitaire_ht DECIMAL(10,2);
    prix_unitaire_ttc DECIMAL(10,2);
    quantity INTEGER;
    ligne_ht DECIMAL(10,2);
    ligne_tva DECIMAL(10,2);
    total_ht DECIMAL(10,2) := 0.00;
    total_tva DECIMAL(10,2) := 0.00;
    total_ttc DECIMAL(10,2) := 0.00;
    tva_detail JSONB := '{}'::jsonb;
    taux_str TEXT;
    existing_base DECIMAL(10,2);
    existing_tva DECIMAL(10,2);
BEGIN
    -- Parcourir chaque item de la commande
    FOR item IN SELECT * FROM jsonb_array_elements(p_items)
    LOOP
        -- Récupérer les données de l'item
        quantity := (item->>'quantity')::INTEGER;
        prix_unitaire_ttc := (item->>'prix_unitaire_ttc')::DECIMAL(10,2);
        
        -- Récupérer le taux TVA du produit
        SELECT p.taux_tva INTO product_tva
        FROM products p 
        WHERE p.id = (item->>'product_id')::UUID;
        
        -- Calculer prix HT unitaire
        prix_unitaire_ht := calculer_ht_depuis_ttc(prix_unitaire_ttc, product_tva);
        
        -- Calculer totaux ligne
        ligne_ht := prix_unitaire_ht * quantity;
        ligne_tva := calculer_tva_ht(ligne_ht, product_tva);
        
        -- Cumuler totaux
        total_ht := total_ht + ligne_ht;
        total_tva := total_tva + ligne_tva;
        
        -- Grouper TVA par taux pour détail
        taux_str := product_tva::TEXT;
        
        IF tva_detail ? taux_str THEN
            existing_base := (tva_detail->taux_str->>'base')::DECIMAL(10,2);
            existing_tva := (tva_detail->taux_str->>'tva')::DECIMAL(10,2);
            
            tva_detail := jsonb_set(
                tva_detail,
                ARRAY[taux_str, 'base'],
                to_jsonb(existing_base + ligne_ht)
            );
            
            tva_detail := jsonb_set(
                tva_detail,
                ARRAY[taux_str, 'tva'],
                to_jsonb(existing_tva + ligne_tva)
            );
        ELSE
            tva_detail := jsonb_set(
                tva_detail,
                ARRAY[taux_str],
                jsonb_build_object('base', ligne_ht, 'tva', ligne_tva)
            );
        END IF;
    END LOOP;
    
    total_ttc := total_ht + total_tva;
    
    RETURN QUERY SELECT total_ht, total_tva, total_ttc, tva_detail;
END;
$$;


ALTER FUNCTION public.calculer_totaux_commande_depuis_ttc(p_items jsonb) OWNER TO sushiwan_admin;

--
-- Name: calculer_ttc_depuis_ht(numeric, public.taux_tva_tunisien); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.calculer_ttc_depuis_ht(p_montant_ht numeric, p_taux_tva public.taux_tva_tunisien) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN p_montant_ht + calculer_tva_ht(p_montant_ht, p_taux_tva);
END;
$$;


ALTER FUNCTION public.calculer_ttc_depuis_ht(p_montant_ht numeric, p_taux_tva public.taux_tva_tunisien) OWNER TO sushiwan_admin;

--
-- Name: calculer_tva_frais_livraison(numeric); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.calculer_tva_frais_livraison(p_montant_ht numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Frais de livraison = 19% TVA en Tunisie
    RETURN ROUND(p_montant_ht * 0.19, 3);
END;
$$;


ALTER FUNCTION public.calculer_tva_frais_livraison(p_montant_ht numeric) OWNER TO sushiwan_admin;

--
-- Name: calculer_tva_ht(numeric, public.taux_tva_tunisien); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.calculer_tva_ht(p_montant_ht numeric, p_taux_tva public.taux_tva_tunisien) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN ROUND(
        p_montant_ht * (CAST(p_taux_tva::TEXT AS DECIMAL) / 100), 
        3  -- Précision à 3 décimales pour la TVA
    );
END;
$$;


ALTER FUNCTION public.calculer_tva_ht(p_montant_ht numeric, p_taux_tva public.taux_tva_tunisien) OWNER TO sushiwan_admin;

--
-- Name: ensure_single_default_address(); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.ensure_single_default_address() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Si cette adresse devient par défaut
    IF NEW.adresse_par_defaut = true THEN
        -- Désactiver toutes les autres adresses par défaut du même client
        UPDATE customer_addresses 
        SET adresse_par_defaut = false 
        WHERE customer_id = NEW.customer_id 
        AND id != NEW.id 
        AND deleted_at IS NULL;
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.ensure_single_default_address() OWNER TO sushiwan_admin;

--
-- Name: evaluer_auto_approbation(uuid, public.origine_bon_enum, public.type_bon_enum, numeric, character varying, integer); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.evaluer_auto_approbation(p_customer_id uuid, p_origine public.origine_bon_enum, p_type_bon public.type_bon_enum, p_montant numeric, p_niveau_staff character varying, p_risk_score integer DEFAULT 0) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_regle RECORD;
    v_count_jour INTEGER;
    v_count_mois INTEGER;
BEGIN
    -- Parcourir les règles par ordre de priorité
    FOR v_regle IN 
        SELECT * FROM regles_approbation_bons 
        WHERE origine = p_origine 
        AND (type_bon IS NULL OR type_bon = p_type_bon)
        AND actif = true
        AND (date_debut IS NULL OR date_debut <= CURRENT_DATE)
        AND (date_fin IS NULL OR date_fin >= CURRENT_DATE)
        AND niveau_staff_requis = p_niveau_staff
        AND montant_max_auto_approuve >= p_montant
        AND risk_score_max >= p_risk_score
        ORDER BY priorite ASC
    LOOP
        -- Vérifier les limites quotidiennes
        SELECT COUNT(*) INTO v_count_jour
        FROM bons_achat 
        WHERE customer_id = p_customer_id 
        AND DATE(created_at) = CURRENT_DATE
        AND statut_approbation IN ('auto_approuve', 'approuve');
        
        IF v_count_jour >= v_regle.max_par_client_jour THEN
            CONTINUE;
        END IF;
        
        -- Vérifier les limites mensuelles
        SELECT COUNT(*) INTO v_count_mois
        FROM bons_achat 
        WHERE customer_id = p_customer_id 
        AND created_at >= DATE_TRUNC('month', CURRENT_DATE)
        AND statut_approbation IN ('auto_approuve', 'approuve');
        
        IF v_count_mois >= v_regle.max_par_client_mois THEN
            CONTINUE;
        END IF;
        
        -- Toutes les conditions sont remplies !
        RETURN true;
    END LOOP;
    
    -- Aucune règle ne permet l'auto-approbation
    RETURN false;
END;
$$;


ALTER FUNCTION public.evaluer_auto_approbation(p_customer_id uuid, p_origine public.origine_bon_enum, p_type_bon public.type_bon_enum, p_montant numeric, p_niveau_staff character varying, p_risk_score integer) OWNER TO sushiwan_admin;

--
-- Name: format_telephone_display(character varying); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.format_telephone_display(tel character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
BEGIN
    IF tel ~ '^216[0-9]{8}$' THEN
        RETURN '+' || substring(tel, 1, 3) || ' ' || 
               substring(tel, 4, 2) || ' ' || 
               substring(tel, 6, 2) || ' ' || 
               substring(tel, 8, 2) || ' ' || 
               substring(tel, 10, 2);
    ELSE
        RETURN tel;
    END IF;
END;
$_$;


ALTER FUNCTION public.format_telephone_display(tel character varying) OWNER TO sushiwan_admin;

--
-- Name: generate_slug(text); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.generate_slug(input_text text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
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
$$;


ALTER FUNCTION public.generate_slug(input_text text) OWNER TO sushiwan_admin;

--
-- Name: generer_code_bon_achat_sw(); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.generer_code_bon_achat_sw() RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    code_base VARCHAR(11);        -- SW-YYYYMMDD
    numero_sequence INTEGER;      -- Numéro séquentiel du jour
    code_final VARCHAR(20);       -- Code complet SW-YYYYMMDD-NNN
    code_existe BOOLEAN;          -- Vérification unicité
BEGIN
    -- Générer la base du code avec la date du jour (Tunisie)
    code_base := 'SW-' || to_char(CURRENT_DATE, 'YYYYMMDD');
    
    -- Boucle pour trouver le prochain numéro disponible
    numero_sequence := 1;
    
    LOOP
        -- Construire le code complet avec le numéro formaté sur 3 chiffres
        code_final := code_base || '-' || lpad(numero_sequence::text, 3, '0');
        
        -- Vérifier si ce code existe déjà dans bons_achat
        SELECT EXISTS (
            SELECT 1 FROM bons_achat 
            WHERE code_bon = code_final
        ) INTO code_existe;
        
        -- Si le code n'existe pas, on l'utilise
        IF NOT code_existe THEN
            EXIT;
        END IF;
        
        -- Sinon, essayer le numéro suivant
        numero_sequence := numero_sequence + 1;
        
        -- Sécurité : éviter boucle infinie (max 999 bons par jour)
        IF numero_sequence > 999 THEN
            RAISE EXCEPTION 'Limite de 999 bons d''achat par jour atteinte pour le %', CURRENT_DATE;
        END IF;
    END LOOP;
    
    -- Retourner le code unique généré
    RETURN code_final;
END;
$$;


ALTER FUNCTION public.generer_code_bon_achat_sw() OWNER TO sushiwan_admin;

--
-- Name: generer_numero_commande(); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.generer_numero_commande() RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    date_jour VARCHAR(8);
    sequence_jour INTEGER;
    numero_final VARCHAR(25);
BEGIN
    date_jour := TO_CHAR(CURRENT_DATE, 'YYYYMMDD');
    
    -- Compter les commandes du jour
    SELECT COALESCE(MAX(
        CAST(
            SUBSTRING(numero_commande FROM LENGTH(numero_commande) - 3)
            AS INTEGER
        )
    ), 0) + 1
    INTO sequence_jour
    FROM orders 
    WHERE numero_commande LIKE 'SUSH-' || date_jour || '-%'
    AND deleted_at IS NULL;
    
    numero_final := 'SUSH-' || date_jour || '-' || LPAD(sequence_jour::TEXT, 4, '0');
    
    RETURN numero_final;
END;
$$;


ALTER FUNCTION public.generer_numero_commande() OWNER TO sushiwan_admin;

--
-- Name: generer_numero_incident(); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.generer_numero_incident() RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    date_jour VARCHAR(8);
    sequence_jour INTEGER;
    numero_final VARCHAR(20);
BEGIN
    date_jour := TO_CHAR(CURRENT_DATE, 'YYYYMMDD');
    
    SELECT COALESCE(MAX(
        CAST(
            SUBSTRING(numero_incident FROM POSITION('-' IN REVERSE(numero_incident)) + 1)
            AS INTEGER
        )
    ), 0) + 1
    INTO sequence_jour
    FROM order_incidents 
    WHERE numero_incident LIKE 'INC-' || date_jour || '-%'
    AND deleted_at IS NULL;
    
    numero_final := 'INC-' || date_jour || '-' || LPAD(sequence_jour::TEXT, 3, '0');
    
    RETURN numero_final;
END;
$$;


ALTER FUNCTION public.generer_numero_incident() OWNER TO sushiwan_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: customer_addresses; Type: TABLE; Schema: public; Owner: sushiwan_admin
--

CREATE TABLE public.customer_addresses (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    customer_id uuid NOT NULL,
    nom_adresse character varying(100) NOT NULL,
    type_adresse public.type_adresse DEFAULT 'Domicile'::public.type_adresse,
    adresse_complete text NOT NULL,
    ville character varying(100) NOT NULL,
    code_postal character varying(10),
    quartier character varying(100),
    complement_adresse text,
    coordonnees_gps point,
    geoloc_autorisee boolean DEFAULT false,
    geoloc_precision numeric(8,2),
    geoloc_obtenue_le timestamp with time zone,
    zone_livraison_id uuid,
    frais_livraison_personnalises numeric(6,2),
    livraison_possible boolean DEFAULT true,
    temps_livraison_estime integer,
    adresse_par_defaut boolean DEFAULT false,
    adresse_facturation boolean DEFAULT false,
    instructions_livraison text,
    contact_sur_place character varying(100),
    telephone_contact character varying(12),
    nombre_livraisons integer DEFAULT 0,
    derniere_livraison timestamp with time zone,
    note_moyenne_livraison numeric(3,2) DEFAULT 0.00,
    adresse_verifiee boolean DEFAULT false,
    adresse_problematique boolean DEFAULT false,
    raison_probleme text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    last_used_at timestamp with time zone,
    deleted_at timestamp with time zone,
    deleted_by uuid,
    CONSTRAINT chk_addresses_gps_tunisie CHECK (((coordonnees_gps IS NULL) OR (((coordonnees_gps[0] >= (7.0)::double precision) AND (coordonnees_gps[0] <= (12.0)::double precision)) AND ((coordonnees_gps[1] >= (30.0)::double precision) AND (coordonnees_gps[1] <= (38.0)::double precision))))),
    CONSTRAINT chk_frais_livraison_positifs CHECK (((frais_livraison_personnalises IS NULL) OR (frais_livraison_personnalises >= (0)::numeric))),
    CONSTRAINT chk_geoloc_coherence CHECK ((((coordonnees_gps IS NULL) AND (geoloc_autorisee = false)) OR ((coordonnees_gps IS NOT NULL) AND (geoloc_autorisee = true)) OR ((coordonnees_gps IS NULL) AND (geoloc_autorisee = true)))),
    CONSTRAINT chk_temps_livraison_positif CHECK (((temps_livraison_estime IS NULL) OR (temps_livraison_estime > 0))),
    CONSTRAINT customer_addresses_nombre_livraisons_check CHECK ((nombre_livraisons >= 0)),
    CONSTRAINT customer_addresses_note_moyenne_livraison_check CHECK (((note_moyenne_livraison >= (0)::numeric) AND (note_moyenne_livraison <= (5)::numeric)))
);


ALTER TABLE public.customer_addresses OWNER TO sushiwan_admin;

--
-- Name: TABLE customer_addresses; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON TABLE public.customer_addresses IS 'Gestion multi-adresses avec géolocalisation et zones de livraison';


--
-- Name: COLUMN customer_addresses.nom_adresse; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.customer_addresses.nom_adresse IS 'Nom donné par client: "Maison", "Bureau", etc.';


--
-- Name: COLUMN customer_addresses.geoloc_autorisee; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.customer_addresses.geoloc_autorisee IS 'Consentement géolocalisation par adresse';


--
-- Name: COLUMN customer_addresses.zone_livraison_id; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.customer_addresses.zone_livraison_id IS 'Lien vers zones de livraison - calcul frais auto';


--
-- Name: get_adresse_defaut_client(uuid); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.get_adresse_defaut_client(client_id uuid) RETURNS public.customer_addresses
    LANGUAGE plpgsql
    AS $$
DECLARE
    adresse customer_addresses;
BEGIN
    SELECT * INTO adresse 
    FROM customer_addresses 
    WHERE customer_id = client_id 
    AND adresse_par_defaut = true 
    AND deleted_at IS NULL
    LIMIT 1;
    
    -- Si pas d'adresse par défaut, prendre la plus récente
    IF NOT FOUND THEN
        SELECT * INTO adresse 
        FROM customer_addresses 
        WHERE customer_id = client_id 
        AND deleted_at IS NULL
        ORDER BY created_at DESC
        LIMIT 1;
    END IF;
    
    RETURN adresse;
END;
$$;


ALTER FUNCTION public.get_adresse_defaut_client(client_id uuid) OWNER TO sushiwan_admin;

--
-- Name: get_telephone_local(character varying); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.get_telephone_local(tel character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
BEGIN
    IF tel ~ '^216[0-9]{8}$' THEN
        RETURN substring(tel, 4, 8);
    ELSE
        RETURN NULL;
    END IF;
END;
$_$;


ALTER FUNCTION public.get_telephone_local(tel character varying) OWNER TO sushiwan_admin;

--
-- Name: normalize_search_text(text); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.normalize_search_text(input_text text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
BEGIN
    -- Convertir en minuscules, supprimer accents et caractères spéciaux
    RETURN lower(unaccent(trim(input_text)));
END;
$$;


ALTER FUNCTION public.normalize_search_text(input_text text) OWNER TO sushiwan_admin;

--
-- Name: normalize_telephone_contact_adresses(); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.normalize_telephone_contact_adresses() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
    IF NEW.telephone_contact IS NOT NULL THEN
        NEW.telephone_contact = regexp_replace(NEW.telephone_contact, '[^0-9]', '', 'g');
        
        IF length(NEW.telephone_contact) = 8 THEN
            NEW.telephone_contact = '216' || NEW.telephone_contact;
        ELSIF length(NEW.telephone_contact) = 12 AND NEW.telephone_contact LIKE '216%' THEN
            NULL;
        ELSE
            RAISE EXCEPTION 'Format téléphone contact invalide. Saisissez 8 chiffres ou format complet 216XXXXXXXX';
        END IF;
        
        IF NOT (NEW.telephone_contact ~ '^216[0-9]{8}$') THEN
            RAISE EXCEPTION 'Numéro de téléphone contact invalide. Format requis: 216XXXXXXXX';
        END IF;
    END IF;
    
    RETURN NEW;
END;
$_$;


ALTER FUNCTION public.normalize_telephone_contact_adresses() OWNER TO sushiwan_admin;

--
-- Name: normalize_telephone_tunisien(); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.normalize_telephone_tunisien() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
    -- Normaliser le téléphone principal du client
    IF NEW.telephone IS NOT NULL THEN
        -- Nettoyer: enlever espaces, tirets, parenthèses, +
        NEW.telephone = regexp_replace(NEW.telephone, '[^0-9]', '', 'g');
        
        -- Cas 1: 8 chiffres → ajouter 216
        IF length(NEW.telephone) = 8 THEN
            NEW.telephone = '216' || NEW.telephone;
        -- Cas 2: 12 chiffres commençant par 216 → OK
        ELSIF length(NEW.telephone) = 12 AND NEW.telephone LIKE '216%' THEN
            -- Déjà au bon format
            NULL;
        -- Cas 3: Format invalide
        ELSE
            RAISE EXCEPTION 'Format téléphone invalide. Saisissez 8 chiffres (ex: 29350000) ou format complet 216XXXXXXXX';
        END IF;
        
        -- Validation finale
        IF NOT (NEW.telephone ~ '^216[0-9]{8}$') THEN
            RAISE EXCEPTION 'Numéro de téléphone tunisien invalide. Format requis: 216XXXXXXXX';
        END IF;
    END IF;
    
    RETURN NEW;
END;
$_$;


ALTER FUNCTION public.normalize_telephone_tunisien() OWNER TO sushiwan_admin;

--
-- Name: search_similarity(text, text); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.search_similarity(text1 text, text2 text) RETURNS double precision
    LANGUAGE plpgsql IMMUTABLE
    AS $$
BEGIN
    -- Utilise l'extension pg_trgm pour calculer la similarité
    RETURN similarity(normalize_search_text(text1), normalize_search_text(text2));
END;
$$;


ALTER FUNCTION public.search_similarity(text1 text, text2 text) OWNER TO sushiwan_admin;

--
-- Name: taux_tva_to_decimal(public.taux_tva_tunisien); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.taux_tva_to_decimal(p_taux public.taux_tva_tunisien) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN CAST(p_taux::TEXT AS DECIMAL) / 100.0;
END;
$$;


ALTER FUNCTION public.taux_tva_to_decimal(p_taux public.taux_tva_tunisien) OWNER TO sushiwan_admin;

--
-- Name: trigger_calculer_prix_ht(); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.trigger_calculer_prix_ht() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Calculer prix HT depuis prix TTC
    NEW.prix_ht := calculer_ht_depuis_ttc(NEW.prix, NEW.taux_tva);
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_calculer_prix_ht() OWNER TO sushiwan_admin;

--
-- Name: trigger_calculer_totaux_orders(); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.trigger_calculer_totaux_orders() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    frais_result RECORD;
BEGIN
    -- Calculer frais de livraison avec TVA
    SELECT frais_ht, frais_tva 
    INTO frais_result
    FROM calculer_frais_livraison_par_zone(
        NEW.type_commande,
        NEW.adresse_livraison_id,
        NEW.sous_total_ttc
    );
    
    NEW.frais_livraison_ht := frais_result.frais_ht;
    NEW.frais_livraison_tva := frais_result.frais_tva;
    NEW.frais_livraison_ttc := frais_result.frais_ht + frais_result.frais_tva;
    
    -- Vérifier cohérence sous_total_ttc
    IF NEW.sous_total_ht + NEW.tva_montant_total != NEW.sous_total_ttc THEN
        NEW.sous_total_ttc := NEW.sous_total_ht + NEW.tva_montant_total;
    END IF;
    
    -- Recalculer total final
    NEW.total_ttc := NEW.sous_total_ttc - NEW.remise_montant + NEW.frais_livraison_ttc;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_calculer_totaux_orders() OWNER TO sushiwan_admin;

--
-- Name: trigger_generer_bon_achat(); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.trigger_generer_bon_achat() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_auto_approuve BOOLEAN;
    v_risk_score INTEGER;
BEGIN
    -- Générer le code SW si pas déjà défini
    IF NEW.code_bon IS NULL OR NEW.code_bon = '' THEN
        NEW.code_bon := generer_code_bon_achat_sw();
    END IF;
    
    -- Calculer l'expiration (90 jours par défaut)
    IF NEW.date_expiration IS NULL THEN
        NEW.date_expiration := CURRENT_DATE + INTERVAL '90 days';
    END IF;
    
    -- Calculer le risk score du client
    v_risk_score := calculer_risk_score(NEW.customer_id);
    
    -- Évaluer l'auto-approbation si pas déjà définie
    IF NEW.statut_approbation = 'en_attente' AND NEW.demandeur_staff_id IS NOT NULL THEN
        v_auto_approuve := evaluer_auto_approbation(
            NEW.customer_id,
            NEW.origine,
            NEW.type_bon,
            COALESCE(NEW.montant_tnd, 0),
            'caissier',  -- Niveau par défaut
            v_risk_score
        );
        
        -- Si auto-approuvé, changer le statut
        IF v_auto_approuve THEN
            NEW.statut_approbation := 'auto_approuve';
            NEW.statut_bon := 'actif';
            NEW.date_approbation := CURRENT_TIMESTAMP;
            NEW.approbateur_id := NEW.demandeur_staff_id;  -- Auto-approbation par le demandeur
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_generer_bon_achat() OWNER TO sushiwan_admin;

--
-- Name: trigger_generer_numero_incident(); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.trigger_generer_numero_incident() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    numero_base VARCHAR(14);  -- INC-YYYYMMDD
    numero_sequence INTEGER;
    numero_final VARCHAR(20);
    numero_existe BOOLEAN;
BEGIN
    -- Si numero_incident est déjà défini, ne pas le modifier
    IF NEW.numero_incident IS NOT NULL THEN
        RETURN NEW;
    END IF;
    
    -- Générer la base du numéro avec la date du jour
    numero_base := 'INC-' || to_char(CURRENT_DATE, 'YYYYMMDD');
    
    -- Boucle pour trouver le prochain numéro disponible
    numero_sequence := 1;
    
    LOOP
        -- Construire le numéro complet
        numero_final := numero_base || '-' || lpad(numero_sequence::text, 3, '0');
        
        -- Vérifier si ce numéro existe déjà
        SELECT EXISTS (
            SELECT 1 FROM order_incidents 
            WHERE numero_incident = numero_final
        ) INTO numero_existe;
        
        -- Si le numéro n'existe pas, on l'utilise
        IF NOT numero_existe THEN
            EXIT;
        END IF;
        
        -- Sinon, essayer le numéro suivant
        numero_sequence := numero_sequence + 1;
        
        -- Sécurité : éviter boucle infinie
        IF numero_sequence > 999 THEN
            RAISE EXCEPTION 'Limite de 999 incidents par jour atteinte pour le %', CURRENT_DATE;
        END IF;
    END LOOP;
    
    -- Assigner le numéro généré
    NEW.numero_incident := numero_final;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_generer_numero_incident() OWNER TO sushiwan_admin;

--
-- Name: trigger_incident_resolution(); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.trigger_incident_resolution() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Marquer automatiquement l'heure de résolution
    IF NEW.statut = 'resolu' AND OLD.statut != 'resolu' THEN
        NEW.resolu_at := CURRENT_TIMESTAMP;
        NEW.temps_resolution_reel := NEW.resolu_at - NEW.created_at;
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_incident_resolution() OWNER TO sushiwan_admin;

--
-- Name: trigger_orders_statut_historique(); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.trigger_orders_statut_historique() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.statut_commande != OLD.statut_commande THEN
        NEW.statut_precedent := OLD.statut_commande;
        NEW.statut_change_at := CURRENT_TIMESTAMP;
        
        -- Log pour debug
        RAISE NOTICE 'Statut commande % changé: % -> %', 
                     NEW.numero_commande, OLD.statut_commande, NEW.statut_commande;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_orders_statut_historique() OWNER TO sushiwan_admin;

--
-- Name: trigger_set_numero_commande(); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.trigger_set_numero_commande() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.numero_commande IS NULL OR NEW.numero_commande = '' THEN
        NEW.numero_commande := generer_numero_commande();
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_set_numero_commande() OWNER TO sushiwan_admin;

--
-- Name: trigger_set_numero_incident(); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.trigger_set_numero_incident() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.numero_incident IS NULL OR NEW.numero_incident = '' THEN
        NEW.numero_incident := generer_numero_incident();
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_set_numero_incident() OWNER TO sushiwan_admin;

--
-- Name: trigger_update_risk_profile(); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.trigger_update_risk_profile() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_risk_score INTEGER;
    v_risk_level VARCHAR(20);
    v_customer_id UUID;
BEGIN
    -- Déterminer le customer_id selon le type d'opération
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        v_customer_id := NEW.customer_id;
    ELSIF TG_OP = 'DELETE' THEN
        v_customer_id := OLD.customer_id;
    END IF;
    
    -- Calculer le nouveau risk score
    v_risk_score := calculer_risk_score(v_customer_id);
    
    -- Déterminer le niveau de risque
    IF v_risk_score >= 80 THEN
        v_risk_level := 'critique';
    ELSIF v_risk_score >= 60 THEN
        v_risk_level := 'haut';
    ELSIF v_risk_score >= 30 THEN
        v_risk_level := 'moyen';
    ELSE
        v_risk_level := 'bas';
    END IF;
    
    -- Mettre à jour ou créer le profil de risque (CORRIGÉ)
    INSERT INTO clients_risk_profile (
        customer_id, 
        risk_score, 
        risk_level,
        nombre_incidents_30j,
        montant_compensations_30j,
        dernier_incident_date,
        updated_at
    ) 
    VALUES (
        v_customer_id,
        v_risk_score,
        v_risk_level,
        (SELECT COUNT(*) FROM order_incidents oi 
         JOIN orders o ON oi.order_id = o.id 
         WHERE o.customer_id = v_customer_id 
         AND oi.created_at >= CURRENT_DATE - INTERVAL '30 days'),
        (SELECT COALESCE(SUM(montant_compensation), 0) FROM order_incidents oi
         JOIN orders o ON oi.order_id = o.id
         WHERE o.customer_id = v_customer_id 
         AND oi.created_at >= CURRENT_DATE - INTERVAL '30 days'),
        (SELECT MAX(oi.created_at) FROM order_incidents oi  -- CORRIGÉ: oi.created_at
         JOIN orders o ON oi.order_id = o.id
         WHERE o.customer_id = v_customer_id),
        CURRENT_TIMESTAMP
    )
    ON CONFLICT (customer_id) DO UPDATE SET
        risk_score = EXCLUDED.risk_score,
        risk_level = EXCLUDED.risk_level,
        nombre_incidents_30j = EXCLUDED.nombre_incidents_30j,
        montant_compensations_30j = EXCLUDED.montant_compensations_30j,
        dernier_incident_date = EXCLUDED.dernier_incident_date,
        updated_at = CURRENT_TIMESTAMP;
    
    -- Flag pour review si score élevé
    IF v_risk_score >= 70 THEN
        UPDATE clients_risk_profile 
        SET flagged_for_review = true 
        WHERE customer_id = v_customer_id;
    END IF;
    
    RETURN COALESCE(NEW, OLD);
END;
$$;


ALTER FUNCTION public.trigger_update_risk_profile() OWNER TO sushiwan_admin;

--
-- Name: update_addresses_updated_at(); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.update_addresses_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_addresses_updated_at() OWNER TO sushiwan_admin;

--
-- Name: update_customers_updated_at(); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.update_customers_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_customers_updated_at() OWNER TO sushiwan_admin;

--
-- Name: update_updated_at(); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.update_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at() OWNER TO sushiwan_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO sushiwan_admin;

--
-- Name: verifier_substitution_produit(integer, text); Type: FUNCTION; Schema: public; Owner: sushiwan_admin
--

CREATE FUNCTION public.verifier_substitution_produit(p_product_id integer, p_ingredient_en_rupture text) RETURNS TABLE(action text, replacement_ingredient_id integer, replacement_name_fr text, replacement_name_en text, replacement_name_tn text, replacement_name_jp text, price_reduction numeric, message_client_fr text, message_client_en text, message_client_tn text, message_client_jp text, rule_source text)
    LANGUAGE plpgsql
    AS $$
DECLARE
  product_substitutions JSON;          -- JSON des substitutions du produit
  custom_rule JSON;                    -- Règle personnalisée extraite
  has_custom_rule BOOLEAN := FALSE;    -- Flag pour vérifier l'existence de règle
  
  -- Variables pour le remplacement global (séparées au lieu d'un RECORD)
  global_replacement_id INTEGER;
  global_replacement_nom_fr TEXT;
  global_replacement_nom_en TEXT;
  global_replacement_nom_tn TEXT;
  global_replacement_nom_jp TEXT;
BEGIN
  
  -- 📊 ÉTAPE 1 : Récupérer les substitutions personnalisées du produit
  SELECT substitutions_personnalisees 
  INTO product_substitutions
  FROM products 
  WHERE id = p_product_id;
  
  -- 🔍 Debug : Afficher ce qu'on a trouvé
  RAISE NOTICE 'Produit ID: %, Ingrédient: %, Substitutions: %', 
    p_product_id, p_ingredient_en_rupture, product_substitutions;
  
  -- 🎯 PRIORITÉ 1 : Vérifier si une règle personnalisée existe
  IF product_substitutions IS NOT NULL THEN
    -- Essayer d'extraire la règle pour cet ingrédient
    custom_rule := product_substitutions->p_ingredient_en_rupture;
    
    -- Vérifier si la règle existe (pas NULL)
    IF custom_rule IS NOT NULL THEN
      has_custom_rule := TRUE;
      RAISE NOTICE 'Règle personnalisée trouvée: %', custom_rule;
    END IF;
  END IF;
  
  -- Si on a trouvé une règle personnalisée
  IF has_custom_rule THEN
    
    -- Cas 1 : Action = "disable" (désactiver le produit)
    IF custom_rule->>'action' = 'disable' THEN
      RETURN QUERY SELECT
        'disable'::TEXT,
        NULL::INTEGER,
        NULL::TEXT, NULL::TEXT, NULL::TEXT, NULL::TEXT,
        0::DECIMAL(8,2),
        COALESCE(custom_rule->>'message_fr', 'Produit temporairement indisponible'),
        COALESCE(custom_rule->>'message_en', 'Product temporarily unavailable'),
        COALESCE(custom_rule->>'message_tn', 'المنتج غير متوفر مؤقتا'),
        COALESCE(custom_rule->>'message_jp', '一時的に利用できません'),
        'custom'::TEXT;
      RETURN;
    END IF;
    
    -- Cas 2 : Action = "replace" (remplacement personnalisé)
    IF custom_rule->>'action' = 'replace' THEN
      -- Récupérer les détails de l'ingrédient de remplacement
      SELECT nom_fr, nom_en, nom_tn, nom_jp
      INTO replacement_name_fr, replacement_name_en, replacement_name_tn, replacement_name_jp
      FROM ingredients 
      WHERE id = (custom_rule->>'replacement_ingredient_id')::INTEGER;
      
      RETURN QUERY SELECT
        'replace'::TEXT,
        (custom_rule->>'replacement_ingredient_id')::INTEGER,
        replacement_name_fr, replacement_name_en, replacement_name_tn, replacement_name_jp,
        COALESCE((custom_rule->>'price_reduction')::DECIMAL(8,2), 0),
        COALESCE(custom_rule->>'message_fr', replacement_name_fr || ' (remplace ' || p_ingredient_en_rupture || ')'),
        COALESCE(custom_rule->>'message_en', replacement_name_en || ' (replaces ' || p_ingredient_en_rupture || ')'),
        COALESCE(custom_rule->>'message_tn', replacement_name_tn || ' (يحل محل ' || p_ingredient_en_rupture || ')'),
        COALESCE(custom_rule->>'message_jp', replacement_name_jp || ' (' || p_ingredient_en_rupture || 'の代わり)'),
        'custom'::TEXT;
      RETURN;
    END IF;
    
    -- Cas 3 : Action = "ignore" (continuer sans substitution)
    IF custom_rule->>'action' = 'ignore' THEN
      RETURN QUERY SELECT
        'ignore'::TEXT,
        NULL::INTEGER,
        NULL::TEXT, NULL::TEXT, NULL::TEXT, NULL::TEXT,
        0::DECIMAL(8,2),
        ''::TEXT, ''::TEXT, ''::TEXT, ''::TEXT,
        'custom'::TEXT;
      RETURN;
    END IF;
    
  END IF;
  
  -- 🌍 PRIORITÉ 2 : Utiliser les règles globales (système actuel)
  RAISE NOTICE 'Aucune règle personnalisée, utilisation règle globale pour: %', p_ingredient_en_rupture;
  
  -- Règles globales codées en dur
  -- Avocat → Concombre avec remise 2 DT
  IF LOWER(p_ingredient_en_rupture) = 'avocat' THEN
    SELECT id, nom_fr, nom_en, nom_tn, nom_jp
    INTO global_replacement_id, global_replacement_nom_fr, global_replacement_nom_en, 
         global_replacement_nom_tn, global_replacement_nom_jp
    FROM ingredients 
    WHERE LOWER(nom_fr) = 'concombre'
    LIMIT 1;
    
    IF global_replacement_id IS NOT NULL THEN
      RETURN QUERY SELECT
        'replace'::TEXT,
        global_replacement_id,
        global_replacement_nom_fr, global_replacement_nom_en, 
        global_replacement_nom_tn, global_replacement_nom_jp,
        2.00::DECIMAL(8,2),
        global_replacement_nom_fr || ' (remplace Avocat)'::TEXT,
        global_replacement_nom_en || ' (replaces Avocado)'::TEXT,
        global_replacement_nom_tn || ' (يحل محل الأفوكادو)'::TEXT,
        global_replacement_nom_jp || ' (アボカドの代わり)'::TEXT,
        'global'::TEXT;
      RETURN;
    END IF;
  END IF;
  
  -- Sésame → Saumon avec remise 1.50 DT  
  IF LOWER(p_ingredient_en_rupture) = 'sésame' OR LOWER(p_ingredient_en_rupture) = 'sesame' THEN
    SELECT id, nom_fr, nom_en, nom_tn, nom_jp
    INTO global_replacement_id, global_replacement_nom_fr, global_replacement_nom_en,
         global_replacement_nom_tn, global_replacement_nom_jp
    FROM ingredients 
    WHERE LOWER(nom_fr) = 'saumon'
    LIMIT 1;
    
    IF global_replacement_id IS NOT NULL THEN
      RETURN QUERY SELECT
        'replace'::TEXT,
        global_replacement_id,
        global_replacement_nom_fr, global_replacement_nom_en,
        global_replacement_nom_tn, global_replacement_nom_jp,
        1.50::DECIMAL(8,2),
        global_replacement_nom_fr || ' (remplace Sésame)'::TEXT,
        global_replacement_nom_en || ' (replaces Sesame)'::TEXT,
        global_replacement_nom_tn || ' (يحل محل السمسم)'::TEXT,
        global_replacement_nom_jp || ' (ゴマの代わり)'::TEXT,
        'global'::TEXT;
      RETURN;
    END IF;
  END IF;
  
  -- 🚫 AUCUNE RÈGLE TROUVÉE : Désactiver le produit par défaut
  RETURN QUERY SELECT
    'disable'::TEXT,
    NULL::INTEGER,
    NULL::TEXT, NULL::TEXT, NULL::TEXT, NULL::TEXT,
    0::DECIMAL(8,2),
    'Produit temporairement indisponible (' || p_ingredient_en_rupture || ' en rupture)'::TEXT,
    'Product temporarily unavailable (' || p_ingredient_en_rupture || ' shortage)'::TEXT,
    'المنتج غير متوفر مؤقتا (نقص في ' || p_ingredient_en_rupture || ')'::TEXT,
    '一時的にご利用いただけません（' || p_ingredient_en_rupture || '不足）'::TEXT,
    'default'::TEXT;
  
END;
$$;


ALTER FUNCTION public.verifier_substitution_produit(p_product_id integer, p_ingredient_en_rupture text) OWNER TO sushiwan_admin;

--
-- Name: bons_achat; Type: TABLE; Schema: public; Owner: sushiwan_admin
--

CREATE TABLE public.bons_achat (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    code_bon character varying(20) NOT NULL,
    customer_id uuid NOT NULL,
    origine public.origine_bon_enum NOT NULL,
    incident_id uuid,
    points_utilises integer DEFAULT 0,
    staff_createur_id uuid,
    raison_creation text NOT NULL,
    type_bon public.type_bon_enum DEFAULT 'montant_fixe'::public.type_bon_enum NOT NULL,
    montant_tnd numeric(8,2) DEFAULT 0.00,
    remise_pourcentage numeric(5,2) DEFAULT 0,
    produit_gratuit_id integer,
    statut_approbation public.statut_approbation_enum DEFAULT 'en_attente'::public.statut_approbation_enum NOT NULL,
    demandeur_staff_id uuid,
    justification_demande text NOT NULL,
    approbateur_id uuid,
    date_approbation timestamp with time zone,
    date_creation timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    date_expiration date NOT NULL,
    statut_bon character varying(20) DEFAULT 'en_attente'::character varying NOT NULL,
    date_utilisation timestamp with time zone,
    commande_utilisation_id uuid,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT bons_achat_remise_pourcentage_check CHECK (((remise_pourcentage >= (0)::numeric) AND (remise_pourcentage <= (100)::numeric))),
    CONSTRAINT bons_achat_statut_bon_check CHECK (((statut_bon)::text = ANY ((ARRAY['en_attente'::character varying, 'actif'::character varying, 'utilise'::character varying, 'expire'::character varying, 'annule'::character varying])::text[])))
);


ALTER TABLE public.bons_achat OWNER TO sushiwan_admin;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: sushiwan_admin
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    code_interne character varying(50) NOT NULL,
    nom_fr character varying(255) NOT NULL,
    nom_en character varying(255),
    nom_tn character varying(255),
    nom_jp character varying(255),
    description_fr text,
    description_en text,
    description_tn text,
    description_jp text,
    image_url character varying(500),
    ordre_affichage integer DEFAULT 0 NOT NULL,
    actif boolean DEFAULT true NOT NULL,
    slug character varying(300),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.categories OWNER TO sushiwan_admin;

--
-- Name: COLUMN categories.id; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.categories.id IS 'Identifiant unique de la catégorie';


--
-- Name: COLUMN categories.code_interne; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.categories.code_interne IS 'Code interne unique pour identifier la catégorie (ex: SUSHI_MAKI)';


--
-- Name: COLUMN categories.nom_fr; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.categories.nom_fr IS 'Nom de la catégorie en français (langue de base)';


--
-- Name: COLUMN categories.nom_en; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.categories.nom_en IS 'Nom de la catégorie en anglais (auto-traduit si vide)';


--
-- Name: COLUMN categories.nom_tn; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.categories.nom_tn IS 'Nom de la catégorie en tunisien (auto-traduit si vide)';


--
-- Name: COLUMN categories.nom_jp; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.categories.nom_jp IS 'Nom de la catégorie en japonais (auto-traduit si vide)';


--
-- Name: COLUMN categories.description_fr; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.categories.description_fr IS 'Description détaillée de la catégorie en français';


--
-- Name: COLUMN categories.description_en; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.categories.description_en IS 'Description de la catégorie en anglais';


--
-- Name: COLUMN categories.description_tn; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.categories.description_tn IS 'Description de la catégorie en tunisien';


--
-- Name: COLUMN categories.description_jp; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.categories.description_jp IS 'Description de la catégorie en japonais';


--
-- Name: COLUMN categories.image_url; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.categories.image_url IS 'URL de l''image représentant la catégorie';


--
-- Name: COLUMN categories.ordre_affichage; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.categories.ordre_affichage IS 'Ordre d''affichage des catégories (0 = premier)';


--
-- Name: COLUMN categories.actif; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.categories.actif IS 'Indique si la catégorie est active et visible';


--
-- Name: COLUMN categories.slug; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.categories.slug IS 'Slug généré automatiquement pour URLs amicales (ex: sushi-maki)';


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: sushiwan_admin
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO sushiwan_admin;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sushiwan_admin
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: client_missions; Type: TABLE; Schema: public; Owner: sushiwan_admin
--

CREATE TABLE public.client_missions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    customer_id uuid NOT NULL,
    mission_type public.mission_type_enum NOT NULL,
    titre character varying(200) NOT NULL,
    description text NOT NULL,
    objectif_quantite integer NOT NULL,
    progress integer DEFAULT 0,
    reward_type public.type_bon_enum NOT NULL,
    reward_montant numeric(8,2) DEFAULT 0,
    reward_pourcentage numeric(5,2) DEFAULT 0,
    reward_points_fidelite integer DEFAULT 0,
    statut character varying(20) DEFAULT 'active'::character varying,
    date_debut timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_limite timestamp with time zone,
    date_completion timestamp with time zone,
    renouvelable boolean DEFAULT false,
    visible_client boolean DEFAULT true,
    difficulte character varying(20) DEFAULT 'facile'::character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT client_missions_difficulte_check CHECK (((difficulte)::text = ANY ((ARRAY['facile'::character varying, 'moyen'::character varying, 'difficile'::character varying, 'expert'::character varying])::text[]))),
    CONSTRAINT client_missions_statut_check CHECK (((statut)::text = ANY ((ARRAY['active'::character varying, 'completed'::character varying, 'expired'::character varying, 'paused'::character varying])::text[])))
);


ALTER TABLE public.client_missions OWNER TO sushiwan_admin;

--
-- Name: clients_risk_profile; Type: TABLE; Schema: public; Owner: sushiwan_admin
--

CREATE TABLE public.clients_risk_profile (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    customer_id uuid NOT NULL,
    nombre_incidents_30j integer DEFAULT 0,
    montant_compensations_30j numeric(10,2) DEFAULT 0,
    nombre_bons_achat_30j integer DEFAULT 0,
    valeur_bons_achat_30j numeric(10,2) DEFAULT 0,
    risk_score integer DEFAULT 0,
    risk_level character varying(20) DEFAULT 'bas'::character varying,
    flagged_for_review boolean DEFAULT false,
    pattern_suspects jsonb DEFAULT '[]'::jsonb,
    dernier_incident_date timestamp with time zone,
    frequence_incidents numeric(5,2) DEFAULT 0,
    reviewed_by_staff boolean DEFAULT false,
    staff_reviewer_id uuid,
    review_date timestamp with time zone,
    review_notes text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT clients_risk_profile_risk_level_check CHECK (((risk_level)::text = ANY ((ARRAY['bas'::character varying, 'moyen'::character varying, 'haut'::character varying, 'critique'::character varying])::text[]))),
    CONSTRAINT clients_risk_profile_risk_score_check CHECK (((risk_score >= 0) AND (risk_score <= 100)))
);


ALTER TABLE public.clients_risk_profile OWNER TO sushiwan_admin;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: sushiwan_admin
--

CREATE TABLE public.customers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    telephone character varying(12) NOT NULL,
    nom character varying(100) NOT NULL,
    prenom character varying(100) NOT NULL,
    nom_complet character varying(201) GENERATED ALWAYS AS ((((prenom)::text || ' '::text) || (nom)::text)) STORED,
    email character varying(150),
    mot_de_passe character varying(255),
    date_naissance date,
    genre public.genre_client,
    type_client public.type_client DEFAULT 'Mixte'::public.type_client,
    statut public.statut_client DEFAULT 'Actif'::public.statut_client,
    client_regulier boolean DEFAULT false,
    source_client character varying(50),
    utm_source character varying(50),
    utm_campaign character varying(50),
    referral_code character varying(10),
    parrain_id uuid,
    langue_preferee public.langue_client DEFAULT 'FR'::public.langue_client,
    langue_detectee public.langue_client,
    table_frequente character varying(10),
    heure_livraison_preferee time without time zone,
    jour_commande_habituel character varying(50),
    preferences json,
    abonne_newsletter boolean DEFAULT false,
    optin_sms_promos boolean DEFAULT false,
    communication_frequency_preference public.communication_frequency DEFAULT 'normale'::public.communication_frequency,
    gdpr_consent_date timestamp with time zone,
    remise numeric(5,2) DEFAULT 0.00,
    credit_fidelite numeric(10,2) DEFAULT 0.00,
    vip_depuis date,
    nombre_commandes integer DEFAULT 0,
    montant_total_depense numeric(10,2) DEFAULT 0.00,
    budget_moyen_commande numeric(8,2) GENERATED ALWAYS AS (
CASE
    WHEN (nombre_commandes > 0) THEN (montant_total_depense / (nombre_commandes)::numeric)
    ELSE (0)::numeric
END) STORED,
    dernier_achat_at timestamp with time zone,
    score_satisfaction numeric(3,2) DEFAULT 0.00,
    favorite_category_id uuid,
    avg_order_time time without time zone,
    churn_risk_score numeric(3,2) DEFAULT 0.00,
    lifetime_value numeric(12,2) DEFAULT 0.00,
    seasonal_customer boolean DEFAULT false,
    notes_admin text,
    blacklist_raison text,
    last_interaction_type public.interaction_type,
    social_media_handle character varying(50),
    email_verified boolean DEFAULT false,
    phone_verified boolean DEFAULT false,
    login_attempts_failed integer DEFAULT 0,
    last_password_change timestamp with time zone,
    device_info json,
    ip_creation inet,
    external_ids json,
    sync_status public.sync_status_type DEFAULT 'synced'::public.sync_status_type,
    api_rate_limit_reset timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_by uuid,
    last_login timestamp with time zone,
    deleted_at timestamp with time zone,
    deleted_by uuid,
    CONSTRAINT chk_email_format CHECK (((email IS NULL) OR ((email)::text ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'::text))),
    CONSTRAINT chk_referral_code_format CHECK (((referral_code IS NULL) OR ((referral_code)::text ~ '^[A-Z0-9]{3,10}$'::text))),
    CONSTRAINT customers_churn_risk_score_check CHECK (((churn_risk_score >= (0)::numeric) AND (churn_risk_score <= (1)::numeric))),
    CONSTRAINT customers_credit_fidelite_check CHECK ((credit_fidelite >= (0)::numeric)),
    CONSTRAINT customers_montant_total_depense_check CHECK ((montant_total_depense >= (0)::numeric)),
    CONSTRAINT customers_nombre_commandes_check CHECK ((nombre_commandes >= 0)),
    CONSTRAINT customers_remise_check CHECK (((remise >= (0)::numeric) AND (remise <= (100)::numeric))),
    CONSTRAINT customers_score_satisfaction_check CHECK (((score_satisfaction >= (0)::numeric) AND (score_satisfaction <= (5)::numeric)))
);


ALTER TABLE public.customers OWNER TO sushiwan_admin;

--
-- Name: TABLE customers; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON TABLE public.customers IS 'Table principale des clients SushiWan avec tous les champs avancés CRM/BI';


--
-- Name: COLUMN customers.telephone; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.customers.telephone IS 'Identifiant client interne - Format 216XXXXXXXX (utilisateur saisit 8 chiffres)';


--
-- Name: COLUMN customers.referral_code; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.customers.referral_code IS 'Code de parrainage unique - Business impact: système viral';


--
-- Name: COLUMN customers.budget_moyen_commande; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.customers.budget_moyen_commande IS 'Calculé auto - Critical pour segmentation VIP';


--
-- Name: COLUMN customers.churn_risk_score; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.customers.churn_risk_score IS 'IA prédictive - Actions préventives rétention';


--
-- Name: incidents_kpis_daily; Type: TABLE; Schema: public; Owner: sushiwan_admin
--

CREATE TABLE public.incidents_kpis_daily (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    date_rapport date NOT NULL,
    nombre_incidents_total integer DEFAULT 0,
    nombre_incidents_critiques integer DEFAULT 0,
    nombre_incidents_resolus integer DEFAULT 0,
    nombre_incidents_escalades integer DEFAULT 0,
    temps_resolution_moyen_minutes integer DEFAULT 0,
    pourcentage_sla_respecte numeric(5,2) DEFAULT 0,
    satisfaction_moyenne numeric(3,2) DEFAULT 0,
    cout_total_compensations numeric(10,2) DEFAULT 0,
    cout_incidents_evites numeric(10,2) DEFAULT 0,
    nombre_bons_achat_generes integer DEFAULT 0,
    valeur_totale_bons_achat numeric(10,2) DEFAULT 0,
    incidents_par_type jsonb DEFAULT '{}'::jsonb,
    compensations_par_type jsonb DEFAULT '{}'::jsonb,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.incidents_kpis_daily OWNER TO sushiwan_admin;

--
-- Name: ingredients; Type: TABLE; Schema: public; Owner: sushiwan_admin
--

CREATE TABLE public.ingredients (
    id integer NOT NULL,
    nom_fr character varying(255) NOT NULL,
    nom_en character varying(255),
    nom_tn character varying(255),
    nom_jp character varying(255),
    en_stock boolean DEFAULT true NOT NULL,
    allergene boolean DEFAULT false NOT NULL,
    code_interne character varying(50),
    categorie_ingredient public.enum_ingredients_categorie_ingredient,
    actif boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.ingredients OWNER TO sushiwan_admin;

--
-- Name: ingredients_id_seq; Type: SEQUENCE; Schema: public; Owner: sushiwan_admin
--

CREATE SEQUENCE public.ingredients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ingredients_id_seq OWNER TO sushiwan_admin;

--
-- Name: ingredients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sushiwan_admin
--

ALTER SEQUENCE public.ingredients_id_seq OWNED BY public.ingredients.id;


--
-- Name: order_incidents; Type: TABLE; Schema: public; Owner: sushiwan_admin
--

CREATE TABLE public.order_incidents (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    numero_incident character varying(20) NOT NULL,
    order_id uuid NOT NULL,
    customer_id uuid NOT NULL,
    type_incident public.type_incident_enum NOT NULL,
    priorite public.priorite_incident_enum DEFAULT 'normale'::public.priorite_incident_enum NOT NULL,
    statut public.statut_incident_enum DEFAULT 'ouvert'::public.statut_incident_enum NOT NULL,
    titre character varying(200) NOT NULL,
    description text NOT NULL,
    description_client text,
    sla_minutes integer NOT NULL,
    date_creation timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    date_limite_sla timestamp with time zone NOT NULL,
    date_escalade timestamp with time zone,
    escalade_automatique boolean DEFAULT true,
    notifications_escalade jsonb DEFAULT '[]'::jsonb,
    staff_assigne_id uuid,
    manager_superviseur_id uuid,
    date_assignation timestamp with time zone,
    notes_staff text,
    type_compensation public.type_compensation_enum DEFAULT 'aucune'::public.type_compensation_enum,
    montant_compensation numeric(8,2) DEFAULT 0.00,
    description_compensation text,
    bon_reduction_code character varying(20),
    produit_gratuit_id uuid,
    compensation_appliquee boolean DEFAULT false,
    date_resolution timestamp with time zone,
    temps_resolution_minutes integer,
    solution_appliquee text,
    note_satisfaction integer,
    commentaire_client text,
    communications_log jsonb DEFAULT '[]'::jsonb,
    canaux_communication jsonb DEFAULT '[]'::jsonb,
    client_informe boolean DEFAULT false,
    derniere_communication timestamp with time zone,
    impact_financier numeric(8,2) DEFAULT 0.00,
    origine_detection character varying(50),
    recurrence_incident boolean DEFAULT false,
    produits_affectes jsonb DEFAULT '[]'::jsonb,
    conditions_meteo character varying(50),
    trafic_intense boolean DEFAULT false,
    heure_pointe boolean DEFAULT false,
    contexte_externe text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    resolved_at timestamp with time zone,
    deleted_at timestamp with time zone,
    bon_achat_code character varying(20),
    bon_achat_montant numeric(8,2) DEFAULT 0.00,
    bon_achat_valide_jusqu date,
    bon_achat_utilise boolean DEFAULT false,
    bon_achat_commande_utilisation uuid,
    points_fidelite_attribues integer DEFAULT 0,
    points_fidelite_appliques boolean DEFAULT false,
    bonus_multiplicateur numeric(3,2) DEFAULT 1.00,
    message_compensation text,
    compensation_automatique boolean DEFAULT false,
    approbation_manager_requise boolean DEFAULT false,
    manager_approbation_id uuid,
    date_approbation timestamp with time zone,
    CONSTRAINT check_bon_achat_code_format CHECK (((bon_achat_code IS NULL) OR ((bon_achat_code)::text ~ '^SW-[0-9]{8}-[0-9]{3}$'::text))),
    CONSTRAINT check_bon_achat_coherence CHECK ((((type_compensation = ANY (ARRAY['bon_achat'::public.type_compensation_enum, 'bon_achat_et_points'::public.type_compensation_enum])) AND (bon_achat_code IS NOT NULL) AND (bon_achat_montant > (0)::numeric)) OR (type_compensation <> ALL (ARRAY['bon_achat'::public.type_compensation_enum, 'bon_achat_et_points'::public.type_compensation_enum])))),
    CONSTRAINT check_bon_achat_validite CHECK (((bon_achat_valide_jusqu IS NULL) OR (bon_achat_valide_jusqu >= (CURRENT_DATE + '30 days'::interval)))),
    CONSTRAINT check_compensation_coherence CHECK ((((compensation_appliquee = true) AND (type_compensation <> 'aucune'::public.type_compensation_enum)) OR (compensation_appliquee = false))),
    CONSTRAINT check_impact_financier_positif CHECK ((impact_financier >= 0.00)),
    CONSTRAINT check_montant_compensation_positif CHECK ((montant_compensation >= 0.00)),
    CONSTRAINT check_points_fidelite_coherence CHECK ((((type_compensation = ANY (ARRAY['points_fidelite'::public.type_compensation_enum, 'bon_achat_et_points'::public.type_compensation_enum])) AND (points_fidelite_attribues > 0)) OR (type_compensation <> ALL (ARRAY['points_fidelite'::public.type_compensation_enum, 'bon_achat_et_points'::public.type_compensation_enum])))),
    CONSTRAINT check_resolution_coherence CHECK ((((statut = 'resolu'::public.statut_incident_enum) AND (date_resolution IS NOT NULL) AND (solution_appliquee IS NOT NULL)) OR (statut <> 'resolu'::public.statut_incident_enum))),
    CONSTRAINT check_sla_minutes_positif CHECK ((sla_minutes > 0)),
    CONSTRAINT check_temps_resolution_positif CHECK ((temps_resolution_minutes >= 0)),
    CONSTRAINT order_incidents_note_satisfaction_check CHECK (((note_satisfaction >= 1) AND (note_satisfaction <= 5)))
);


ALTER TABLE public.order_incidents OWNER TO sushiwan_admin;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: sushiwan_admin
--

CREATE TABLE public.orders (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    numero_commande character varying(25) NOT NULL,
    customer_id uuid NOT NULL,
    adresse_livraison_id uuid,
    type_commande public.type_commande_enum DEFAULT 'Livraison'::public.type_commande_enum NOT NULL,
    mode_paiement public.mode_paiement_enum DEFAULT 'Konnect'::public.mode_paiement_enum NOT NULL,
    source_commande public.source_commande_enum DEFAULT 'site_web'::public.source_commande_enum NOT NULL,
    sous_total_ht numeric(10,2) DEFAULT 0.00 NOT NULL,
    tva_montant_total numeric(10,2) DEFAULT 0.00 NOT NULL,
    tva_details jsonb DEFAULT '{}'::jsonb,
    sous_total_ttc numeric(10,2) DEFAULT 0.00 NOT NULL,
    remise_montant numeric(8,2) DEFAULT 0.00 NOT NULL,
    frais_livraison_ht numeric(6,2) DEFAULT 0.00 NOT NULL,
    frais_livraison_tva numeric(6,2) DEFAULT 0.00 NOT NULL,
    frais_livraison_ttc numeric(6,2) DEFAULT 0.00 NOT NULL,
    total_ttc numeric(10,2) DEFAULT 0.00 NOT NULL,
    creneau_souhaite timestamp with time zone,
    creneau_confirme timestamp with time zone,
    temps_preparation_estime integer DEFAULT 30,
    temps_livraison_estime integer DEFAULT 25,
    statut_commande public.statut_commande_enum DEFAULT 'Recu'::public.statut_commande_enum NOT NULL,
    statut_precedent public.statut_commande_enum,
    statut_change_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    payment_id character varying(100),
    transaction_status public.transaction_status_enum DEFAULT 'en_attente'::public.transaction_status_enum NOT NULL,
    payment_method_details jsonb,
    transaction_fee numeric(6,2) DEFAULT 0.00,
    code_promo_utilise character varying(20),
    points_fidelite_utilises integer DEFAULT 0,
    points_fidelite_gagnes integer DEFAULT 0,
    instructions_speciales text,
    note_satisfaction integer,
    commentaire_satisfaction text,
    langue_communication public.langue_client DEFAULT 'FR'::public.langue_client,
    email_confirmation_envoye boolean DEFAULT false,
    sms_confirmation_envoye boolean DEFAULT false,
    notifications_envoyees jsonb DEFAULT '[]'::jsonb,
    incident_en_cours boolean DEFAULT false,
    incident_description text,
    staff_responsable_id uuid,
    table_numero character varying(10),
    session_id uuid,
    utm_source character varying(50),
    utm_campaign character varying(100),
    device_type character varying(20) DEFAULT 'desktop'::character varying,
    ip_address inet,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT livraison_coherence CHECK ((((type_commande = 'Livraison'::public.type_commande_enum) AND (adresse_livraison_id IS NOT NULL)) OR (type_commande <> 'Livraison'::public.type_commande_enum))),
    CONSTRAINT orders_frais_livraison_ht_check CHECK ((frais_livraison_ht >= (0)::numeric)),
    CONSTRAINT orders_frais_livraison_ttc_check CHECK ((frais_livraison_ttc >= (0)::numeric)),
    CONSTRAINT orders_frais_livraison_tva_check CHECK ((frais_livraison_tva >= (0)::numeric)),
    CONSTRAINT orders_note_satisfaction_check CHECK (((note_satisfaction >= 1) AND (note_satisfaction <= 5))),
    CONSTRAINT orders_points_fidelite_gagnes_check CHECK ((points_fidelite_gagnes >= 0)),
    CONSTRAINT orders_points_fidelite_utilises_check CHECK ((points_fidelite_utilises >= 0)),
    CONSTRAINT orders_remise_montant_check CHECK ((remise_montant >= (0)::numeric)),
    CONSTRAINT orders_sous_total_ht_check CHECK ((sous_total_ht >= (0)::numeric)),
    CONSTRAINT orders_sous_total_ttc_check CHECK ((sous_total_ttc >= (0)::numeric)),
    CONSTRAINT orders_temps_livraison_estime_check CHECK ((temps_livraison_estime > 0)),
    CONSTRAINT orders_temps_preparation_estime_check CHECK ((temps_preparation_estime > 0)),
    CONSTRAINT orders_total_ttc_check CHECK ((total_ttc >= (0)::numeric)),
    CONSTRAINT orders_tva_montant_total_check CHECK ((tva_montant_total >= (0)::numeric)),
    CONSTRAINT valid_frais_livraison_tva CHECK ((frais_livraison_ttc = (frais_livraison_ht + frais_livraison_tva))),
    CONSTRAINT valid_total_final CHECK ((total_ttc = ((sous_total_ttc - remise_montant) + frais_livraison_ttc))),
    CONSTRAINT valid_totaux_tva CHECK ((sous_total_ttc = (sous_total_ht + tva_montant_total)))
);


ALTER TABLE public.orders OWNER TO sushiwan_admin;

--
-- Name: TABLE orders; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON TABLE public.orders IS 'Commandes restaurant avec TVA tunisienne, calculs automatiques et intégration Konnect';


--
-- Name: COLUMN orders.numero_commande; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.orders.numero_commande IS 'Format auto: SUSH-AAAAMMJJ-NNNN (ex: SUSH-20240701-0001)';


--
-- Name: COLUMN orders.sous_total_ht; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.orders.sous_total_ht IS 'Calculé depuis prix TTC des produits selon leurs taux TVA';


--
-- Name: COLUMN orders.tva_details; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.orders.tva_details IS 'JSON détaillé: {"19": {"base": 25.50, "tva": 4.85}, "13": {"base": 15.00, "tva": 1.95}}';


--
-- Name: COLUMN orders.total_ttc; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.orders.total_ttc IS 'Auto: sous_total_ttc - remise + frais_livraison_ttc';


--
-- Name: products; Type: TABLE; Schema: public; Owner: sushiwan_admin
--

CREATE TABLE public.products (
    id integer NOT NULL,
    code_interne character varying(50) NOT NULL,
    category_id integer NOT NULL,
    nom_fr character varying(255) NOT NULL,
    nom_en character varying(255),
    nom_tn character varying(255),
    nom_jp character varying(255),
    description_fr text,
    description_en text,
    description_tn text,
    description_jp text,
    description_courte_fr character varying(500),
    description_courte_en character varying(500),
    description_courte_tn character varying(500),
    description_courte_jp character varying(500),
    prix numeric(10,3) NOT NULL,
    nombre_pieces integer,
    stock_gere boolean DEFAULT false NOT NULL,
    stock_quantite integer,
    disponible_sur_place boolean DEFAULT true NOT NULL,
    disponible_emporter boolean DEFAULT true NOT NULL,
    disponible_livraison boolean DEFAULT true NOT NULL,
    temps_preparation integer,
    actif boolean DEFAULT true NOT NULL,
    visible_dans_shop boolean DEFAULT true NOT NULL,
    ordre_affichage integer DEFAULT 0 NOT NULL,
    suggestions boolean DEFAULT false NOT NULL,
    image_url character varying(500),
    slug character varying(300),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    substitutions_personnalisees json,
    taux_tva public.taux_tva_tunisien DEFAULT '19'::public.taux_tva_tunisien NOT NULL,
    prix_ht numeric(10,3)
);


ALTER TABLE public.products OWNER TO sushiwan_admin;

--
-- Name: COLUMN products.id; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.id IS 'Identifiant unique du produit';


--
-- Name: COLUMN products.code_interne; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.code_interne IS 'Code interne unique pour identifier le produit (ex: SUSHI_SALMON_6P)';


--
-- Name: COLUMN products.category_id; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.category_id IS 'ID de la catégorie à laquelle appartient le produit';


--
-- Name: COLUMN products.nom_fr; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.nom_fr IS 'Nom du produit en français (langue de base)';


--
-- Name: COLUMN products.nom_en; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.nom_en IS 'Nom du produit en anglais (auto-traduit si vide)';


--
-- Name: COLUMN products.nom_tn; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.nom_tn IS 'Nom du produit en tunisien (auto-traduit si vide)';


--
-- Name: COLUMN products.nom_jp; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.nom_jp IS 'Nom du produit en japonais (auto-traduit si vide)';


--
-- Name: COLUMN products.description_fr; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.description_fr IS 'Description détaillée du produit en français';


--
-- Name: COLUMN products.description_en; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.description_en IS 'Description détaillée du produit en anglais';


--
-- Name: COLUMN products.description_tn; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.description_tn IS 'Description détaillée du produit en tunisien';


--
-- Name: COLUMN products.description_jp; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.description_jp IS 'Description détaillée du produit en japonais';


--
-- Name: COLUMN products.description_courte_fr; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.description_courte_fr IS 'Description courte du produit en français (pour cartes produit)';


--
-- Name: COLUMN products.description_courte_en; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.description_courte_en IS 'Description courte du produit en anglais';


--
-- Name: COLUMN products.description_courte_tn; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.description_courte_tn IS 'Description courte du produit en tunisien';


--
-- Name: COLUMN products.description_courte_jp; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.description_courte_jp IS 'Description courte du produit en japonais';


--
-- Name: COLUMN products.prix; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.prix IS 'Prix TTC saisi par utilisateur (prix de vente final)';


--
-- Name: COLUMN products.nombre_pieces; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.nombre_pieces IS 'Nombre de pièces dans ce produit (ex: 6 pièces pour un roll)';


--
-- Name: COLUMN products.stock_gere; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.stock_gere IS 'Indique si ce produit est géré en stock ou non';


--
-- Name: COLUMN products.stock_quantite; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.stock_quantite IS 'Quantité en stock (seulement si stock_gere = true)';


--
-- Name: COLUMN products.disponible_sur_place; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.disponible_sur_place IS 'Produit disponible pour consommation sur place';


--
-- Name: COLUMN products.disponible_emporter; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.disponible_emporter IS 'Produit disponible pour emporter';


--
-- Name: COLUMN products.disponible_livraison; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.disponible_livraison IS 'Produit disponible pour livraison';


--
-- Name: COLUMN products.temps_preparation; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.temps_preparation IS 'Temps de préparation en minutes';


--
-- Name: COLUMN products.actif; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.actif IS 'Indique si le produit est actif';


--
-- Name: COLUMN products.visible_dans_shop; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.visible_dans_shop IS 'Indique si le produit est visible dans la boutique en ligne';


--
-- Name: COLUMN products.ordre_affichage; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.ordre_affichage IS 'Ordre d''affichage dans la catégorie (0 = premier)';


--
-- Name: COLUMN products.suggestions; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.suggestions IS 'Indique si ce produit doit être suggéré automatiquement';


--
-- Name: COLUMN products.image_url; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.image_url IS 'URL de l''image principale du produit';


--
-- Name: COLUMN products.slug; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.slug IS 'Slug généré automatiquement pour URLs amicales';


--
-- Name: COLUMN products.substitutions_personnalisees; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.substitutions_personnalisees IS 'Règles de substitution spécifiques à ce produit qui remplacent les règles globales.
Format JSON:
{
  "nom_ingredient": {
    "action": "replace|disable|ignore",
    "replacement_ingredient_id": id_ingredient,
    "price_reduction": montant_decimal,
    "message_fr": "Message français",
    "message_en": "English message", 
    "message_tn": "رسالة عربية",
    "message_jp": "日本語メッセージ"
  }
}
Exemple: {"avocat": {"action": "disable", "message_fr": "Produit indisponible"}}';


--
-- Name: COLUMN products.taux_tva; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.taux_tva IS 'Taux TVA tunisien applicable : 0%, 7%, 13%, 19%';


--
-- Name: COLUMN products.prix_ht; Type: COMMENT; Schema: public; Owner: sushiwan_admin
--

COMMENT ON COLUMN public.products.prix_ht IS 'Prix HT calculé automatiquement depuis prix TTC selon taux TVA';


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: sushiwan_admin
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO sushiwan_admin;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sushiwan_admin
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: regles_approbation_bons; Type: TABLE; Schema: public; Owner: sushiwan_admin
--

CREATE TABLE public.regles_approbation_bons (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    nom_regle character varying(100) NOT NULL,
    origine public.origine_bon_enum NOT NULL,
    type_bon public.type_bon_enum,
    montant_max_auto_approuve numeric(8,2) NOT NULL,
    niveau_staff_requis character varying(20) NOT NULL,
    max_par_client_jour integer DEFAULT 1,
    max_par_client_mois integer DEFAULT 5,
    risk_score_max integer DEFAULT 50,
    actif boolean DEFAULT true,
    priorite integer DEFAULT 10,
    date_debut date DEFAULT CURRENT_DATE,
    date_fin date,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_by uuid,
    notes text,
    CONSTRAINT regles_approbation_bons_niveau_staff_requis_check CHECK (((niveau_staff_requis)::text = ANY ((ARRAY['caissier'::character varying, 'manager'::character varying, 'admin'::character varying, 'directeur'::character varying])::text[])))
);


ALTER TABLE public.regles_approbation_bons OWNER TO sushiwan_admin;

--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: ingredients id; Type: DEFAULT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.ingredients ALTER COLUMN id SET DEFAULT nextval('public.ingredients_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: bons_achat bons_achat_code_bon_key; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.bons_achat
    ADD CONSTRAINT bons_achat_code_bon_key UNIQUE (code_bon);


--
-- Name: bons_achat bons_achat_pkey; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.bons_achat
    ADD CONSTRAINT bons_achat_pkey PRIMARY KEY (id);


--
-- Name: categories categories_code_interne_key; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_code_interne_key UNIQUE (code_interne);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categories categories_slug_key; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_slug_key UNIQUE (slug);


--
-- Name: client_missions client_missions_pkey; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.client_missions
    ADD CONSTRAINT client_missions_pkey PRIMARY KEY (id);


--
-- Name: clients_risk_profile clients_risk_profile_customer_id_key; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.clients_risk_profile
    ADD CONSTRAINT clients_risk_profile_customer_id_key UNIQUE (customer_id);


--
-- Name: clients_risk_profile clients_risk_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.clients_risk_profile
    ADD CONSTRAINT clients_risk_profile_pkey PRIMARY KEY (id);


--
-- Name: customer_addresses customer_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.customer_addresses
    ADD CONSTRAINT customer_addresses_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: customers customers_referral_code_key; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_referral_code_key UNIQUE (referral_code);


--
-- Name: customers customers_telephone_key; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_telephone_key UNIQUE (telephone);


--
-- Name: incidents_kpis_daily incidents_kpis_daily_date_rapport_key; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.incidents_kpis_daily
    ADD CONSTRAINT incidents_kpis_daily_date_rapport_key UNIQUE (date_rapport);


--
-- Name: incidents_kpis_daily incidents_kpis_daily_pkey; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.incidents_kpis_daily
    ADD CONSTRAINT incidents_kpis_daily_pkey PRIMARY KEY (id);


--
-- Name: ingredients ingredients_code_interne_key; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_code_interne_key UNIQUE (code_interne);


--
-- Name: ingredients ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_pkey PRIMARY KEY (id);


--
-- Name: order_incidents order_incidents_numero_incident_key; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.order_incidents
    ADD CONSTRAINT order_incidents_numero_incident_key UNIQUE (numero_incident);


--
-- Name: order_incidents order_incidents_pkey; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.order_incidents
    ADD CONSTRAINT order_incidents_pkey PRIMARY KEY (id);


--
-- Name: orders orders_numero_commande_key; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_numero_commande_key UNIQUE (numero_commande);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_code_interne_key; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_code_interne_key UNIQUE (code_interne);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: products products_slug_key; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_slug_key UNIQUE (slug);


--
-- Name: regles_approbation_bons regles_approbation_bons_pkey; Type: CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.regles_approbation_bons
    ADD CONSTRAINT regles_approbation_bons_pkey PRIMARY KEY (id);


--
-- Name: categories_actif; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX categories_actif ON public.categories USING btree (actif);


--
-- Name: categories_code_interne; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE UNIQUE INDEX categories_code_interne ON public.categories USING btree (code_interne);


--
-- Name: categories_ordre_affichage; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX categories_ordre_affichage ON public.categories USING btree (ordre_affichage);


--
-- Name: categories_slug; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE UNIQUE INDEX categories_slug ON public.categories USING btree (slug);


--
-- Name: idx_addresses_customer_id; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_addresses_customer_id ON public.customer_addresses USING btree (customer_id) WHERE (deleted_at IS NULL);


--
-- Name: idx_addresses_default; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_addresses_default ON public.customer_addresses USING btree (customer_id, adresse_par_defaut) WHERE ((deleted_at IS NULL) AND (adresse_par_defaut = true));


--
-- Name: idx_addresses_gps; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_addresses_gps ON public.customer_addresses USING gist (coordonnees_gps) WHERE ((deleted_at IS NULL) AND (coordonnees_gps IS NOT NULL));


--
-- Name: idx_addresses_type; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_addresses_type ON public.customer_addresses USING btree (type_adresse) WHERE (deleted_at IS NULL);


--
-- Name: idx_addresses_ville; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_addresses_ville ON public.customer_addresses USING btree (ville) WHERE (deleted_at IS NULL);


--
-- Name: idx_addresses_zone_livraison; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_addresses_zone_livraison ON public.customer_addresses USING btree (zone_livraison_id) WHERE (deleted_at IS NULL);


--
-- Name: idx_customers_budget_moyen; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_customers_budget_moyen ON public.customers USING btree (budget_moyen_commande DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_customers_churn_risk; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_customers_churn_risk ON public.customers USING btree (churn_risk_score DESC) WHERE (deleted_at IS NULL);


--
-- Name: idx_customers_date_naissance; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_customers_date_naissance ON public.customers USING btree (date_naissance) WHERE (deleted_at IS NULL);


--
-- Name: idx_customers_email; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_customers_email ON public.customers USING btree (email) WHERE ((deleted_at IS NULL) AND (email IS NOT NULL));


--
-- Name: idx_customers_nom_complet_search; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_customers_nom_complet_search ON public.customers USING gin (to_tsvector('french'::regconfig, (nom_complet)::text)) WHERE (deleted_at IS NULL);


--
-- Name: idx_customers_referral_code; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_customers_referral_code ON public.customers USING btree (referral_code) WHERE ((deleted_at IS NULL) AND (referral_code IS NOT NULL));


--
-- Name: idx_customers_statut; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_customers_statut ON public.customers USING btree (statut) WHERE (deleted_at IS NULL);


--
-- Name: idx_customers_telephone; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE UNIQUE INDEX idx_customers_telephone ON public.customers USING btree (telephone) WHERE (deleted_at IS NULL);


--
-- Name: idx_customers_type_client; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_customers_type_client ON public.customers USING btree (type_client) WHERE (deleted_at IS NULL);


--
-- Name: idx_incidents_kpis_cout; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_incidents_kpis_cout ON public.incidents_kpis_daily USING btree (cout_total_compensations);


--
-- Name: idx_incidents_kpis_date; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_incidents_kpis_date ON public.incidents_kpis_daily USING btree (date_rapport);


--
-- Name: idx_missions_completion; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_missions_completion ON public.client_missions USING btree (date_completion);


--
-- Name: idx_missions_customer; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_missions_customer ON public.client_missions USING btree (customer_id, statut);


--
-- Name: idx_missions_type; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_missions_type ON public.client_missions USING btree (mission_type, statut);


--
-- Name: idx_orders_active; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_orders_active ON public.orders USING btree (statut_commande, created_at) WHERE ((statut_commande = ANY (ARRAY['Recu'::public.statut_commande_enum, 'Confirme'::public.statut_commande_enum, 'Preparation'::public.statut_commande_enum, 'Pret'::public.statut_commande_enum, 'En_route'::public.statut_commande_enum])) AND (deleted_at IS NULL));


--
-- Name: idx_orders_analytics; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_orders_analytics ON public.orders USING btree (created_at, type_commande, statut_commande) WHERE (deleted_at IS NULL);


--
-- Name: idx_orders_customer_status; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_orders_customer_status ON public.orders USING btree (customer_id, statut_commande) WHERE (deleted_at IS NULL);


--
-- Name: idx_orders_livraison; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_orders_livraison ON public.orders USING btree (adresse_livraison_id, statut_commande) WHERE ((type_commande = 'Livraison'::public.type_commande_enum) AND (deleted_at IS NULL));


--
-- Name: idx_orders_numero; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_orders_numero ON public.orders USING btree (numero_commande) WHERE (deleted_at IS NULL);


--
-- Name: idx_orders_payment; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_orders_payment ON public.orders USING btree (payment_id, transaction_status) WHERE (deleted_at IS NULL);


--
-- Name: idx_regles_origine; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_regles_origine ON public.regles_approbation_bons USING btree (origine, actif);


--
-- Name: idx_regles_priorite; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_regles_priorite ON public.regles_approbation_bons USING btree (priorite, actif);


--
-- Name: idx_risk_profile_customer; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_risk_profile_customer ON public.clients_risk_profile USING btree (customer_id);


--
-- Name: idx_risk_profile_flagged; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_risk_profile_flagged ON public.clients_risk_profile USING btree (flagged_for_review);


--
-- Name: idx_risk_profile_score; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX idx_risk_profile_score ON public.clients_risk_profile USING btree (risk_score DESC);


--
-- Name: products_actif; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX products_actif ON public.products USING btree (actif);


--
-- Name: products_category_id; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX products_category_id ON public.products USING btree (category_id);


--
-- Name: products_code_interne; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE UNIQUE INDEX products_code_interne ON public.products USING btree (code_interne);


--
-- Name: products_ordre_affichage; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX products_ordre_affichage ON public.products USING btree (ordre_affichage);


--
-- Name: products_prix; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX products_prix ON public.products USING btree (prix);


--
-- Name: products_slug; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE UNIQUE INDEX products_slug ON public.products USING btree (slug);


--
-- Name: products_stock_gere_stock_quantite; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX products_stock_gere_stock_quantite ON public.products USING btree (stock_gere, stock_quantite);


--
-- Name: products_suggestions; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX products_suggestions ON public.products USING btree (suggestions);


--
-- Name: products_visible_dans_shop; Type: INDEX; Schema: public; Owner: sushiwan_admin
--

CREATE INDEX products_visible_dans_shop ON public.products USING btree (visible_dans_shop);


--
-- Name: customer_addresses trigger_addresses_updated_at; Type: TRIGGER; Schema: public; Owner: sushiwan_admin
--

CREATE TRIGGER trigger_addresses_updated_at BEFORE UPDATE ON public.customer_addresses FOR EACH ROW EXECUTE FUNCTION public.update_addresses_updated_at();


--
-- Name: bons_achat trigger_bons_achat_generation; Type: TRIGGER; Schema: public; Owner: sushiwan_admin
--

CREATE TRIGGER trigger_bons_achat_generation BEFORE INSERT ON public.bons_achat FOR EACH ROW EXECUTE FUNCTION public.trigger_generer_bon_achat();


--
-- Name: bons_achat trigger_bons_achat_updated_at; Type: TRIGGER; Schema: public; Owner: sushiwan_admin
--

CREATE TRIGGER trigger_bons_achat_updated_at BEFORE UPDATE ON public.bons_achat FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: customers trigger_customers_updated_at; Type: TRIGGER; Schema: public; Owner: sushiwan_admin
--

CREATE TRIGGER trigger_customers_updated_at BEFORE UPDATE ON public.customers FOR EACH ROW EXECUTE FUNCTION public.update_customers_updated_at();


--
-- Name: incidents_kpis_daily trigger_kpis_updated_at; Type: TRIGGER; Schema: public; Owner: sushiwan_admin
--

CREATE TRIGGER trigger_kpis_updated_at BEFORE UPDATE ON public.incidents_kpis_daily FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: customers trigger_normalize_telephone; Type: TRIGGER; Schema: public; Owner: sushiwan_admin
--

CREATE TRIGGER trigger_normalize_telephone BEFORE INSERT OR UPDATE ON public.customers FOR EACH ROW EXECUTE FUNCTION public.normalize_telephone_tunisien();


--
-- Name: customer_addresses trigger_normalize_telephone_contact; Type: TRIGGER; Schema: public; Owner: sushiwan_admin
--

CREATE TRIGGER trigger_normalize_telephone_contact BEFORE INSERT OR UPDATE ON public.customer_addresses FOR EACH ROW EXECUTE FUNCTION public.normalize_telephone_contact_adresses();


--
-- Name: orders trigger_orders_calcul_totaux; Type: TRIGGER; Schema: public; Owner: sushiwan_admin
--

CREATE TRIGGER trigger_orders_calcul_totaux BEFORE INSERT OR UPDATE OF sous_total_ht, sous_total_ttc, tva_montant_total, remise_montant, type_commande, adresse_livraison_id ON public.orders FOR EACH ROW EXECUTE FUNCTION public.trigger_calculer_totaux_orders();


--
-- Name: orders trigger_orders_numero_commande; Type: TRIGGER; Schema: public; Owner: sushiwan_admin
--

CREATE TRIGGER trigger_orders_numero_commande BEFORE INSERT ON public.orders FOR EACH ROW EXECUTE FUNCTION public.trigger_set_numero_commande();


--
-- Name: orders trigger_orders_statut_historique; Type: TRIGGER; Schema: public; Owner: sushiwan_admin
--

CREATE TRIGGER trigger_orders_statut_historique BEFORE UPDATE OF statut_commande ON public.orders FOR EACH ROW EXECUTE FUNCTION public.trigger_orders_statut_historique();


--
-- Name: orders trigger_orders_updated_at; Type: TRIGGER; Schema: public; Owner: sushiwan_admin
--

CREATE TRIGGER trigger_orders_updated_at BEFORE UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: order_incidents trigger_ordre_incidents_numero; Type: TRIGGER; Schema: public; Owner: sushiwan_admin
--

CREATE TRIGGER trigger_ordre_incidents_numero BEFORE INSERT ON public.order_incidents FOR EACH ROW EXECUTE FUNCTION public.trigger_generer_numero_incident();


--
-- Name: products trigger_products_prix_ht; Type: TRIGGER; Schema: public; Owner: sushiwan_admin
--

CREATE TRIGGER trigger_products_prix_ht BEFORE INSERT OR UPDATE OF prix, taux_tva ON public.products FOR EACH ROW EXECUTE FUNCTION public.trigger_calculer_prix_ht();


--
-- Name: order_incidents trigger_risk_profile_incidents; Type: TRIGGER; Schema: public; Owner: sushiwan_admin
--

CREATE TRIGGER trigger_risk_profile_incidents AFTER INSERT OR DELETE OR UPDATE ON public.order_incidents FOR EACH ROW EXECUTE FUNCTION public.trigger_update_risk_profile();


--
-- Name: clients_risk_profile trigger_risk_profile_updated_at; Type: TRIGGER; Schema: public; Owner: sushiwan_admin
--

CREATE TRIGGER trigger_risk_profile_updated_at BEFORE UPDATE ON public.clients_risk_profile FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: customer_addresses trigger_single_default_address; Type: TRIGGER; Schema: public; Owner: sushiwan_admin
--

CREATE TRIGGER trigger_single_default_address AFTER INSERT OR UPDATE ON public.customer_addresses FOR EACH ROW EXECUTE FUNCTION public.ensure_single_default_address();


--
-- Name: bons_achat bons_achat_commande_utilisation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.bons_achat
    ADD CONSTRAINT bons_achat_commande_utilisation_id_fkey FOREIGN KEY (commande_utilisation_id) REFERENCES public.orders(id) ON DELETE SET NULL;


--
-- Name: bons_achat bons_achat_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.bons_achat
    ADD CONSTRAINT bons_achat_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE RESTRICT;


--
-- Name: bons_achat bons_achat_incident_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.bons_achat
    ADD CONSTRAINT bons_achat_incident_id_fkey FOREIGN KEY (incident_id) REFERENCES public.order_incidents(id) ON DELETE SET NULL;


--
-- Name: bons_achat bons_achat_produit_gratuit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.bons_achat
    ADD CONSTRAINT bons_achat_produit_gratuit_id_fkey FOREIGN KEY (produit_gratuit_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: client_missions client_missions_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.client_missions
    ADD CONSTRAINT client_missions_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE CASCADE;


--
-- Name: clients_risk_profile clients_risk_profile_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.clients_risk_profile
    ADD CONSTRAINT clients_risk_profile_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE CASCADE;


--
-- Name: customer_addresses customer_addresses_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.customer_addresses
    ADD CONSTRAINT customer_addresses_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE CASCADE;


--
-- Name: customers customers_parrain_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_parrain_id_fkey FOREIGN KEY (parrain_id) REFERENCES public.customers(id);


--
-- Name: order_incidents order_incidents_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.order_incidents
    ADD CONSTRAINT order_incidents_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE RESTRICT;


--
-- Name: order_incidents order_incidents_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.order_incidents
    ADD CONSTRAINT order_incidents_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: orders orders_adresse_livraison_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_adresse_livraison_id_fkey FOREIGN KEY (adresse_livraison_id) REFERENCES public.customer_addresses(id) ON DELETE SET NULL;


--
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE RESTRICT;


--
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sushiwan_admin
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

