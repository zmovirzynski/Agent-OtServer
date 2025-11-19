local pType = Game.createPokemonType("Charizard")
local pokemon = { }

pokemon.description = "an Charizard"
pokemon.experience = 267
pokemon.portrait = 2301
pokemon.corpse = 26867

pokemon.outfit = {
	lookType = 6
}

pokemon.gender = {
	malePercent = 87.5,
	femalePercent = 12.5
}

pokemon.spawnLevel = {
	min = 36,
	max = 100
}

pokemon.baseStats = {
	health = 78,
	attack = 84,
	defense = 78,
	specialAttack = 109,
	specialDefense = 85,
	speed = 100
}

pokemon.types = {
	first = POKEMON_TYPE_FIRE,
	second = POKEMON_TYPE_FLYING,
}

pokemon.pokedexInformation = {
	nationalNumber = 6,
	description = "It is said that Charizard's fire burns hotter if it has experienced harsh battles.",
	height = 1.7,
	weight = 90.5,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 1000,
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
	{ text = "Charizard!", yell = false },
	{ text = "Chaar!", yell = false }
}

pokemon.loot = {

}

pokemon.moves = {
	{ id = 1, name = "flamethrower", level = 1 }
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
	{ ability = "fly" }
}

pType:register(pokemon)
