
# Ou si VS Code est disponible:
code docs/database/DATABASE_COMPLETE_GUIDE.md# 📊 GUIDE COMPLET - BASE DE DONNÉES SUSHIWAN

> **Documentation technique complète pour développement backend**  
> Version: 1.0 | Date: Juillet 2025 | Statut: Production Ready

---

## 📋 Sommaire Exécutif

### **🎯 Architecture Globale**
- **15 Tables** opérationnelles
- **81+ Fonctions** automatiques 
- **25+ Triggers** intelligents
- **27 Types ENUM** Tunisie
- **Architecture Enterprise** prête production

### **🚀 Modules Fonctionnels**
1. **E-Commerce** : Clients, Commandes, Produits, Catalogue
2. **Intelligence Artificielle** : Incidents, Bons, Risk Scoring
3. **Relations** : Ingrédients, Tags, Missions
4. **Analytics** : KPIs, Métriques, Reporting

---

## 🛒 MODULE E-COMMERCE

### **👥 Table: CUSTOMERS**
**Objectif:** Gestion centralisée clients avec profiling automatique

```sql
-- Structure optimisée
CREATE TABLE customers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    telephone VARCHAR(20) NOT NULL UNIQUE, -- Code client = téléphone
    langue_preferee langue_client DEFAULT 'francais',
    statut statut_client DEFAULT 'actif',
    total_commandes INTEGER DEFAULT 0,
    total_depense NUMERIC(12,2) DEFAULT 0,
    derniere_commande TIMESTAMPTZ,
    remise_admin NUMERIC(5,2) DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

**🔄 Automatisations Intégrées:**
- **Normalisation téléphone** : +216XXXXXXXX automatique
- **Profil risque** : Créé automatiquement première commande
- **Mise à jour stats** : total_commandes/total_depense auto

**💡 Utilisation Backend:**
```javascript
// Création client automatique
const client = await Customer.create({
    nom: "Belhaj",
    prenom: "Ilyes", 
    telephone: "29350000", // → +21629350000
    email: "ilyes@sushiwan.tn"
});
// → Trigger: clients_risk_profile créé automatiquement
```

**📊 Métriques Disponibles:**
- Segmentation par dépenses/fréquence
- Analytics comportementaux
- Géolocalisation via adresses

---

### **📍 Table: CUSTOMER_ADDRESSES**
**Objectif:** Multi-adresses par client avec zones livraison

```sql
CREATE TABLE customer_addresses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    customer_id UUID NOT NULL REFERENCES customers(id),
    type_adresse type_adresse DEFAULT 'livraison',
    nom_adresse VARCHAR(100), -- "Maison", "Bureau"
    adresse_complete TEXT NOT NULL,
    ville VARCHAR(100),
    latitude NUMERIC(10,8),
    longitude NUMERIC(11,8),
    instructions_livraison TEXT,
    contact_telephone VARCHAR(20),
    est_par_defaut BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

**🔄 Automatisations:**
- **Unicité défaut** : Une seule adresse par défaut/client
- **Normalisation** : Téléphone contact auto +216
- **Zone détection** : Auto via coordonnées GPS

---

### **🛍️ Table: ORDERS**
**Objectif:** Commandes complètes avec tracking et analytics

```sql
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    numero_commande VARCHAR(20) UNIQUE NOT NULL, -- CMD-YYYYMMDD-NNN
    customer_id UUID NOT NULL REFERENCES customers(id),
    customer_address_id UUID REFERENCES customer_addresses(id),
    
    -- Types et source
    type_commande type_commande_enum NOT NULL, -- sur_place, emporter, livraison
    source_commande source_commande_enum DEFAULT 'site_web',
    
    -- Montants (calculés automatiquement)
    sous_total NUMERIC(10,2) NOT NULL DEFAULT 0,
    frais_livraison NUMERIC(10,2) DEFAULT 0,
    montant_remise NUMERIC(10,2) DEFAULT 0,
    montant_total NUMERIC(10,2) NOT NULL DEFAULT 0,
    
    -- Statut et timing
    statut statut_commande_enum DEFAULT 'en_attente_paiement',
    temps_preparation_estime INTEGER,
    heure_livraison_souhaitee TIMESTAMPTZ,
    
    -- Analytics
    session_id UUID,
    utm_source VARCHAR(100),
    utm_campaign VARCHAR(100),
    device_type VARCHAR(50),
    ip_address INET,
    
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

**🔄 Automatisations Critiques:**
- **Numérotation** : CMD-20250701-001 unique
- **Calculs totaux** : Recalcul auto via order_items
- **Historique statuts** : Tracking complet changements
- **Mise à jour client** : Stats automatiques

---

### **📦 Table: ORDER_ITEMS**
**Objectif:** Articles détaillés avec accompagnements et personnalisations

```sql
CREATE TABLE order_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(id),
    
    -- 🍱 Gestion type produit
    type_article TEXT CHECK (type_article IN ('principal', 'accompagnement', 'supplement')),
    article_parent_id UUID REFERENCES order_items(id),
    
    -- 📊 Quantités et prix
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    prix_unitaire NUMERIC(10,2) NOT NULL,
    sous_total NUMERIC(10,2) NOT NULL,
    
    -- 🌶️ Personnalisations
    niveau_epice TEXT CHECK (niveau_epice IN ('doux', 'moyen', 'fort')),
    instructions_speciales TEXT,
    substitutions_appliquees JSON,
    
    -- ⏱️ Cuisine
    statut_preparation TEXT DEFAULT 'en_attente',
    temps_preparation_estime INTEGER,
    temps_preparation_reel INTEGER,
    
    -- 💰 Finance Tunisie
    taux_tva taux_tva_tunisien NOT NULL DEFAULT '19'::taux_tva_tunisien,
    prix_ht NUMERIC(10,2),
    montant_tva NUMERIC(10,2),
    code_promo_applique VARCHAR(50),
    
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

**🔄 Logique Métier:**
- **Hiérarchie** : Produits principaux + accompagnements liés
- **Recalcul automatique** : Total commande mis à jour
- **Suivi préparation** : Temps réel cuisine

**💡 Exemple Accompagnements:**
```javascript
// Commande: Sushi + Riz + Salade
const items = [
    { type_article: 'principal', product_id: 1, quantity: 8 }, // Sushi
    { 
        type_article: 'accompagnement', 
        product_id: 15, // Riz
        article_parent_id: 'sushi_id',
        quantity: 1 
    }
];
```

---

### **🍱 Table: PRODUCTS**
**Objectif:** Catalogue multilingue avec accompagnements unifiés

```sql
CREATE TABLE products (
    id INTEGER PRIMARY KEY,
    code_interne VARCHAR(50) UNIQUE NOT NULL,
    category_id INTEGER NOT NULL REFERENCES categories(id),
    
    -- 🌍 Multilingue
    nom_fr VARCHAR(255) NOT NULL,
    nom_en VARCHAR(255),
    nom_tn VARCHAR(255),  
    nom_jp VARCHAR(255),
    description_fr TEXT,
    description_en TEXT,
    description_tn TEXT,
    description_jp TEXT,
    
    -- 💰 Pricing
    prix NUMERIC(10,3) NOT NULL,
    prix_accompagnement NUMERIC(10,2), -- Prix si accompagnement
    prix_supplement NUMERIC(10,2),     -- Prix si supplément
    taux_tva taux_tva_tunisien NOT NULL DEFAULT '19'::taux_tva_tunisien,
    prix_ht NUMERIC(10,3),
    
    -- 🏷️ Classification (VOTRE APPROCHE)
    est_accompagnement BOOLEAN DEFAULT false,
    est_supplement BOOLEAN DEFAULT false,
    peut_etre_principal BOOLEAN DEFAULT true,
    
    -- 📦 Stock et disponibilité
    nombre_pieces INTEGER,
    stock_gere BOOLEAN NOT NULL DEFAULT false,
    stock_quantite INTEGER,
    disponible_sur_place BOOLEAN NOT NULL DEFAULT true,
    disponible_emporter BOOLEAN NOT NULL DEFAULT true,
    disponible_livraison BOOLEAN NOT NULL DEFAULT true,
    
    -- ⏱️ Préparation
    temps_preparation INTEGER, -- minutes
    
    -- 🎯 Affichage
    actif BOOLEAN NOT NULL DEFAULT true,
    visible_dans_shop BOOLEAN NOT NULL DEFAULT true,
    ordre_affichage INTEGER NOT NULL DEFAULT 0,
    suggestions BOOLEAN NOT NULL DEFAULT false,
    image_url VARCHAR(500),
    slug VARCHAR(300) UNIQUE,
    
    -- 🔄 Substitutions
    substitutions_personnalisees JSON,
    
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

**🎯 Votre Innovation : Produits Unifiés**
```javascript
// Un même produit peut être principal ET accompagnement
await Product.update({
    est_accompagnement: true,
    peut_etre_principal: true,
    prix_accompagnement: 6.00  // Prix différent si accompagnement
}, { where: { nom_fr: 'Riz Jasmin' }});
```

---

## 🤖 MODULE INTELLIGENCE ARTIFICIELLE

### **⚠️ Table: ORDER_INCIDENTS**
**Objectif:** Gestion automatisée incidents avec IA

```sql
CREATE TABLE order_incidents (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    numero_incident VARCHAR(20) UNIQUE NOT NULL, -- INC-YYYYMMDD-NNN
    order_id UUID REFERENCES orders(id),
    customer_id UUID NOT NULL REFERENCES customers(id),
    
    type_incident type_incident_enum NOT NULL,
    priorite priorite_incident_enum NOT NULL,
    statut statut_incident_enum DEFAULT 'ouvert',
    
    titre VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    resolution TEXT,
    
    -- ⏱️ SLA automatique
    sla_minutes INTEGER NOT NULL,
    date_limite_sla TIMESTAMPTZ NOT NULL,
    temps_resolution_minutes INTEGER,
    
    -- 👥 Assignation
    assigne_a UUID,
    resolu_par UUID,
    
    -- 📊 Metrics
    satisfaction_client INTEGER CHECK (satisfaction_client >= 1 AND satisfaction_client <= 5),
    compensation_accordee BOOLEAN DEFAULT false,
    
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    resolved_at TIMESTAMPTZ
);
```

**🔄 Automatisations IA:**
- **Numérotation** : INC-20250701-001 auto
- **Risk scoring** : Profil client mis à jour automatiquement
- **SLA calcul** : Date limite selon priorité
- **KPIs** : Métriques calculées automatiquement

---

### **🎫 Table: BONS_ACHAT**
**Objectif:** Système intelligent compensations avec auto-approbation

```sql
CREATE TABLE bons_achat (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code_bon VARCHAR(20) UNIQUE NOT NULL, -- SW-YYYYMMDD-NNN
    customer_id UUID NOT NULL REFERENCES customers(id),
    
    origine origine_bon_enum NOT NULL,
    raison_creation VARCHAR(255) NOT NULL,
    
    -- 💰 Types de bons
    type_bon type_bon_enum NOT NULL,
    montant_tnd NUMERIC(10,2),
    remise_pourcentage NUMERIC(5,2),
    produit_gratuit_id INTEGER REFERENCES products(id),
    
    -- 🤖 Auto-approbation IA
    statut_approbation statut_approbation_enum DEFAULT 'en_attente',
    approuve_par UUID,
    approuve_automatiquement BOOLEAN DEFAULT false,
    regle_approbation_appliquee UUID REFERENCES regles_approbation_bons(id),
    
    -- ⏰ Validité
    date_expiration DATE NOT NULL,
    utilise BOOLEAN DEFAULT false,
    date_utilisation TIMESTAMPTZ,
    commande_utilisation UUID REFERENCES orders(id),
    
    -- 📊 Tracking
    demandeur_staff_id UUID,
    justification_demande TEXT,
    points_utilises INTEGER,
    
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

**🤖 Auto-Approbation Intelligente:**
```sql
-- Fonction automatique d'approbation
SELECT auto_approve_bon_achat('bon-uuid');
-- → Évalue selon règles configurables
-- → Vérifie risk_score client
-- → Auto-approuve si éligible
```

---

### **🎯 Table: CLIENTS_RISK_PROFILE**
**Objectif:** Scoring de risque automatique 0-100

```sql
CREATE TABLE clients_risk_profile (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    customer_id UUID UNIQUE NOT NULL REFERENCES customers(id),
    
    -- 📊 Risk Scoring (0-100)
    risk_score INTEGER NOT NULL DEFAULT 0 CHECK (risk_score >= 0 AND risk_score <= 100),
    risk_level VARCHAR(20) NOT NULL DEFAULT 'bas',
    
    -- 📈 Métriques 30 jours
    nombre_incidents_30j INTEGER DEFAULT 0,
    nombre_compensations_30j INTEGER DEFAULT 0,
    montant_compensations_30j NUMERIC(10,2) DEFAULT 0,
    nombre_commandes_30j INTEGER DEFAULT 0,
    montant_commandes_30j NUMERIC(10,2) DEFAULT 0,
    
    -- ⚠️ Flags automatiques
    flagged_for_review BOOLEAN DEFAULT false,
    raison_flagging TEXT,
    
    -- 📅 Historique
    derniere_analyse TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

**🔄 Calcul Automatique Risk Score:**
```sql
-- Mise à jour automatique via triggers
-- Facteurs: fréquence incidents, montants compensations, historique
SELECT calcul_risk_score('customer-uuid');
-- → Retourne score 0-100 basé sur algorithme
```

---

## 🔗 MODULE RELATIONS & TAGS

### **🌿 Table: PRODUCT_INGREDIENTS**
**Objectif:** Relations produits-ingrédients avec substitutions

```sql
CREATE TABLE product_ingredients (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id INTEGER NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    ingredient_id INTEGER NOT NULL REFERENCES ingredients(id) ON DELETE CASCADE,
    
    -- 📊 Quantité et coût
    quantite NUMERIC(8,3) NOT NULL CHECK (quantite > 0),
    unite VARCHAR(20) NOT NULL, -- g, ml, pièce
    cout_unitaire NUMERIC(8,3),
    
    -- 🎯 Classification
    groupe_ingredient VARCHAR(50), -- base, sauce, garniture
    criticite TEXT CHECK (criticite IN ('obligatoire', 'optionnel', 'personnalisable')),
    ordre_affichage INTEGER DEFAULT 0,
    
    -- ⚠️ Gestion allergènes et stock
    allergene BOOLEAN NOT NULL DEFAULT false,
    seuil_alerte_stock INTEGER,
    fournisseur_principal VARCHAR(100),
    
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(product_id, ingredient_id)
);
```

**🔄 Substitutions Intelligentes:**
```sql
-- Fonction existante de substitution
SELECT verifier_substitution_produit(product_id, 'ingredient_en_rupture');
-- → Retourne alternatives automatiques
-- → Calcul impact prix
-- → Messages client multilingues
```

---

### **🏷️ Table: PRODUCT_TAGS**
**Objectif:** Étiquettes multilingues avec règles automatiques

```sql
CREATE TABLE product_tags (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id INTEGER NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    
    -- 🌍 Multilingue
    tag_name VARCHAR(50) NOT NULL,
    display_text_fr VARCHAR(100),
    display_text_en VARCHAR(100),
    display_text_tn VARCHAR(100),
    display_text_jp VARCHAR(100),
    
    -- 🎨 Apparence
    tag_color VARCHAR(7) DEFAULT '#FF0000',
    css_class VARCHAR(50),
    icon_name VARCHAR(50),
    priority INTEGER DEFAULT 0,
    
    -- ⚡ Règles automatiques
    regle_auto_attribution JSON,
    -- Exemple: {"type": "nouveau", "duree_jours": 30}
    conditions_affichage JSON,
    -- Exemple: {"heures": ["19:00-22:00"]}
    
    -- 📊 Analytics
    nb_clics INTEGER DEFAULT 0,
    nb_conversions INTEGER DEFAULT 0,
    
    -- 🕒 Validité
    active BOOLEAN NOT NULL DEFAULT true,
    expires_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    UNIQUE(product_id, tag_name)
);
```

**⚡ Attribution Automatique:**
```javascript
// Tags automatiques selon règles
const tagRules = {
    "nouveau": { duree_jours: 30 },
    "bestseller": { min_commandes_mois: 50 },
    "promo": { condition: "reduction > 15%" }
};
```

---

## 📊 MODULE ANALYTICS & KPIs

### **📈 Table: INCIDENTS_KPIS_DAILY**
**Objectif:** KPIs automatiques calculés quotidiennement

```sql
CREATE TABLE incidents_kpis_daily (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    date_rapport DATE NOT NULL UNIQUE,
    
    -- 📊 Métriques incidents
    nombre_incidents_total INTEGER DEFAULT 0,
    nombre_incidents_critiques INTEGER DEFAULT 0,
    temps_resolution_moyen_minutes NUMERIC(8,2),
    pourcentage_sla_respecte NUMERIC(5,2),
    
    -- 💰 Métriques financières
    cout_total_compensations NUMERIC(10,2) DEFAULT 0,
    nombre_bons_generes INTEGER DEFAULT 0,
    nombre_bons_auto_approuves INTEGER DEFAULT 0,
    
    -- 😊 Satisfaction
    satisfaction_moyenne NUMERIC(3,2),
    nombre_evaluations INTEGER DEFAULT 0,
    
    -- 📋 Détails JSON
    incidents_par_type JSON,
    compensations_par_type JSON,
    
    -- 🔄 Métadonnées
    calcule_automatiquement BOOLEAN DEFAULT true,
    derniere_mise_a_jour TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

**🔄 Calcul Automatique Quotidien:**
```sql
-- Fonction automatique minuit
SELECT calculate_daily_kpis('2025-07-01');
-- → Analyse tous les incidents du jour
-- → Calcule métriques performance
-- → Stocke résultats pour reporting
```

---

## 🔧 FONCTIONS AUTOMATIQUES CLÉS

### **🎯 1. Calcul Risk Score**
```sql
-- Calcul intelligent score risque 0-100
SELECT calcul_risk_score('customer-uuid');
-- Facteurs:
-- - Fréquence incidents (30j)
-- - Montant compensations (30j) 
-- - Ratio incidents/commandes
-- - Ancienneté client
-- - Patterns comportementaux
```

### **🎫 2. Auto-Approbation Bons**
```sql
-- Évaluation automatique selon règles
SELECT auto_approve_bon_achat('bon-uuid');
-- Logique:
-- - Vérifie montant vs limites
-- - Check risk_score client
-- - Valide fréquence demandes
-- - Applique règles par origine
```

### **🔢 3. Génération Numéros**
```sql
-- Numérotation automatique unique
-- CMD-20250701-001 (commandes)
-- INC-20250701-001 (incidents)  
-- SW-20250701-001 (bons)
```

### **💰 4. Calculs Financiers**
```sql
-- Calculs automatiques TVA tunisienne
-- Prix HT → Prix TTC (19%, 13%, 7%, 0%)
-- Totaux commandes mise à jour auto
-- Frais livraison selon zones
```

---

## 💻 GUIDELINES DÉVELOPPEMENT BACKEND

### **🎯 Modèles Sequelize Recommandés**

```javascript
// Exemple modèle Order avec relations
const Order = sequelize.define('Order', {
    id: { type: DataTypes.UUID, primaryKey: true, defaultValue: DataTypes.UUIDV4 },
    numero_commande: { type: DataTypes.STRING, unique: true },
    sous_total: { type: DataTypes.DECIMAL(10,2), defaultValue: 0 },
    statut: { type: DataTypes.ENUM, values: ['en_attente_paiement', 'confirmee', 'en_preparation'] }
}, {
    hooks: {
        // Numérotation automatique (optionnel, déjà en DB)
        beforeCreate: async (order) => {
            if (!order.numero_commande) {
                order.numero_commande = await generateOrderNumber();
            }
        }
    }
});

// Relations
Order.belongsTo(Customer);
Order.hasMany(OrderItem);
Order.belongsTo(CustomerAddress);
```

### **🔄 Triggers vs Code Backend**

**✅ Laissez en DB (Triggers) :**
- Numérotation automatique
- Calculs risk_score  
- Mise à jour totaux commandes
- Normalisation téléphones

**✅ Gérez en Backend :**
- Validation métier complexe
- Logique business rules
- Intégrations externes
- Gestion erreurs utilisateur

### **📊 Requêtes Optimisées Recommandées**

```javascript
// Commandes avec détails (optimisé)
const commandesAvecDetails = await Order.findAll({
    include: [
        { model: Customer, attributes: ['nom', 'prenom', 'telephone'] },
        { model: OrderItem, include: [{ model: Product, attributes: ['nom_fr', 'prix'] }] },
        { model: CustomerAddress, attributes: ['adresse_complete', 'ville'] }
    ],
    where: { statut: 'en_preparation' },
    order: [['created_at', 'DESC']]
});

// KPIs dashboard (optimisé)
const kpisJour = await IncidentsKpisDaily.findOne({
    where: { date_rapport: moment().format('YYYY-MM-DD') }
});
```

---

## ⚠️ POINTS D'ATTENTION DÉVELOPPEMENT

### **🔐 Sécurité**
- **Jamais d'UUID prévisibles** : Utiliser uuid_generate_v4()
- **Validation côté serveur** : Double validation DB + backend
- **Sanitisation** : Toujours échapper JSON et TEXT fields
- **Rate limiting** : API endpoints sensibles (création clients)

### **⚡ Performance**
- **Index utilisés** : 35+ index déjà optimisés
- **Requêtes N+1** : Attention aux relations multiples
- **Pagination** : Obligatoire pour listes (customers, orders)
- **Cache** : Redis pour KPIs et données fréquentes

### **🔄 Maintenance**
- **Migrations** : Toujours versionnées et testées
- **Backup** : Données critiques incidents/bons
- **Monitoring** : Alertes sur échecs triggers
- **Logs** : Traçabilité modifications importantes

---

## 🎯 PROCHAINES ÉTAPES RECOMMANDÉES

### **📋 Phase 1 : Tables Complémentaires**
1. **payment_transactions** (Konnect)
2. **users** (Staff back-office)  
3. **delivery_zones** (Frais livraison)

### **💻 Phase 2 : Backend API**
1. Modèles Sequelize pour 15 tables
2. Routes CRUD principales  
3. Middleware authentification
4. Tests automatisés

### **🔗 Phase 3 : Intégrations**
1. API Konnect paiements
2. Dashboard KPIs temps réel
3. Système notifications
4. Frontend Next.js

---

## 📞 SUPPORT & MAINTENANCE

**📧 Contact Technique:** Équipe SushiWan Dev  
**📍 Base de données:** PostgreSQL 15 - Container: sushiwan-postgres  
**🔧 Outils:** pgAdmin, DBeaver recommandés  
**📖 Documentation:** Mise à jour continue selon évolutions

---

*Cette documentation constitue la référence technique complète pour le développement backend SushiWan. Toute modification de structure doit être documentée et validée.*
