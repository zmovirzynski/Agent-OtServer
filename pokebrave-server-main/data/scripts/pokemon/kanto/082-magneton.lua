local pType = Game.createPokemonType("Magneton")
local pokemon = { }

pokemon.description = "an Magneton"
pokemon.experience = 163
pokemon.portrait = 2377
pokemon.corpse = 2543

pokemon.outfit = {
	lookType = 82
}

pokemon.gender = {
	malePercent = 0,
	femalePercent = 0
}

pokemon.spawnLevel = {
	min = 30,
	max = 100,
}

pokemon.baseStats = {
	health = 50,
	attack = 60,
	defense = 95,
	specialAttack = 120,
	specialDefense = 70,
	speed = 70
}

pokemon.types = {
	first = POKEMON_TYPE_ELETRIC,
	second = POKEMON_TYPE_STEEL,
}

pokemon.pokedexInformation = {
	nationalNumber = 82,
	description = "Three Magnemite are linked by a strong magnetic force. Earaches will occur if you get too close.",
	height = 1.0,
	weight = 60.0,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 148,
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
	{ text = "Magnetoon!", yell = false },
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
