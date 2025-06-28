// ==========================================
// CONFIGURATION CONNEXION POSTGRESQL
// ==========================================
// Ce fichier configure la connexion à PostgreSQL avec Sequelize
// Sequelize est un ORM qui facilite les interactions avec la DB

const { Sequelize } = require('sequelize');
require('dotenv').config(); // Charger les variables d'environnement

// ==========================================
// CONFIGURATION DE LA CONNEXION
// ==========================================
const sequelize = new Sequelize({
  // Informations de connexion depuis les variables d'environnement
  database: process.env.DB_NAME,      // Nom de la base : sushiwan_db
  username: process.env.DB_USER,      // Utilisateur : sushiwan_admin  
  password: process.env.DB_PASSWORD,  // Mot de passe depuis .env
  host: process.env.DB_HOST,          // Adresse : localhost
  port: process.env.DB_PORT,          // Port : 5432
  
  // Type de base de données
  dialect: 'postgres',
  
  // Configuration du pool de connexions
  pool: {
    max: 20,          // Maximum 20 connexions simultanées
    min: 0,           // Minimum 0 connexions
    acquire: 30000,   // Temps max pour obtenir une connexion (30s)
    idle: 10000       // Temps avant fermeture connexion inactive (10s)
  },
  
  // Configuration des logs
  logging: process.env.NODE_ENV === 'development' ? console.log : false,
  
  // Configuration pour le déploiement (notamment pour OVH)
  dialectOptions: {
    ssl: process.env.NODE_ENV === 'production' ? {
      require: true,
      rejectUnauthorized: false // Pour certains hébergeurs comme OVH
    } : false,
    
    // Fuseau horaire (Tunisie)
    timezone: '+01:00'
  },
  
  // Définir le fuseau horaire pour Sequelize
  timezone: '+01:00',
  
  // Options de performance
  define: {
    // Ajouter automatiquement createdAt et updatedAt
    timestamps: true,
    
    // Nom des colonnes en snake_case (created_at au lieu de createdAt)
    underscored: true,
    
    // Nom des tables en snake_case et pluriel
    freezeTableName: false,
    
    // Caractères autorisés pour les noms
    charset: 'utf8mb4',
    collate: 'utf8mb4_unicode_ci'
  }
});

// ==========================================
// FONCTION DE TEST DE CONNEXION
// ==========================================
const testConnection = async () => {
  try {
    // Tenter la connexion à la base de données
    await sequelize.authenticate();
    console.log('✅ Connexion PostgreSQL établie avec succès !');
    
    // Afficher les informations de connexion (sans le mot de passe)
    console.log(`📊 Base de données : ${process.env.DB_NAME}`);
    console.log(`🏠 Serveur : ${process.env.DB_HOST}:${process.env.DB_PORT}`);
    console.log(`👤 Utilisateur : ${process.env.DB_USER}`);
    
    return true;
  } catch (error) {
    // En cas d'erreur de connexion
    console.error('❌ Impossible de se connecter à PostgreSQL :', error.message);
    console.error('🔍 Vérifiez que :');
    console.error('  - PostgreSQL est démarré (docker-compose up)');
    console.error('  - Les variables .env sont correctes');
    console.error('  - Le port 5432 est disponible');
    
    return false;
  }
};

// ==========================================
// FONCTION DE SYNCHRONISATION DES MODÈLES
// ==========================================
const syncDatabase = async (force = false) => {
  try {
    console.log('🔄 Synchronisation des modèles avec la base de données...');
    
    // Synchroniser tous les modèles avec la DB
    // force: true = DROP et recréer les tables (attention en production !)
    await sequelize.sync({ 
      force: force,
      alter: !force // En mode alter, modifie les tables existantes
    });
    
    console.log('✅ Synchronisation des modèles terminée !');
    return true;
  } catch (error) {
    console.error('❌ Erreur lors de la synchronisation :', error.message);
    return false;
  }
};

// ==========================================
// FONCTION DE FERMETURE PROPRE
// ==========================================
const closeConnection = async () => {
  try {
    await sequelize.close();
    console.log('📴 Connexion PostgreSQL fermée proprement');
  } catch (error) {
    console.error('❌ Erreur lors de la fermeture :', error.message);
  }
};

// ==========================================
// GESTION DE L'ARRÊT PROPRE DU PROCESSUS
// ==========================================
// Fermer la connexion DB quand le processus Node.js s'arrête
process.on('SIGINT', async () => {
  console.log('\n🛑 Arrêt du serveur en cours...');
  await closeConnection();
  process.exit(0);
});

process.on('SIGTERM', async () => {
  console.log('\n🛑 Arrêt du serveur demandé...');
  await closeConnection();
  process.exit(0);
});

// ==========================================
// EXPORT DES FONCTIONS
// ==========================================
module.exports = {
  sequelize,        // Instance Sequelize pour les modèles
  testConnection,   // Fonction de test de connexion
  syncDatabase,     // Fonction de synchronisation
  closeConnection   // Fonction de fermeture
};
