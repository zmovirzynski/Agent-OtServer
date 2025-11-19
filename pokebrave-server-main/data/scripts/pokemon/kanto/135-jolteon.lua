local pType = Game.createPokemonType("Jolteon")
local pokemon = { }

pokemon.description = "an Jolteon"
pokemon.experience = 184
pokemon.portrait = 2430
pokemon.corpse = 2595

pokemon.outfit = {
	lookType = 135
}

pokemon.gender = {
	malePercent = 87.5,
	femalePercent = 12.5
}

pokemon.spawnLevel = {
	min = 36,
	max = 100,
}

pokemon.baseStats = {
	health = 65,
	attack = 65,
	defense = 60,
	specialAttack = 110,
	specialDefense = 95,
	speed = 130
}

pokemon.types = {
	first = POKEMON_TYPE_ELETRIC,
}

pokemon.pokedexInformation = {
	nationalNumber = 135,
	description = "It concentrates the weak electric charges emitted by its cells and launches wicked lightning bolts.",
	height = 0.8,
	weight = 24.5,
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
	{ text = "Jolteoon!", yell = false },
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
