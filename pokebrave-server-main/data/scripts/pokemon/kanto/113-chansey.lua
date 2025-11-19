local pType = Game.createPokemonType("Chansey")
local pokemon = { }

pokemon.description = "an Chansey"
pokemon.experience = 395
pokemon.portrait = 2408
pokemon.corpse = 2574

pokemon.outfit = {
	lookType = 113
}

pokemon.gender = {
	malePercent = 0,
	femalePercent = 100
}

pokemon.spawnLevel = {
	min = 1,
	max = 100,
}

pokemon.baseStats = {
	health = 250,
	attack = 5,
	defense = 5,
	specialAttack = 35,
	specialDefense = 105,
	speed = 50
}

pokemon.types = {
	first = POKEMON_TYPE_NORMAL
}

pokemon.pokedexInformation = {
	nationalNumber = 113,
	description = "This kindly Pokémon lays highly nutritious eggs and shares them with injured Pokémon or people.",
	height = 1.1,
	weight = 34.6,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 88,
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
	{ text = "Chanseey!", yell = false },
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
