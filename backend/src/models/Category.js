// ==========================================
// MODÈLE SEQUELIZE - CATEGORIES
// ==========================================
// Ce modèle gère les catégories de produits avec support multilingue
// Emplacement : /backend/src/models/Category.js

const { DataTypes } = require('sequelize');
const { sequelize } = require('../database/connection');

// ==========================================
// DÉFINITION DU MODÈLE CATEGORY
// ==========================================
const Category = sequelize.define('Category', {
  // ==========================================
  // CHAMP IDENTIFIANT PRINCIPAL
  // ==========================================
  id: {
    type: DataTypes.INTEGER,           // Type entier pour l'ID
    primaryKey: true,                  // Clé primaire de la table
    autoIncrement: true,               // Auto-incrémentation automatique
    comment: 'Identifiant unique de la catégorie'
  },

  // ==========================================
  // CODE INTERNE UNIQUE
  // ==========================================
  code_interne: {
    type: DataTypes.STRING(50),        // Chaîne de 50 caractères max
    allowNull: false,                  // Champ obligatoire
    unique: true,                      // Valeur unique dans toute la table
    validate: {
      notEmpty: true,                  // Ne peut pas être vide
      len: [2, 50],                    // Longueur entre 2 et 50 caractères
      is: /^[A-Z0-9_]+$/i              // Alphanumeric + underscore seulement
    },
    comment: 'Code interne unique pour identifier la catégorie (ex: SUSHI_MAKI)'
  },

  // ==========================================
  // CHAMPS MULTILINGUES - NOMS
  // ==========================================
  nom_fr: {
    type: DataTypes.STRING(255),       // Nom en français (langue de base)
    allowNull: false,                  // Obligatoire (langue principale)
    validate: {
      notEmpty: true,                  // Ne peut pas être vide
      len: [1, 255]                    // Longueur entre 1 et 255 caractères
    },
    comment: 'Nom de la catégorie en français (langue de base)'
  },

  nom_en: {
    type: DataTypes.STRING(255),       // Nom en anglais
    allowNull: true,                   // Optionnel (auto-traduit si vide)
    validate: {
      len: [0, 255]                    // Longueur max 255 caractères
    },
    comment: 'Nom de la catégorie en anglais (auto-traduit si vide)'
  },

  nom_tn: {
    type: DataTypes.STRING(255),       // Nom en tunisien/arabe
    allowNull: true,                   // Optionnel (auto-traduit si vide)
    validate: {
      len: [0, 255]
    },
    comment: 'Nom de la catégorie en tunisien (auto-traduit si vide)'
  },

  nom_jp: {
    type: DataTypes.STRING(255),       // Nom en japonais
    allowNull: true,                   // Optionnel (auto-traduit si vide)
    validate: {
      len: [0, 255]
    },
    comment: 'Nom de la catégorie en japonais (auto-traduit si vide)'
  },

  // ==========================================
  // CHAMPS MULTILINGUES - DESCRIPTIONS
  // ==========================================
  description_fr: {
    type: DataTypes.TEXT,              // Texte long pour description détaillée
    allowNull: true,                   // Description optionnelle
    comment: 'Description détaillée de la catégorie en français'
  },

  description_en: {
    type: DataTypes.TEXT,              // Description en anglais
    allowNull: true,
    comment: 'Description de la catégorie en anglais'
  },

  description_tn: {
    type: DataTypes.TEXT,              // Description en tunisien
    allowNull: true,
    comment: 'Description de la catégorie en tunisien'
  },

  description_jp: {
    type: DataTypes.TEXT,              // Description en japonais
    allowNull: true,
    comment: 'Description de la catégorie en japonais'
  },

  // ==========================================
  // CHAMP IMAGE
  // ==========================================
  image_url: {
    type: DataTypes.STRING(500),       // URL vers l'image de la catégorie
    allowNull: true,                   // Image optionnelle
    validate: {
      isUrl: true                      // Validation que c'est une URL valide
    },
    comment: 'URL de l\'image représentant la catégorie'
  },

  // ==========================================
  // CHAMPS DE GESTION
  // ==========================================
  ordre_affichage: {
    type: DataTypes.INTEGER,           // Ordre pour trier les catégories
    allowNull: false,                  // Obligatoire pour le tri
    defaultValue: 0,                   // Valeur par défaut : 0
    validate: {
      min: 0                          // Ne peut pas être négatif
    },
    comment: 'Ordre d\'affichage des catégories (0 = premier)'
  },

  actif: {
    type: DataTypes.BOOLEAN,           // Statut actif/inactif
    allowNull: false,                  // Obligatoire
    defaultValue: true,                // Par défaut : actif
    comment: 'Indique si la catégorie est active et visible'
  },

  // ==========================================
  // CHAMP SLUG AUTOMATIQUE
  // ==========================================
  slug: {
    type: DataTypes.STRING(300),       // Slug pour URLs amicales
    allowNull: true,                   // Généré automatiquement
    unique: true,                      // Doit être unique pour les URLs
    validate: {
      is: /^[a-z0-9-]+$/                // Lettres minuscules, chiffres et tirets seulement
    },
    comment: 'Slug généré automatiquement pour URLs amicales (ex: sushi-maki)'
  }

}, {
  // ==========================================
  // OPTIONS DU MODÈLE SEQUELIZE
  // ==========================================
  tableName: 'categories',            // Nom explicite de la table en DB
  timestamps: true,                   // Ajoute createdAt et updatedAt automatiquement
  underscored: true,                  // Utilise snake_case pour les noms de colonnes
  paranoid: false,                    // Pas de soft delete pour les catégories
  
  // Index pour optimiser les performances
  indexes: [
    {
      unique: true,
      fields: ['code_interne']        // Index unique sur le code interne
    },
    {
      unique: true,
      fields: ['slug']                // Index unique sur le slug
    },
    {
      fields: ['actif']               // Index sur le statut actif
    },
    {
      fields: ['ordre_affichage']     // Index sur l'ordre d'affichage
    }
  ],

  // ==========================================
  // HOOKS SEQUELIZE (ÉVÉNEMENTS)
  // ==========================================
  hooks: {
    // Avant la création d'une catégorie
    beforeCreate: async (category, options) => {
      console.log('🔄 Création d\'une nouvelle catégorie:', category.nom_fr);
      
      // Génération automatique du slug si pas fourni
      if (!category.slug && category.nom_fr) {
        category.slug = await Category.generateSlug(category.nom_fr);
        console.log('📝 Slug généré automatiquement:', category.slug);
      }
      
      // Auto-traduction des noms si vides (simulation)
      if (!category.nom_en && category.nom_fr) {
        category.nom_en = category.nom_fr; // Ici, on intégrerait un service de traduction
        console.log('🌍 Nom anglais auto-généré:', category.nom_en);
      }
    },

    // Avant la mise à jour d'une catégorie
    beforeUpdate: async (category, options) => {
      console.log('🔄 Mise à jour de la catégorie:', category.id);
      
      // Régénération du slug si le nom français a changé
      if (category.changed('nom_fr') && category.nom_fr) {
        category.slug = await Category.generateSlug(category.nom_fr, category.id);
        console.log('📝 Slug mis à jour:', category.slug);
      }
    },

    // Après la création (pour logs d'audit)
    afterCreate: async (category, options) => {
      console.log('✅ Catégorie créée avec succès:', {
        id: category.id,
        code: category.code_interne,
        nom: category.nom_fr,
        slug: category.slug
      });
    }
  }
});

// ==========================================
// MÉTHODES STATIQUES DU MODÈLE
// ==========================================

// Génération automatique de slug unique
Category.generateSlug = async function(text, excludeId = null) {
  console.log('🔧 Génération de slug pour:', text);
  
  // Utilise la fonction PostgreSQL generate_slug que nous avons créée
  const [results] = await sequelize.query(
    'SELECT generate_slug(:text) as slug',
    {
      replacements: { text: text },
      type: sequelize.QueryTypes.SELECT
    }
  );
  
  let baseSlug = results[0].slug;
  let finalSlug = baseSlug;
  let counter = 1;
  
  // Vérification d'unicité du slug
  while (true) {
    const existingCategory = await Category.findOne({
      where: {
        slug: finalSlug,
        ...(excludeId && { id: { [sequelize.Op.ne]: excludeId } })
      }
    });
    
    if (!existingCategory) {
      break; // Slug unique trouvé
    }
    
    finalSlug = `${baseSlug}-${counter}`;
    counter++;
  }
  
  console.log('✅ Slug final généré:', finalSlug);
  return finalSlug;
};

// Récupération des catégories actives triées
Category.getActiveCategories = async function(language = 'fr') {
  console.log('📋 Récupération des catégories actives en', language);
  
  const categories = await Category.findAll({
    where: { actif: true },
    order: [['ordre_affichage', 'ASC'], ['nom_fr', 'ASC']],
    attributes: [
      'id',
      'code_interne',
      `nom_${language}`,
      `description_${language}`,
      'image_url',
      'slug',
      'ordre_affichage'
    ]
  });
  
  console.log(`✅ ${categories.length} catégories actives récupérées`);
  return categories;
};

// Recherche de catégories avec texte multilingue
Category.searchByText = async function(searchText, language = 'fr') {
  console.log('🔍 Recherche de catégories:', searchText, 'en', language);
  
  const categories = await sequelize.query(`
    SELECT 
      id,
      code_interne,
      nom_${language},
      description_${language},
      slug,
      search_similarity(nom_${language}, :searchText) as similarity
    FROM categories 
    WHERE actif = true 
      AND (
        nom_${language} ILIKE :searchPattern 
        OR description_${language} ILIKE :searchPattern
        OR search_similarity(nom_${language}, :searchText) > 0.3
      )
    ORDER BY similarity DESC, ordre_affichage ASC
  `, {
    replacements: {
      searchText: searchText,
      searchPattern: `%${searchText}%`
    },
    type: sequelize.QueryTypes.SELECT
  });
  
  console.log(`🔍 ${categories.length} catégories trouvées pour "${searchText}"`);
  return categories;
};

// ==========================================
// MÉTHODES D'INSTANCE
// ==========================================

// Méthode pour obtenir le nom dans une langue donnée
Category.prototype.getName = function(language = 'fr') {
  const supportedLanguages = ['fr', 'en', 'tn', 'jp'];
  
  if (!supportedLanguages.includes(language)) {
    language = 'fr'; // Langue par défaut
  }
  
  return this[`nom_${language}`] || this.nom_fr; // Fallback sur le français
};

// Méthode pour obtenir la description dans une langue donnée
Category.prototype.getDescription = function(language = 'fr') {
  const supportedLanguages = ['fr', 'en', 'tn', 'jp'];
  
  if (!supportedLanguages.includes(language)) {
    language = 'fr';
  }
  
  return this[`description_${language}`] || this.description_fr;
};

// Méthode pour formater la catégorie pour l'API
Category.prototype.toAPI = function(language = 'fr') {
  return {
    id: this.id,
    code: this.code_interne,
    name: this.getName(language),
    description: this.getDescription(language),
    image: this.image_url,
    slug: this.slug,
    order: this.ordre_affichage,
    active: this.actif,
    createdAt: this.createdAt,
    updatedAt: this.updatedAt
  };
};

// ==========================================
// EXPORT DU MODÈLE
// ==========================================
module.exports = Category;
