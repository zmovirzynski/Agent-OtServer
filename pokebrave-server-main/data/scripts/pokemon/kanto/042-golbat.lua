local pType = Game.createPokemonType("Golbat")
local pokemon = { }

pokemon.description = "an Golbat"
pokemon.experience = 159
pokemon.portrait = 2337
pokemon.corpse = 2503

pokemon.outfit = {
	lookType = 42
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 22,
	max = 100,
}

pokemon.baseStats = {
	health = 75,
	attack = 80,
	defense = 70,
	specialAttack = 65,
	specialDefense = 75,
	speed = 90
}

pokemon.types = {
	first = POKEMON_TYPE_POISON,
	second = POKEMON_TYPE_FLYING,
}

pokemon.pokedexInformation = {
	nationalNumber = 42,
	description = "It loves to drink other creatures’ blood. It’s said that if it finds others of its kind going hungry, it sometimes shares the blood it’s gathered.",
	height = 1.6,
	weight = 55.0,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 201,
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
	{ text = "Golbatt!!", yell = false },
	{ text = "Baat!", yell = false },
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
