local pType = Game.createPokemonType("Wigglytuff")
local pokemon = { }

pokemon.description = "an Wigglytuff"
pokemon.experience = 218
pokemon.portrait = 2335
pokemon.corpse = 2501

pokemon.outfit = {
	lookType = 40
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
	health = 140,
	attack = 70,
	defense = 45,
	specialAttack = 85,
	specialDefense = 50,
	speed = 45
}

pokemon.types = {
	first = POKEMON_TYPE_NORMAL,
	second = POKEMON_TYPE_FAIRY,
}

pokemon.pokedexInformation = {
	nationalNumber = 40,
	description = "It has a very fine fur. Take care not to make it angry, or it may inflate steadily and hit with a body slam.",
	height = 1.0,
	weight = 12.0,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 129,
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
	{ text = "Tuff!!", yell = false },
	{ text = "Wiggly!", yell = false },
	{ text = "Wigglytuff!", yell = false },
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
