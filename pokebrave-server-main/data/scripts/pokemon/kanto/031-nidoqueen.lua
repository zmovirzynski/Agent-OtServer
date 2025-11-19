local pType = Game.createPokemonType("Nidoqueen")
local pokemon = { }

pokemon.description = "an Nidoqueen"
pokemon.experience = 227
pokemon.portrait = 2326
pokemon.corpse = 26892

pokemon.outfit = {
	lookType = 31
}

pokemon.gender = {
	malePercent = 0,
	femalePercent = 100
}

pokemon.spawnLevel = {
	min = 36,
	max = 100,
}

pokemon.baseStats = {
	health = 90,
	attack = 92,
	defense = 87,
	specialAttack = 75,
	specialDefense = 85,
	speed = 76
}

pokemon.types = {
	first = POKEMON_TYPE_POISON,
	second = POKEMON_TYPE_GROUND
}

pokemon.pokedexInformation = {
	nationalNumber = 31,
	description = "Nidoqueen is better at defense than offense. With scales like armor, this Pokémon will shield its children from any kind of attack.",
	height = 1.3,
	weight = 60.0,
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
	{ text = "Nidoqueen!", yell = false },
	{ text = "Queen!", yell = false },
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
