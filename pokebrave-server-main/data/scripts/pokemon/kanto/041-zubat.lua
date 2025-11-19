local pType = Game.createPokemonType("Zubat")
local pokemon = { }

pokemon.description = "an Zubat"
pokemon.experience = 49
pokemon.portrait = 2336
pokemon.corpse = 2502

pokemon.outfit = {
	lookType = 41
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 21,
}

pokemon.baseStats = {
	health = 40,
	attack = 45,
	defense = 35,
	specialAttack = 30,
	specialDefense = 40,
	speed = 55
}

pokemon.types = {
	first = POKEMON_TYPE_POISON,
	second = POKEMON_TYPE_FLYING,
}

pokemon.pokedexInformation = {
	nationalNumber = 41,
	description = "It emits ultrasonic waves from its mouth to check its surroundings. Even in tight caves, Zubat flies around with skill.",
	height = 0.8,
	weight = 7.5,
}

pokemon.evolutions = {
	{ name = "golbat", stone = "venom stone", level = 22 }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 439,
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
	{ text = "Zubat!!", yell = false },
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
