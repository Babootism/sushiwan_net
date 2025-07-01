-- ================================
-- SCRIPT DE DÉPLOIEMENT COMPLET
-- Système de gestion d'incidents et bons d'achat SushiWan
-- ================================

-- 1. Types ENUM
CREATE TYPE type_incident_enum AS ENUM (
    'retard_preparation', 'retard_livraison', 'produit_manquant',
    'erreur_commande', 'probleme_paiement', 'client_absent',
    'adresse_introuvable', 'produit_defectueux', 'allergie_oubliee'
);

CREATE TYPE priorite_incident_enum AS ENUM ('basse', 'normale', 'haute', 'critique');
CREATE TYPE statut_incident_enum AS ENUM ('ouvert', 'en_cours', 'resolu', 'annule', 'escalade');
CREATE TYPE type_compensation_enum AS ENUM (
    'remboursement_partiel', 'remboursement_total', 'bon_reduction',
    'produit_gratuit', 'livraison_gratuite', 'aucune',
    'bon_achat', 'points_fidelite', 'bon_achat_et_points'
);

-- [... AJOUTER LE RESTE DU SCHÉMA ...]
