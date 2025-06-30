// ==========================================
// SCRIPT DE SYNCHRONISATION COMPLÈTE
// ==========================================
// Ce script charge tous les modèles Sequelize et synchronise la base de données
// Fichier : backend/sync-models.js

const { sequelize } = require('./src/database/connection');

// ==========================================
// CHARGEMENT DE TOUS LES MODÈLES
// ==========================================
console.log('📦 Chargement des modèles Sequelize...');

// Charger le modèle Category
const Category = require('./src/models/Category');
console.log('✅ Modèle Category chargé');

// Charger le modèle Product  
const Product = require('./src/models/Product');
console.log('✅ Modèle Product chargé');

// Charger le modèle Ingredient
const Ingredient = require('./src/models/Ingredient');
console.log('✅ Modèle Ingredient chargé');

// ==========================================
// CHARGEMENT DES ASSOCIATIONS (RELATIONS)
// ==========================================
console.log('🔗 Chargement des associations...');

// Vérifier s'il y a des fichiers d'associations
const fs = require('fs');
const path = require('path');
const associationsDir = path.join(__dirname, 'src/models/associations');

if (fs.existsSync(associationsDir)) {
  const associationFiles = fs.readdirSync(associationsDir).filter(file => file.endsWith('.js'));
  
  for (const file of associationFiles) {
    try {
      require(path.join(associationsDir, file));
      console.log(`✅ Association ${file} chargée`);
    } catch (error) {
      console.log(`⚠️  Erreur chargement ${file}: ${error.message}`);
    }
  }
} else {
  console.log('ℹ️  Aucun dossier d\'associations trouvé');
}

// ==========================================
// FONCTION DE SYNCHRONISATION PRINCIPALE
// ==========================================
async function syncAllModels() {
  try {
    console.log('\n🔄 Début de la synchronisation...');
    
    // Tester la connexion d'abord
    await sequelize.authenticate();
    console.log('✅ Connexion à la base de données vérifiée');
    
    // Lister tous les modèles chargés
    const modelNames = Object.keys(sequelize.models);
    console.log(`📊 Modèles détectés : ${modelNames.join(', ')}`);
    
    if (modelNames.length === 0) {
      throw new Error('Aucun modèle détecté ! Vérifiez les imports.');
    }
    
    // Synchroniser avec la base de données
    // alter: true = modifie les tables existantes si nécessaire
    // force: false = ne supprime pas les données existantes
    await sequelize.sync({ 
      alter: true,
      force: false
    });
    
    console.log('\n🎉 Synchronisation réussie !');
    console.log(`✅ ${modelNames.length} modèle(s) synchronisé(s)`);
    
    // Afficher les tables créées
    const query = `
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public' 
      AND table_type = 'BASE TABLE'
      ORDER BY table_name;
    `;
    
    const [results] = await sequelize.query(query);
    console.log('\n📋 Tables créées dans la base de données :');
    results.forEach(row => {
      console.log(`  ✅ ${row.table_name}`);
    });
    
    return true;
    
  } catch (error) {
    console.error('\n❌ Erreur lors de la synchronisation :');
    console.error(error.message);
    return false;
  }
}

// ==========================================
// FONCTION DE NETTOYAGE ET FERMETURE
// ==========================================
async function cleanup() {
  try {
    await sequelize.close();
    console.log('\n📴 Connexion fermée proprement');
  } catch (error) {
    console.error('❌ Erreur lors de la fermeture :', error.message);
  }
}

// ==========================================
// EXÉCUTION PRINCIPALE
// ==========================================
async function main() {
  console.log('🚀 Démarrage de la synchronisation des modèles SushiWan\n');
  
  const success = await syncAllModels();
  
  if (success) {
    console.log('\n🎊 Base de données SushiWan prête pour le développement !');
    process.exit(0);
  } else {
    console.log('\n💥 Échec de la synchronisation');
    process.exit(1);
  }
}

// Gestion de l'arrêt propre
process.on('SIGINT', async () => {
  console.log('\n🛑 Arrêt demandé...');
  await cleanup();
  process.exit(0);
});

process.on('SIGTERM', async () => {
  console.log('\n🛑 Arrêt du processus...');
  await cleanup();
  process.exit(0);
});

// Lancer le script si exécuté directement
if (require.main === module) {
  main();
}

module.exports = { syncAllModels, cleanup };
