local pType = Game.createPokemonType("Omastar")
local pokemon = { }

pokemon.description = "an Omastar"
pokemon.experience = 173
pokemon.portrait = 2434
pokemon.corpse = 2599

pokemon.outfit = {
	lookType = 139
}

pokemon.gender = {
	malePercent = 87.5,
	femalePercent = 12.5
}

pokemon.spawnLevel = {
	min = 40,
	max = 100,
}

pokemon.baseStats = {
	health = 70,
	attack = 60,
	defense = 125,
	specialAttack = 115,
	specialDefense = 70,
	speed = 55
}

pokemon.types = {
	first = POKEMON_TYPE_ROCK,
	second = POKEMON_TYPE_WATER,
}

pokemon.pokedexInformation = {
	nationalNumber = 139,
	description = "Weighed down by a large and heavy shell, Omastar couldn’t move very fast. Some say it went extinct because it was unable to catch food.",
	height = 1.0,
	weight = 35.0,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 119,
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
	{ text = "Omastaar!", yell = false },
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
