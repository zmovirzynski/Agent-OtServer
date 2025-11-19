local pType = Game.createPokemonType("Venonat")
local pokemon = { }

pokemon.description = "an Venonat"
pokemon.experience = 61
pokemon.portrait = 2343
pokemon.corpse = 2509

pokemon.outfit = {
	lookType = 48
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 30,
}

pokemon.baseStats = {
	health = 60,
	attack = 55,
	defense = 50,
	specialAttack = 40,
	specialDefense = 55,
	speed = 45
}

pokemon.types = {
	first = POKEMON_TYPE_BUG,
	second = POKEMON_TYPE_POISON,
}

pokemon.pokedexInformation = {
	nationalNumber = 48,
	description = "Poison oozes from all over its body. It catches small bug Pokémon at night that are attracted by light.",
	height = 1.0,
	weight = 30.0,
}


pokemon.evolutions = {
	{ name = "venomoth", stone = "venom stone", level = 31 }
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
	{ text = "Venonaat!", yell = false },
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
