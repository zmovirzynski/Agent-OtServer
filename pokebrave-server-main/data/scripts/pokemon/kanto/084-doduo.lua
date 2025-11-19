local pType = Game.createPokemonType("Doduo")
local pokemon = { }

pokemon.description = "an Doduo"
pokemon.experience = 62
pokemon.portrait = 2379
pokemon.corpse = 2545

pokemon.outfit = {
	lookType = 84
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
	health = 35,
	attack = 85,
	defense = 45,
	specialAttack = 35,
	specialDefense = 35,
	speed = 75
}

pokemon.types = {
	first = POKEMON_TYPE_NORMAL,
	second = POKEMON_TYPE_FLYING,
}

pokemon.pokedexInformation = {
	nationalNumber = 84,
	description = "Its short wings make flying difficult. Instead, this Pokémon runs at high speed on developed legs.",
	height = 1.4,
	weight = 39.2,
}

pokemon.evolutions = {
	{ name = "dodrio", stone = "heart stone", level = 31 }
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
	{ text = "Doduoo!", yell = false },
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
