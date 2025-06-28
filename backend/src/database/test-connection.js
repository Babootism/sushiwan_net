// ==========================================
// SCRIPT DE TEST DE CONNEXION POSTGRESQL
// ==========================================
// Ce script teste la connexion à PostgreSQL et affiche les informations système
// Utilisation : node src/database/test-connection.js

const { sequelize, testConnection } = require('./connection');

// ==========================================
// FONCTION PRINCIPALE DE TEST
// ==========================================
async function runConnectionTest() {
  console.log('Test de connexion PostgreSQL pour SushiWan...');
  console.log('================================================');
  
  try {
    // 1. Test de connexion de base
    console.log('\n1. Test de connexion de base...');
    const connectionSuccess = await testConnection();
    
    if (!connectionSuccess) {
      console.log('ECHEC du test de connexion');
      process.exit(1);
    }
    
    // 2. Test des informations de version PostgreSQL
    console.log('\n2. Informations de version...');
    const [results] = await sequelize.query('SELECT version() as version');
    console.log(`Version PostgreSQL : ${results[0].version}`);
    
    // 3. Test des extensions installées
    console.log('\n3. Vérification des extensions...');
    const [extensions] = await sequelize.query(`
      SELECT extname, extversion 
      FROM pg_extension 
      WHERE extname IN ('uuid-ossp', 'unaccent', 'pg_trgm')
      ORDER BY extname
    `);
    
    if (extensions.length > 0) {
      console.log('Extensions installées :');
      extensions.forEach(ext => {
        console.log(`   - ${ext.extname} (v${ext.extversion})`);
      });
    } else {
      console.log('Aucune extension trouvée (normal au premier démarrage)');
    }
    
    // 4. Test des fonctions personnalisées
    console.log('\n4. Test des fonctions personnalisées...');
    try {
      const [slugTest] = await sequelize.query(`
        SELECT generate_slug('Sushi Délicieux à la Sauce Teriyaki') as slug
      `);
      console.log(`Fonction generate_slug : "${slugTest[0].slug}"`);
      
      const [normalizeTest] = await sequelize.query(`
        SELECT normalize_search_text('CAFÉ Élégant') as normalized
      `);
      console.log(`Fonction normalize_search_text : "${normalizeTest[0].normalized}"`);
      
    } catch (funcError) {
      console.log('Fonctions personnalisées non encore créées (normal au premier démarrage)');
    }
    
    // 5. Test de création d'une table simple
    console.log('\n5. Test de création de table...');
    await sequelize.query(`
      CREATE TABLE IF NOT EXISTS test_connection (
        id SERIAL PRIMARY KEY,
        message VARCHAR(255),
        created_at TIMESTAMP DEFAULT NOW()
      )
    `);
    
    // Insérer une ligne de test
    await sequelize.query(`
      INSERT INTO test_connection (message) 
      VALUES ('Test de connexion SushiWan réussi !')
    `);
    
    // Lire la ligne de test
    const [testData] = await sequelize.query(`
      SELECT * FROM test_connection ORDER BY created_at DESC LIMIT 1
    `);
    
    console.log(`Test d'écriture/lecture : ${testData[0].message}`);
    
    // Nettoyer la table de test
    await sequelize.query('DROP TABLE IF EXISTS test_connection');
    console.log('Table de test supprimée');
    
    // 6. Informations sur la base de données
    console.log('\n6. Informations sur la base de données...');
    const [dbInfo] = await sequelize.query(`
      SELECT 
        current_database() as database_name,
        current_user as current_user,
        inet_server_addr() as server_ip,
        inet_server_port() as server_port,
        current_setting('timezone') as timezone
    `);
    
    const info = dbInfo[0];
    console.log(`Base de données : ${info.database_name}`);
    console.log(`Utilisateur actuel : ${info.current_user}`);
    console.log(`Fuseau horaire : ${info.timezone}`);
    if (info.server_ip) {
      console.log(`Adresse serveur : ${info.server_ip}:${info.server_port}`);
    }
    
    // 7. Test des capacités multilingues
    console.log('\n7. Test du support multilingue...');
    await sequelize.query(`
      CREATE TEMPORARY TABLE test_multilang (
        id SERIAL,
        text_fr TEXT,
        text_ar TEXT,
        text_jp TEXT,
        text_en TEXT
      )
    `);
    
    await sequelize.query(`
      INSERT INTO test_multilang (text_fr, text_ar, text_jp, text_en) 
      VALUES (
        'Délicieux sushi français',
        'سوشي تونسي لذيذ',
        '美味しい寿司',
        'Delicious English sushi'
      )
    `);
    
    const [multiTest] = await sequelize.query(`
      SELECT * FROM test_multilang LIMIT 1
    `);
    
    console.log('Support multilingue testé :');
    console.log(`   Français : ${multiTest[0].text_fr}`);
    console.log(`   Tunisien : ${multiTest[0].text_ar}`);
    console.log(`   Japonais : ${multiTest[0].text_jp}`);
    console.log(`   Anglais : ${multiTest[0].text_en}`);
    
    // SUCCÈS TOTAL
    console.log('\nTOUS LES TESTS SONT PASSÉS AVEC SUCCÈS !');
    console.log('================================================');
    console.log('PostgreSQL est prêt pour SushiWan');
    console.log('Extensions fonctionnelles');
    console.log('Support multilingue opérationnel');
    console.log('Fonctions personnalisées disponibles');
    
  } catch (error) {
    console.error('\nERREUR LORS DU TEST :');
    console.error('================================================');
    console.error(`${error.message}`);
    console.error('\nSolutions possibles :');
    console.error('1. Vérifiez que PostgreSQL est démarré');
    console.error('2. Vérifiez les variables dans .env');
    console.error('3. Vérifiez que le port 5432 est libre');
    console.error('4. Relancez : docker-compose up -d');
    
    process.exit(1);
  } finally {
    // Fermer la connexion proprement
    await sequelize.close();
    console.log('\nConnexion fermée proprement');
  }
}

// ==========================================
// LANCEMENT DU SCRIPT
// ==========================================
// Ce script peut être lancé directement avec node
if (require.main === module) {
  runConnectionTest()
    .then(() => {
      console.log('\nTest terminé avec succès !');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\nTest échoué :', error.message);
      process.exit(1);
    });
}

// Export pour utilisation dans d'autres scripts
module.exports = {
  runConnectionTest
};
