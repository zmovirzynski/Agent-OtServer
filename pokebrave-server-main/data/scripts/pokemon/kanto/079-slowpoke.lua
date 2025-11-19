local pType = Game.createPokemonType("Slowpoke")
local pokemon = { }

pokemon.description = "an Slowpoke"
pokemon.experience = 63
pokemon.portrait = 2374
pokemon.corpse = 2540

pokemon.outfit = {
	lookType = 79
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 36,
}

pokemon.baseStats = {
	health = 90,
	attack = 65,
	defense = 65,
	specialAttack = 40,
	specialDefense = 40,
	speed = 15
}

pokemon.types = {
	first = POKEMON_TYPE_WATER,
	second = POKEMON_TYPE_PSYCHIC,
}

pokemon.pokedexInformation = {
	nationalNumber = 79,
	description = "It is incredibly slow and dopey. It takes five seconds for it to feel pain when under attack.",
	height = 1.2,
	weight = 36.0,
}

pokemon.evolutions = {
	{ name = "slowbro", stone = "psychic stone", level = 37 }
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
	{ text = "Slowpoke!", yell = false },
	{ text = "Pooke!", yell = false },
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
