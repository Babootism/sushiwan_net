require('dotenv').config();
console.log('🔍 === DIAGNOSTIC SUSHIWAN ===');
console.log(`📍 Port utilisé: ${process.env.DB_PORT}`);

const { Pool } = require('pg');
const pool = new Pool({
    host: process.env.DB_HOST || 'localhost',
    port: process.env.DB_PORT || 5433,
    database: process.env.DB_NAME || 'sushiwan_db',
    user: process.env.DB_USER || 'sushiwan_admin',
    password: process.env.DB_PASSWORD || 'SushiWan2024!',
});

async function test() {
    try {
        console.log('🔗 Tentative de connexion...');
        const client = await pool.connect();
        const result = await client.query('SELECT NOW() as now, version() as version');
        
        console.log('✅ CONNEXION RÉUSSIE !');
        console.log(`⏰ Heure: ${result.rows[0].now}`);
        console.log(`🗄️ Version: ${result.rows[0].version.split(' ')[0]}`);
        
        client.release();
        
        const tables = await pool.query("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' ORDER BY table_name");
        console.log(`📊 Tables trouvées: ${tables.rows.length}`);
        
        if (tables.rows.length > 0) {
            tables.rows.forEach(row => console.log(`  ✅ ${row.table_name}`));
        } else {
            console.log('  ℹ️ Aucune table (base vide - c\'est normal)');
        }
        
        return true;
    } catch (error) {
        console.log('❌ ERREUR DE CONNEXION');
        console.log(`🔍 Détail: ${error.message}`);
        
        if (error.message.includes('ECONNREFUSED')) {
            console.log('💡 PostgreSQL n\'est pas démarré sur le port ' + (process.env.DB_PORT || 5433));
        }
        if (error.message.includes('password authentication failed')) {
            console.log('💡 Problème d\'authentification');
        }
        
        return false;
    } finally {
        await pool.end();
    }
}

test().then(success => {
    console.log('');
    if (success) {
        console.log('🎉 === DIAGNOSTIC RÉUSSI ===');
        console.log('👉 PostgreSQL est opérationnel !');
        console.log('👉 Vous pouvez maintenant créer vos tables');
    } else {
        console.log('⚠️ === DIAGNOSTIC ÉCHOUÉ ===');
        console.log('👉 Vérifiez que Docker PostgreSQL est démarré');
    }
});
