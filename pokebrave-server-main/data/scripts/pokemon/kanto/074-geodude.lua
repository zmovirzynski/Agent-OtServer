local pType = Game.createPokemonType("Geodude")
local pokemon = { }

pokemon.description = "an Geodude"
pokemon.experience = 60
pokemon.portrait = 2369
pokemon.corpse = 2535

pokemon.outfit = {
	lookType = 74
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 24,
}

pokemon.baseStats = {
	health = 40,
	attack = 80,
	defense = 100,
	specialAttack = 30,
	specialDefense = 30,
	speed = 20
}

pokemon.types = {
	first = POKEMON_TYPE_ROCK,
	second = POKEMON_TYPE_GROUND,
}

pokemon.pokedexInformation = {
	nationalNumber = 74,
	description = "Commonly found near mountain trails and the like. If you step on one by accident, it gets angry.",
	height = 0.4,
	weight = 20.0,
}

pokemon.evolutions = {
	{ name = "graveler", stone = "rock stone", level = 25 }
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
	{ text = "Geoo!", yell = false },
	{ text = "Geodude!", yell = false },
}

pokemon.loot = {

}

pokemon.moves = {
	{ id = 1, name = "rock throw", level = 1 },
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
