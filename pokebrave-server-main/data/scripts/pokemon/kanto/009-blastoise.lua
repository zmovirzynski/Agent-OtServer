local pType = Game.createPokemonType("Blastoise")
local pokemon = { }

pokemon.description = "an Blastoise"
pokemon.experience = 239
pokemon.portrait = 2304
pokemon.corpse = 26870

pokemon.outfit = {
	lookType = 9
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
	health = 79,
	attack = 83,
	defense = 100,
	specialAttack = 85,
	specialDefense = 105,
	speed = 78
}

pokemon.types = {
	first = POKEMON_TYPE_WATER,
}

pokemon.pokedexInformation = {
	nationalNumber = 9,
	description = "It crushes its foe under its heavy body to cause fainting. In a pinch, it will withdraw inside its shell.",
	height = 1.6,
	weight = 85.5,
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
	{ text = "Wartortle!", yell = false },
	{ text = "Tortlee!", yell = false },
}

pokemon.loot = {

}

pokemon.moves = {
	{ id = 1, name = "waterfall", level = 1 },
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
	{ ability = "surf" }
}

pType:register(pokemon)
