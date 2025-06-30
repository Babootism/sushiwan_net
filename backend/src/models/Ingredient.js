const { DataTypes } = require('sequelize');
const { sequelize } = require('../database/connection');

const Ingredient = sequelize.define('Ingredient', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  nom_fr: {
    type: DataTypes.STRING(255),
    allowNull: false
  },
  nom_en: {
    type: DataTypes.STRING(255),
    allowNull: true
  },
  nom_tn: {
    type: DataTypes.STRING(255),
    allowNull: true
  },
  nom_jp: {
    type: DataTypes.STRING(255),
    allowNull: true
  },
  en_stock: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: true
  },
  allergene: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false
  },
  code_interne: {
    type: DataTypes.STRING(50),
    allowNull: true,
    unique: true
  },
  categorie_ingredient: {
    type: DataTypes.ENUM,
    values: ['POISSON', 'CRUSTACE', 'VIANDE', 'LEGUME', 'FRUIT', 'SAUCE', 'EPICE', 'CEREALE', 'PRODUIT_LAITIER', 'AUTRE'],
    allowNull: true
  },
  actif: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: true
  }
}, {
  tableName: 'ingredients',
  timestamps: true,
  underscored: true
});

Ingredient.prototype.getName = function(language = 'fr') {
  return this[`nom_${language}`] || this.nom_fr;
};

Ingredient.prototype.toAPI = function(language = 'fr') {
  return {
    id: this.id,
    name: this.getName(language),
    code: this.code_interne,
    category: this.categorie_ingredient,
    inStock: this.en_stock,
    isAllergene: this.allergene,
    active: this.actif
  };
};

module.exports = Ingredient;
