local pType = Game.createPokemonType("Gengar")
local pokemon = { }

pokemon.description = "an Gengar"
pokemon.experience = 250
pokemon.portrait = 2389
pokemon.corpse = 2555

pokemon.outfit = {
	lookType = 94
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 36,
	max = 100,
}

pokemon.baseStats = {
	health = 60,
	attack = 65,
	defense = 60,
	specialAttack = 130,
	specialDefense = 75,
	speed = 110
}

pokemon.types = {
	first = POKEMON_TYPE_GHOST,
	second = POKEMON_TYPE_POISON
}

pokemon.pokedexInformation = {
	nationalNumber = 94,
	description = "To steal the life of its target, it slips into the prey’s shadow and silently waits for an opportunity.",
	height = 1.5,
	weight = 40.5,
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
	{ text = "Gengaar!", yell = false },
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
