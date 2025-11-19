local pType = Game.createPokemonType("Wartortle")
local pokemon = { }

pokemon.description = "an Wartortle"
pokemon.experience = 142
pokemon.portrait = 2303
pokemon.corpse = 26869

pokemon.outfit = {
	lookType = 8
}

pokemon.gender = {
	malePercent = 87.5,
	femalePercent = 12.5
}

pokemon.spawnLevel = {
	min = 16,
	max = 35
}

pokemon.baseStats = {
	health = 59,
	attack = 63,
	defense = 80,
	specialAttack = 65,
	specialDefense = 80,
	speed = 58
}

pokemon.types = {
	first = POKEMON_TYPE_WATER,
}

pokemon.pokedexInformation = {
	nationalNumber = 8,
	description = "It is recognized as a symbol of longevity. If its shell has algae on it, that Wartortle is very old.",
	height = 1.0,
	weight = 22.5,
}

pokemon.evolutions = {
	{ name = "blastoise", stone = "water stone", level = 36 }
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
