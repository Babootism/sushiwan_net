// ==========================================
// MODÈLE SEQUELIZE - PRODUCTS
// ==========================================
// Ce modèle gère les produits avec support multilingue et gestion de stock
// Emplacement : /backend/src/models/Product.js

const { DataTypes } = require('sequelize');
const { sequelize } = require('../database/connection');

// ==========================================
// DÉFINITION DU MODÈLE PRODUCT
// ==========================================
const Product = sequelize.define('Product', {
  // ==========================================
  // CHAMP IDENTIFIANT PRINCIPAL
  // ==========================================
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
    comment: 'Identifiant unique du produit'
  },

  // ==========================================
  // CODE INTERNE UNIQUE
  // ==========================================
  code_interne: {
    type: DataTypes.STRING(50),
    allowNull: false,
    unique: true,
    validate: {
      notEmpty: true,
      len: [2, 50],
      is: /^[A-Z0-9_]+$/i
    },
    comment: 'Code interne unique pour identifier le produit (ex: SUSHI_SALMON_6P)'
  },

  // ==========================================
  // RELATION AVEC CATÉGORIE
  // ==========================================
  category_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: 'categories',              // Référence à la table categories
      key: 'id'
    },
    onUpdate: 'CASCADE',               // Mise à jour en cascade
    onDelete: 'RESTRICT',              // Empêche la suppression si produits associés
    validate: {
      notNull: true,
      isInt: true,
      min: 1
    },
    comment: 'ID de la catégorie à laquelle appartient le produit'
  },

  // ==========================================
  // CHAMPS MULTILINGUES - NOMS
  // ==========================================
  nom_fr: {
    type: DataTypes.STRING(255),
    allowNull: false,
    validate: {
      notEmpty: true,
      len: [1, 255]
    },
    comment: 'Nom du produit en français (langue de base)'
  },

  nom_en: {
    type: DataTypes.STRING(255),
    allowNull: true,
    validate: {
      len: [0, 255]
    },
    comment: 'Nom du produit en anglais (auto-traduit si vide)'
  },

  nom_tn: {
    type: DataTypes.STRING(255),
    allowNull: true,
    validate: {
      len: [0, 255]
    },
    comment: 'Nom du produit en tunisien (auto-traduit si vide)'
  },

  nom_jp: {
    type: DataTypes.STRING(255),
    allowNull: true,
    validate: {
      len: [0, 255]
    },
    comment: 'Nom du produit en japonais (auto-traduit si vide)'
  },

  // ==========================================
  // CHAMPS MULTILINGUES - DESCRIPTIONS LONGUES
  // ==========================================
  description_fr: {
    type: DataTypes.TEXT,
    allowNull: true,
    comment: 'Description détaillée du produit en français'
  },

  description_en: {
    type: DataTypes.TEXT,
    allowNull: true,
    comment: 'Description détaillée du produit en anglais'
  },

  description_tn: {
    type: DataTypes.TEXT,
    allowNull: true,
    comment: 'Description détaillée du produit en tunisien'
  },

  description_jp: {
    type: DataTypes.TEXT,
    allowNull: true,
    comment: 'Description détaillée du produit en japonais'
  },

  // ==========================================
  // CHAMPS MULTILINGUES - DESCRIPTIONS COURTES
  // ==========================================
  description_courte_fr: {
    type: DataTypes.STRING(500),
    allowNull: true,
    validate: {
      len: [0, 500]
    },
    comment: 'Description courte du produit en français (pour cartes produit)'
  },

  description_courte_en: {
    type: DataTypes.STRING(500),
    allowNull: true,
    validate: {
      len: [0, 500]
    },
    comment: 'Description courte du produit en anglais'
  },

  description_courte_tn: {
    type: DataTypes.STRING(500),
    allowNull: true,
    validate: {
      len: [0, 500]
    },
    comment: 'Description courte du produit en tunisien'
  },

  description_courte_jp: {
    type: DataTypes.STRING(500),
    allowNull: true,
    validate: {
      len: [0, 500]
    },
    comment: 'Description courte du produit en japonais'
  },

  // ==========================================
  // INFORMATIONS PRIX ET QUANTITÉ
  // ==========================================
  prix: {
    type: DataTypes.DECIMAL(10, 3),    // Précision 3 décimales pour TND (millimes)
    allowNull: false,
    validate: {
      min: 0,                          // Prix ne peut pas être négatif
      isDecimal: true
    },
    comment: 'Prix du produit en TND (Dinars Tunisiens)'
  },

  nombre_pieces: {
    type: DataTypes.INTEGER,
    allowNull: true,
    validate: {
      min: 1                          // Au moins 1 pièce si renseigné
    },
    comment: 'Nombre de pièces dans ce produit (ex: 6 pièces pour un roll)'
  },

  // ==========================================
  // GESTION DE STOCK
  // ==========================================
  stock_gere: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    comment: 'Indique si ce produit est géré en stock ou non'
  },

  stock_quantite: {
    type: DataTypes.INTEGER,
    allowNull: true,
    validate: {
      min: 0                          // Stock ne peut pas être négatif
    },
    comment: 'Quantité en stock (seulement si stock_gere = true)'
  },

  // ==========================================
  // DISPONIBILITÉ PAR TYPE DE SERVICE
  // ==========================================
  disponible_sur_place: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: true,
    comment: 'Produit disponible pour consommation sur place'
  },

  disponible_emporter: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: true,
    comment: 'Produit disponible pour emporter'
  },

  disponible_livraison: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: true,
    comment: 'Produit disponible pour livraison'
  },

  // ==========================================
  // INFORMATIONS DE PRÉPARATION
  // ==========================================
  temps_preparation: {
    type: DataTypes.INTEGER,
    allowNull: true,
    validate: {
      min: 0,                         // Temps ne peut pas être négatif
      max: 180                        // Maximum 3 heures (en minutes)
    },
    comment: 'Temps de préparation en minutes'
  },

  // ==========================================
  // CHAMPS DE GESTION ET VISIBILITÉ
  // ==========================================
  actif: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: true,
    comment: 'Indique si le produit est actif'
  },

  visible_dans_shop: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: true,
    comment: 'Indique si le produit est visible dans la boutique en ligne'
  },

  ordre_affichage: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 0,
    validate: {
      min: 0
    },
    comment: 'Ordre d\'affichage dans la catégorie (0 = premier)'
  },

  // ==========================================
  // SYSTÈME DE SUGGESTIONS
  // ==========================================
  suggestions: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    comment: 'Indique si ce produit doit être suggéré automatiquement'
  },

  // ==========================================
  // CHAMP IMAGE
  // ==========================================
  image_url: {
    type: DataTypes.STRING(500),
    allowNull: true,
    validate: {
      isUrl: true
    },
    comment: 'URL de l\'image principale du produit'
  },

  // ==========================================
  // CHAMP SLUG AUTOMATIQUE
  // ==========================================
  slug: {
    type: DataTypes.STRING(300),
    allowNull: true,
    unique: true,
    validate: {
      is: /^[a-z0-9-]+$/
    },
    comment: 'Slug généré automatiquement pour URLs amicales'
  }

}, {
  // ==========================================
  // OPTIONS DU MODÈLE SEQUELIZE
  // ==========================================
  tableName: 'products',
  timestamps: true,
  underscored: true,
  paranoid: false,
  
  // Index pour optimiser les performances
  indexes: [
    {
      unique: true,
      fields: ['code_interne']
    },
    {
      unique: true,
      fields: ['slug']
    },
    {
      fields: ['category_id']
    },
    {
      fields: ['actif']
    },
    {
      fields: ['visible_dans_shop']
    },
    {
      fields: ['prix']
    },
    {
      fields: ['ordre_affichage']
    },
    {
      fields: ['suggestions']
    },
    {
      fields: ['stock_gere', 'stock_quantite']
    }
  ],

  // ==========================================
  // HOOKS SEQUELIZE
  // ==========================================
  hooks: {
    beforeCreate: async (product, options) => {
      console.log('🔄 Création d\'un nouveau produit:', product.nom_fr);
      
      // Génération automatique du slug
      if (!product.slug && product.nom_fr) {
        product.slug = await Product.generateSlug(product.nom_fr);
        console.log('📝 Slug généré:', product.slug);
      }
      
      // Auto-traduction des noms (simulation)
      if (!product.nom_en && product.nom_fr) {
        product.nom_en = product.nom_fr;
      }
      
      // Validation du stock
      if (product.stock_gere && product.stock_quantite === null) {
        product.stock_quantite = 0;
        console.log('📦 Stock initialisé à 0 pour produit géré en stock');
      }
    },

    beforeUpdate: async (product, options) => {
      console.log('🔄 Mise à jour du produit:', product.id);
      
      // Régénération du slug si nécessaire
      if (product.changed('nom_fr') && product.nom_fr) {
        product.slug = await Product.generateSlug(product.nom_fr, product.id);
      }
      
      // Gestion du stock
      if (product.changed('stock_gere')) {
        if (!product.stock_gere) {
          product.stock_quantite = null;
          console.log('📦 Stock supprimé (produit non géré en stock)');
        } else if (product.stock_quantite === null) {
          product.stock_quantite = 0;
          console.log('📦 Stock initialisé à 0');
        }
      }
    },

    afterCreate: async (product, options) => {
      console.log('✅ Produit créé avec succès:', {
        id: product.id,
        code: product.code_interne,
        nom: product.nom_fr,
        prix: product.prix,
        category_id: product.category_id
      });
    }
  }
});

// ==========================================
// MÉTHODES STATIQUES DU MODÈLE
// ==========================================

// Génération automatique de slug unique
Product.generateSlug = async function(text, excludeId = null) {
  console.log('🔧 Génération de slug produit pour:', text);
  
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
  
  while (true) {
    const existingProduct = await Product.findOne({
      where: {
        slug: finalSlug,
        ...(excludeId && { id: { [sequelize.Op.ne]: excludeId } })
      }
    });
    
    if (!existingProduct) break;
    
    finalSlug = `${baseSlug}-${counter}`;
    counter++;
  }
  
  console.log('✅ Slug produit final:', finalSlug);
  return finalSlug;
};

// Récupération des produits d'une catégorie
Product.getByCategory = async function(categoryId, language = 'fr', options = {}) {
  console.log('📋 Récupération des produits de la catégorie:', categoryId);
  
  const where = {
    category_id: categoryId,
    actif: true,
    visible_dans_shop: true
  };
  
  // Filtres optionnels
  if (options.disponible_livraison !== undefined) {
    where.disponible_livraison = options.disponible_livraison;
  }
  
  if (options.disponible_emporter !== undefined) {
    where.disponible_emporter = options.disponible_emporter;
  }
  
  if (options.disponible_sur_place !== undefined) {
    where.disponible_sur_place = options.disponible_sur_place;
  }
  
  const products = await Product.findAll({
    where: where,
    order: [['ordre_affichage', 'ASC'], ['nom_fr', 'ASC']],
    attributes: [
      'id',
      'code_interne',
      `nom_${language}`,
      `description_${language}`,
      `description_courte_${language}`,
      'prix',
      'nombre_pieces',
      'image_url',
      'slug',
      'stock_gere',
      'stock_quantite',
      'temps_preparation',
      'suggestions'
    ]
  });
  
  console.log(`✅ ${products.length} produits récupérés`);
  return products;
};

// Recherche de produits par texte
Product.searchByText = async function(searchText, language = 'fr', options = {}) {
  console.log('🔍 Recherche de produits:', searchText);
  
  let availabilityFilter = '';
  if (options.service_type) {
    switch (options.service_type) {
      case 'livraison':
        availabilityFilter = 'AND disponible_livraison = true';
        break;
      case 'emporter':
        availabilityFilter = 'AND disponible_emporter = true';
        break;
      case 'sur_place':
        availabilityFilter = 'AND disponible_sur_place = true';
        break;
    }
  }
  
  const products = await sequelize.query(`
    SELECT 
      p.id,
      p.code_interne,
      p.nom_${language},
      p.description_courte_${language},
      p.prix,
      p.nombre_pieces,
      p.image_url,
      p.slug,
      p.stock_gere,
      p.stock_quantite,
      search_similarity(p.nom_${language}, :searchText) as similarity
    FROM products p
    WHERE p.actif = true 
      AND p.visible_dans_shop = true
      ${availabilityFilter}
      AND (
        p.nom_${language} ILIKE :searchPattern 
        OR p.description_${language} ILIKE :searchPattern
        OR p.description_courte_${language} ILIKE :searchPattern
        OR search_similarity(p.nom_${language}, :searchText) > 0.3
      )
    ORDER BY similarity DESC, p.ordre_affichage ASC
  `, {
    replacements: {
      searchText: searchText,
      searchPattern: `%${searchText}%`
    },
    type: sequelize.QueryTypes.SELECT
  });
  
  console.log(`🔍 ${products.length} produits trouvés`);
  return products;
};

// Récupération des produits suggérés
Product.getSuggestions = async function(language = 'fr', limit = 6) {
  console.log('💡 Récupération des produits suggérés');
  
  const products = await Product.findAll({
    where: {
      suggestions: true,
      actif: true,
      visible_dans_shop: true
    },
    order: [['ordre_affichage', 'ASC']],
    limit: limit,
    attributes: [
      'id',
      'code_interne',
      `nom_${language}`,
      `description_courte_${language}`,
      'prix',
      'nombre_pieces',
      'image_url',
      'slug'
    ]
  });
  
  console.log(`💡 ${products.length} produits suggérés récupérés`);
  return products;
};

// Vérification de disponibilité stock
Product.checkStock = async function(productId, quantity = 1) {
  console.log('📦 Vérification stock pour produit:', productId, 'quantité:', quantity);
  
  const product = await Product.findByPk(productId, {
    attributes: ['id', 'stock_gere', 'stock_quantite', 'nom_fr']
  });
  
  if (!product) {
    throw new Error('Produit non trouvé');
  }
  
  if (!product.stock_gere) {
    console.log('✅ Produit non géré en stock - disponible');
    return { available: true, stock: null };
  }
  
  const available = product.stock_quantite >= quantity;
  console.log(`📦 Stock: ${product.stock_quantite}, Demandé: ${quantity}, Disponible: 
${available}`);
  
  return {
    available: available,
    stock: product.stock_quantite,
    requested: quantity
  };
};

// ==========================================
// MÉTHODES D'INSTANCE
// ==========================================

// Obtenir le nom dans une langue
Product.prototype.getName = function(language = 'fr') {
  const supportedLanguages = ['fr', 'en', 'tn', 'jp'];
  if (!supportedLanguages.includes(language)) language = 'fr';
  return this[`nom_${language}`] || this.nom_fr;
};

// Obtenir la description dans une langue
Product.prototype.getDescription = function(language = 'fr') {
  const supportedLanguages = ['fr', 'en', 'tn', 'jp'];
  if (!supportedLanguages.includes(language)) language = 'fr';
  return this[`description_${language}`] || this.description_fr;
};

// Obtenir la description courte dans une langue
Product.prototype.getShortDescription = function(language = 'fr') {
  const supportedLanguages = ['fr', 'en', 'tn', 'jp'];
  if (!supportedLanguages.includes(language)) language = 'fr';
  return this[`description_courte_${language}`] || this.description_courte_fr;
};

// Vérifier la disponibilité selon le type de service
Product.prototype.isAvailableFor = function(serviceType) {
  switch (serviceType) {
    case 'sur_place': return this.disponible_sur_place;
    case 'emporter': return this.disponible_emporter;
    case 'livraison': return this.disponible_livraison;
    default: return false;
  }
};

// Formater pour l'API
Product.prototype.toAPI = function(language = 'fr') {
  return {
    id: this.id,
    code: this.code_interne,
    name: this.getName(language),
    description: this.getDescription(language),
    shortDescription: this.getShortDescription(language),
    price: parseFloat(this.prix),
    pieces: this.nombre_pieces,
    image: this.image_url,
    slug: this.slug,
    preparationTime: this.temps_preparation,
    availability: {
      surPlace: this.disponible_sur_place,
      emporter: this.disponible_emporter,
      livraison: this.disponible_livraison
    },
    stock: this.stock_gere ? {
      managed: true,
      quantity: this.stock_quantite
    } : {
      managed: false,
      quantity: null
    },
    suggested: this.suggestions,
    active: this.actif,
    visible: this.visible_dans_shop,
    categoryId: this.category_id,
    createdAt: this.createdAt,
    updatedAt: this.updatedAt
  };
};

module.exports = Product;
