local pType = Game.createPokemonType("Venomoth")
local pokemon = { }

pokemon.description = "an Venomoth"
pokemon.experience = 158
pokemon.portrait = 2344
pokemon.corpse = 2510

pokemon.outfit = {
	lookType = 49
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 31,
	max = 100,
}

pokemon.baseStats = {
	health = 70,
	attack = 65,
	defense = 60,
	specialAttack = 90,
	specialDefense = 75,
	speed = 90
}

pokemon.types = {
	first = POKEMON_TYPE_BUG,
	second = POKEMON_TYPE_POISON,
}

pokemon.pokedexInformation = {
	nationalNumber = 49,
	description = "The wings are covered with dustlike scales. Every time it flaps its wings, it looses highly toxic dust.",
	height = 1.5,
	weight = 12.5,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 175,
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
	{ text = "Venomooth!", yell = false },
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
