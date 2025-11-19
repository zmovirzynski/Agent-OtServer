local pType = Game.createPokemonType("Jynx")
local pokemon = { }

pokemon.description = "an Jynx"
pokemon.experience = 159
pokemon.portrait = 2419
pokemon.corpse = 2584

pokemon.outfit = {
	lookType = 124
}

pokemon.gender = {
	malePercent = 0,
	femalePercent = 100
}

pokemon.spawnLevel = {
	min = 30,
	max = 100,
}

pokemon.baseStats = {
	health = 65,
	attack = 50,
	defense = 35,
	specialAttack = 115,
	specialDefense = 95,
	speed = 95
}

pokemon.types = {
	first = POKEMON_TYPE_ICE,
	second = POKEMON_TYPE_PSYCHIC
}

pokemon.pokedexInformation = {
	nationalNumber = 124,
	description = "In certain parts of Galar, Jynx was once feared and worshiped as the Queen of Ice.",
	height = 1.4,
	weight = 40.6,
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
	{ text = "Jynnx!", yell = false },
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
