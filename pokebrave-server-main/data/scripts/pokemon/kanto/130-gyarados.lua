local pType = Game.createPokemonType("Gyarados")
local pokemon = { }

pokemon.description = "an Gyarados"
pokemon.experience = 189
pokemon.portrait = 2425
pokemon.corpse = 2590

pokemon.outfit = {
	lookType = 130
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 20,
	max = 100,
}

pokemon.baseStats = {
	health = 95,
	attack = 125,
	defense = 79,
	specialAttack = 60,
	specialDefense = 100,
	speed = 81
}

pokemon.types = {
	first = POKEMON_TYPE_WATER,
	second = POKEMON_TYPE_FLYING
}

pokemon.pokedexInformation = {
	nationalNumber = 130,
	description = "Once it appears, it goes on a rampage. It remains enraged until it demolishes everything around it.",
	height = 6.5,
	weight = 235.0,
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
	{ text = "Gyaaa!", yell = false },
	{ text = "Gyaarados!", yell = false },
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
