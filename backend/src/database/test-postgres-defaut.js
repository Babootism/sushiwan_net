require('dotenv').config();
console.log('🔍 === TEST UTILISATEUR POSTGRES PAR DÉFAUT ===');

const { Pool } = require('pg');

// Test avec utilisateur postgres par défaut
const pool = new Pool({
    host: 'localhost',
    port: 5433,
    database: 'postgres',
    user: 'postgres',
    password: '', // Souvent vide sur macOS
});

async function testPostgresDefault() {
    try {
        console.log('🔗 Test avec user: postgres, password: (vide)');
        const client = await pool.connect();
        const result = await client.query('SELECT current_user, version()');
        
        console.log('✅ CONNEXION RÉUSSIE !');
        console.log(`👤 Utilisateur: ${result.rows[0].current_user}`);
        console.log(`🗄️ Version: ${result.rows[0].version.split(' ')[0]}`);
        
        client.release();
        
        // Lister les bases de données
        const databases = await pool.query('SELECT datname FROM pg_database WHERE datistemplate = false');
        console.log('\n📊 Bases de données disponibles:');
        databases.rows.forEach(row => console.log(`  ✅ ${row.datname}`));
        
        // Lister les utilisateurs
        const users = await pool.query('SELECT usename FROM pg_user');
        console.log('\n👥 Utilisateurs disponibles:');
        users.rows.forEach(row => console.log(`  👤 ${row.usename}`));
        
        return true;
    } catch (error) {
        console.log('❌ ERREUR avec postgres/vide');
        console.log(`🔍 Détail: ${error.message}`);
        return false;
    } finally {
        await pool.end();
    }
}

testPostgresDefault();
