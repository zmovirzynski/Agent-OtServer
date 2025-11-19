local pType = Game.createPokemonType("Nidoranfe")
local pokemon = { }

pokemon.description = "an Nidoranfe"
pokemon.experience = 55
pokemon.portrait = 2324
pokemon.corpse = 26890

pokemon.outfit = {
	lookType = 29
}

pokemon.gender = {
	malePercent = 0,
	femalePercent = 100
}

pokemon.spawnLevel = {
	min = 1,
	max = 15,
}

pokemon.baseStats = {
	health = 55,
	attack = 47,
	defense = 52,
	specialAttack = 40,
	specialDefense = 40,
	speed = 41
}

pokemon.types = {
	first = POKEMON_TYPE_POISON,
}

pokemon.pokedexInformation = {
	nationalNumber = 29,
	description = "Females are more sensitive to smells than males. While foraging, they’ll use their whiskers to check wind direction and stay downwind of predators.",
	height = 0.4,
	weight = 7.0,
}

pokemon.evolutions = {
	{ name = "nidorina", stone = "moon stone", level = 16 }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 413,
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
	{ text = "Nidoraan!", yell = false },
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
