local pType = Game.createPokemonType("Kingler")
local pokemon = { }

pokemon.description = "an Kingler"
pokemon.experience = 166
pokemon.portrait = 2394
pokemon.corpse = 2560

pokemon.outfit = {
	lookType = 99
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 28,
	max = 100,
}

pokemon.baseStats = {
	health = 55,
	attack = 130,
	defense = 115,
	specialAttack = 50,
	specialDefense = 50,
	speed = 75
}

pokemon.types = {
	first = POKEMON_TYPE_WATER,
}

pokemon.pokedexInformation = {
	nationalNumber = 99,
	description = "The larger pincer has 10,000-horsepower strength. However, it is so heavy, it is difficult to aim.",
	height = 1.3,
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
	{ text = "Kingleer!", yell = false },
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
