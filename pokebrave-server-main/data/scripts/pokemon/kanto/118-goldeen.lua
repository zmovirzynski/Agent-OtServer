local pType = Game.createPokemonType("Goldeen")
local pokemon = { }

pokemon.description = "an Goldeen"
pokemon.experience = 64
pokemon.portrait = 2413
pokemon.corpse = 2579

pokemon.outfit = {
	lookType = 118
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 32,
}

pokemon.baseStats = {
	health = 45,
	attack = 67,
	defense = 60,
	specialAttack = 35,
	specialDefense = 50,
	speed = 63
}

pokemon.types = {
	first = POKEMON_TYPE_WATER
}

pokemon.pokedexInformation = {
	nationalNumber = 118,
	description = "Its dorsal, pectoral, and tail fins wave elegantly in water. That is why it is known as the Water Dancer.",
	height = 0.6,
	weight = 15.0,
}

pokemon.evolutions = {
	{ name = "seaking", stone = "water stone", level = 33 }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 399,
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
	{ text = "Goldeen!", yell = false },
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
