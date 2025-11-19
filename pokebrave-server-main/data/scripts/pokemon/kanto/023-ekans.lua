local pType = Game.createPokemonType("Ekans")
local pokemon = { }

pokemon.description = "an Ekans"
pokemon.experience = 58
pokemon.portrait = 2318
pokemon.corpse = 26884

pokemon.outfit = {
	lookType = 23
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 21,
}

pokemon.baseStats = {
	health = 35,
	attack = 60,
	defense = 44,
	specialAttack = 40,
	specialDefense = 54,
	speed = 55
}

pokemon.types = {
	first = POKEMON_TYPE_POISON,
}

pokemon.pokedexInformation = {
	nationalNumber = 23,
	description = "The older it gets, the longer it grows. At night, it wraps its long body around tree branches to rest.",
	height = 2.0,
	weight = 6.9,
}

pokemon.evolutions = {
	{ name = "arbok", stone = "venom stone", level = 22 }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 439,
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
	{ text = "Ekaans!", yell = false },
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
