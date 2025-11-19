local pType = Game.createPokemonType("Kakuna")
local pokemon = { }

pokemon.description = "an Kakuna"
pokemon.experience = 72
pokemon.portrait = 2309
pokemon.corpse = 26875

pokemon.outfit = {
	lookType = 14
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 7,
	max = 9,
}

pokemon.baseStats = {
	health = 45,
	attack = 25,
	defense = 50,
	specialAttack = 25,
	specialDefense = 25,
	speed = 35
}

pokemon.types = {
	first = POKEMON_TYPE_BUG,
	second = POKEMON_TYPE_POISON
}

pokemon.pokedexInformation = {
	nationalNumber = 14,
	description = "Able to move only slightly. When endangered, it may stick out its stinger and poison its enemy.",
	height = 0.6,
	weight = 10.0,
}

pokemon.evolutions = {
	{ name = "beedrill", stone = "insect stone", level = 10 }
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
	{ text = "Kakunaa!", yell = false },
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
