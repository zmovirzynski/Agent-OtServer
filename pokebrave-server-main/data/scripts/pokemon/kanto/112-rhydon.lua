local pType = Game.createPokemonType("Rhydon")
local pokemon = { }

pokemon.description = "an Rhydon"
pokemon.experience = 170
pokemon.portrait = 2407
pokemon.corpse = 2573

pokemon.outfit = {
	lookType = 112
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 42,
	max = 100,
}

pokemon.baseStats = {
	health = 105,
	attack = 130,
	defense = 120,
	specialAttack = 45,
	specialDefense = 45,
	speed = 40
}

pokemon.types = {
	first = POKEMON_TYPE_GROUND,
	second = POKEMON_TYPE_ROCK,
}

pokemon.pokedexInformation = {
	nationalNumber = 112,
	description = "It begins walking on its hind legs after evolution. It can punch holes through boulders with its horn.",
	height = 1.9,
	weight = 120.0,
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
	{ text = "Rhydoon!", yell = false },
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
