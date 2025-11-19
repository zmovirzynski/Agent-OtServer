local pType = Game.createPokemonType("Seel")
local pokemon = { }

pokemon.description = "an Seel"
pokemon.experience = 65
pokemon.portrait = 2381
pokemon.corpse = 2547

pokemon.outfit = {
	lookType = 86
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 33,
}

pokemon.baseStats = {
	health = 65,
	attack = 45,
	defense = 55,
	specialAttack = 45,
	specialDefense = 70,
	speed = 45
}

pokemon.types = {
	first = POKEMON_TYPE_WATER,
}

pokemon.pokedexInformation = {
	nationalNumber = 86,
	description = "Loves freezing-cold conditions. Relishes swimming in a frigid climate of around 14 degrees Fahrenheit.",
	height = 1.1,
	weight = 90.0,
}

pokemon.evolutions = {
	{ name = "dewgong", stone = "water stone", level = 34 }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 352,
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
	{ text = "Seel!", yell = false },
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
