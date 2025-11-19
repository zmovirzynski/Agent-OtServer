local pType = Game.createPokemonType("Paras")
local pokemon = { }

pokemon.description = "an Paras"
pokemon.experience = 57
pokemon.portrait = 2341
pokemon.corpse = 2507

pokemon.outfit = {
	lookType = 46
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 23,
}

pokemon.baseStats = {
	health = 35,
	attack = 70,
	defense = 55,
	specialAttack = 45,
	specialDefense = 55,
	speed = 25
}

pokemon.types = {
	first = POKEMON_TYPE_BUG,
	second = POKEMON_TYPE_GRASS,
}

pokemon.pokedexInformation = {
	nationalNumber = 46,
	description = "Burrows under the ground to gnaw on tree roots. The mushrooms on its back absorb most of the nutrition.",
	height = 0.3,
	weight = 5.4,
}

pokemon.evolutions = {
	{ name = "parasect", stone = "insect stone", level = 24 }
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
	{ text = "Paraas!!", yell = false },
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
