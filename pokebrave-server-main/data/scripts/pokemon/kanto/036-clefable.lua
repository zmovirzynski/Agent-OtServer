local pType = Game.createPokemonType("Clefable")
local pokemon = { }

pokemon.description = "an Clefable"
pokemon.experience = 217
pokemon.portrait = 2331
pokemon.corpse = 26897

pokemon.outfit = {
	lookType = 36
}

pokemon.gender = {
	malePercent = 25,
	femalePercent = 75
}

pokemon.spawnLevel = {
	min = 36,
	max = 100,
}

pokemon.baseStats = {
	health = 95,
	attack = 70,
	defense = 73,
	specialAttack = 95,
	specialDefense = 90,
	speed = 60
}

pokemon.types = {
	first = POKEMON_TYPE_FAIRY,
}

pokemon.pokedexInformation = {
	nationalNumber = 36,
	description = "A timid fairy Pokémon that is rarely seen, it will run and hide the moment it senses people. ",
	height = 1.3,
	weight = 40.0,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 77,
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
	{ text = "Fablee!", yell = false },
	{ text = "Clefaa!", yell = false },
	{ text = "Clefablee!", yell = false },
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
