const { Pool } = require('pg');

const configs = [
    { user: 'postgres', password: 'postgres', db: 'postgres', port: 5433 },
    { user: 'postgres', password: 'password', db: 'postgres', port: 5433 },
    { user: 'postgres', password: 'admin', db: 'postgres', port: 5433 },
    { user: 'postgres', password: 'root', db: 'postgres', port: 5433 },
    { user: 'postgres', password: 'postgres', db: 'postgres', port: 5432 }, // Port système
    { user: 'postgres', password: 'password', db: 'postgres', port: 5432 },
    { user: process.env.USER || 'ilyesbelhaj', password: '', db: 'postgres', port: 5432 }, // Utilisateur système
];

async function testConfigs() {
    console.log('🔍 === TEST DIFFÉRENTES CONFIGURATIONS ===');
    
    for (let i = 0; i < configs.length; i++) {
        const config = configs[i];
        console.log(`\n${i+1}. Test: user="${config.user}", password="${config.password || '(vide)'}", port=${config.port}`);
        
        const pool = new Pool({
            host: 'localhost',
            port: config.port,
            database: config.db,
            user: config.user,
            password: config.password,
            connectionTimeoutMillis: 3000, // Timeout rapide
        });
        
        try {
            const client = await pool.connect();
            const result = await client.query('SELECT current_user, version()');
            console.log(`   ✅ SUCCÈS ! Connecté en tant que: ${result.rows[0].current_user}`);
            console.log(`   🗄️ Version: ${result.rows[0].version.split(' ')[0]}`);
            
            // Lister les bases de données
            const databases = await pool.query('SELECT datname FROM pg_database WHERE datistemplate = false');
            console.log('   📊 Bases disponibles:');
            databases.rows.forEach(row => console.log(`     ✅ ${row.datname}`));
            
            client.release();
            await pool.end();
            
            console.log('\n🎉 === CONFIGURATION TROUVÉE ===');
            console.log('Utilisez ces paramètres:');
            console.log(`DB_HOST=localhost`);
            console.log(`DB_PORT=${config.port}`);
            console.log(`DB_USER=${config.user}`);
            console.log(`DB_PASSWORD=${config.password}`);
            console.log(`DB_NAME=${config.db}`);
            
            return config; // Retourner la config qui marche
        } catch (error) {
            console.log(`   ❌ Échec: ${error.message.split('\n')[0]}`);
            await pool.end();
        }
    }
    
    return null;
}

testConfigs().then(workingConfig => {
    if (!workingConfig) {
        console.log('\n⚠️ Aucune configuration ne fonctionne');
        console.log('💡 Solutions possibles:');
        console.log('  1. Installer PostgreSQL: brew install postgresql');
        console.log('  2. Démarrer PostgreSQL: brew services start postgresql');
        console.log('  3. Créer un utilisateur: createuser -s postgres');
    }
});
