local pType = Game.createPokemonType("Arbok")
local pokemon = { }

pokemon.description = "an Arbok"
pokemon.experience = 157
pokemon.portrait = 2319
pokemon.corpse = 26885

pokemon.outfit = {
	lookType = 24
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 22,
	max = 100,
}

pokemon.baseStats = {
	health = 60,
	attack = 95,
	defense = 69,
	specialAttack = 65,
	specialDefense = 79,
	speed = 80
}

pokemon.types = {
	first = POKEMON_TYPE_POISON,
}

pokemon.pokedexInformation = {
	nationalNumber = 24,
	description = "The frightening patterns on its belly have been studied. Six variations have been confirmed.",
	height = 3.5,
	weight = 65.0,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 201,
	requiredLevel = pokemon.spawnLevel.min,
	summonable = true,
	attackable = true,
	hostile = true,
	challengeable = false,
	convinceable = false,
	ignoreSpawnBlock = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	targetDistance = 1,
	staticAttackChance = 70,
}

pokemon.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Arbook!", yell = false },
}

pokemon.loot = {

}

pokemon.moves = {

}

pokemon.attacks = {
	{ name = "melee", minDamage = 0, maxDamage = -8, interval = 2*1000 },
}

pokemon.defenses = {
	defense = 1,
	armor = 1,
}

pokemon.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 30 },
}

pokemon.immunities = {

}

pokemon.learnableTMs = {

}

pokemon.learnableHMs = {

}

pType:register(pokemon)
