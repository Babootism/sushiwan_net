require('dotenv').config();
console.log('🔍 === TEST AVEC VOS VRAIES DONNÉES ===');

const { Pool } = require('pg');

const pool = new Pool({
    host: 'localhost',
    port: 5432,
    database: 'sushiwan_db',
    user: 'sushiwan_admin',
    password: 'SushiWan2024!',
});

async function testVraiConnection() {
    try {
        console.log('🔗 Test avec vos paramètres habituels...');
        console.log('   Host: localhost:5432');
        console.log('   User: sushiwan_admin');
        console.log('   Database: sushiwan_db');
        
        const client = await pool.connect();
        const result = await client.query('SELECT NOW() as now, current_user as user, current_database() as database');
        
        console.log('\n✅ CONNEXION RÉUSSIE !');
        console.log(`👤 Utilisateur connecté: ${result.rows[0].user}`);
        console.log(`🗄️ Base de données: ${result.rows[0].database}`);
        console.log(`⏰ Heure: ${result.rows[0].now}`);
        
        client.release();
        
        // Lister les tables existantes
        const tables = await pool.query(`
            SELECT table_name, 
                   (SELECT COUNT(*) FROM information_schema.columns WHERE table_name = t.table_name) as column_count
            FROM information_schema.tables t
            WHERE table_schema = 'public' 
            ORDER BY table_name
        `);
        
        console.log(`\n📊 Tables dans sushiwan_db: ${tables.rows.length}`);
        
        if (tables.rows.length > 0) {
            tables.rows.forEach(row => {
                console.log(`  ✅ ${row.table_name} (${row.column_count} colonnes)`);
            });
        } else {
            console.log('  ℹ️ Aucune table trouvée (base vide ou nouvellement créée)');
        }
        
        // Vérifier s'il y a des données
        if (tables.rows.length > 0) {
            console.log('\n📈 Aperçu des données:');
            for (const table of tables.rows.slice(0, 3)) { // Max 3 tables
                try {
                    const count = await pool.query(`SELECT COUNT(*) FROM ${table.table_name}`);
                    console.log(`  📊 ${table.table_name}: ${count.rows[0].count} enregistrements`);
                } catch (error) {
                    console.log(`  ❌ ${table.table_name}: erreur lecture`);
                }
            }
        }
        
        return true;
    } catch (error) {
        console.log('\n❌ ERREUR DE CONNEXION');
        console.log(`🔍 Détail: ${error.message}`);
        
        if (error.message.includes('database "sushiwan_db" does not exist')) {
            console.log('\n💡 La base sushiwan_db n\'existe pas encore');
            console.log('👉 Nous devrons la créer');
        }
        if (error.message.includes('password authentication failed')) {
            console.log('\n💡 Problème d\'authentification');
            console.log('👉 Vérifiez le mot de passe');
        }
        if (error.message.includes('ECONNREFUSED')) {
            console.log('\n💡 PostgreSQL n\'est pas démarré');
            console.log('👉 Démarrez PostgreSQL');
        }
        
        return false;
    } finally {
        await pool.end();
    }
}

testVraiConnection().then(success => {
    console.log('\n' + '='.repeat(50));
    if (success) {
        console.log('🎉 === CONNEXION RÉUSSIE ===');
        console.log('👉 Votre base de données sushiwan est opérationnelle !');
        console.log('👉 Nous pouvons maintenant faire l\'audit complet');
    } else {
        console.log('⚠️ === CONNEXION ÉCHOUÉE ===');
        console.log('👉 Nous devons créer la base ou corriger la config');
    }
});
