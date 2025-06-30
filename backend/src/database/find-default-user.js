const { Pool } = require('pg');

const configs = [
    { user: 'postgres', password: 'postgres' },
    { user: 'postgres', password: '' },
    { user: 'postgres', password: 'password' },
    { user: 'ilyesbelhaj', password: '' },
    { user: 'admin', password: 'admin' },
];

async function findWorkingUser() {
    console.log('🔍 === RECHERCHE UTILISATEUR PAR DÉFAUT ===');
    
    for (let i = 0; i < configs.length; i++) {
        const config = configs[i];
        console.log(`${i+1}. Test: user="${config.user}", 
password="${config.password || '(vide)'}"`);
        
        const pool = new Pool({
            host: 'localhost',
            port: 5432,
            database: 'postgres',
            user: config.user,
            password: config.password,
            connectionTimeoutMillis: 3000,
        });
        
        try {
            const client = await pool.connect();
            const result = await client.query('SELECT current_user');
            
            console.log(`   ✅ SUCCÈS ! User: 
${result.rows[0].current_user}`);
            
            client.release();
            await pool.end();
            
            return config;
            
        } catch (error) {
            console.log(`   ❌ Échec: ${error.message.split('\n')[0]}`);
            await pool.end();
        }
    }
    
    return null;
}

findWorkingUser().then(config => {
    if (config) {
        console.log('\n🎉 UTILISATEUR TROUVÉ !');
        console.log(`User: ${config.user}, Password: ${config.password || 
'(vide)'}`);
    } else {
        console.log('\n❌ Aucun utilisateur trouvé');
    }
});
