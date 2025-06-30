const { sequelize } = require('./connection');
const Ingredient = require('../models/Ingredient');

async function testIngredient() {
  console.log('🧪 TEST MODELE INGREDIENT');
  
  try {
    console.log('🔌 Connexion...');
    await sequelize.authenticate();
    console.log('✅ Connexion OK');
    
    console.log('📋 Creation table...');
    await Ingredient.sync({ force: true });
    console.log('✅ Table ingredients creee');
    
    console.log('🍣 Creation ingredient test...');
    const saumon = await Ingredient.create({
      nom_fr: 'Saumon frais',
      nom_en: 'Fresh salmon',
      code_interne: 'SALMON_FRESH',
      categorie_ingredient: 'POISSON',
      en_stock: true,
      allergene: false
    });
    
    console.log('✅ Saumon cree:', saumon.toAPI());
    console.log('🎉 TEST REUSSI !');
    
  } catch (error) {
    console.error('❌ Erreur:', error.message);
  } finally {
    await sequelize.close();
    console.log('📴 Connexion fermee');
  }
}

testIngredient();
