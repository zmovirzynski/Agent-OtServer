local pType = Game.createPokemonType("Bellsprout")
local pokemon = { }

pokemon.description = "an Bellsprout"
pokemon.experience = 60
pokemon.portrait = 2364
pokemon.corpse = 2530

pokemon.outfit = {
	lookType = 69
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 20,
}

pokemon.baseStats = {
	health = 50,
	attack = 75,
	defense = 35,
	specialAttack = 70,
	specialDefense = 30,
	speed = 40
}

pokemon.types = {
	first = POKEMON_TYPE_GRASS,
	second = POKEMON_TYPE_POISON,
}

pokemon.pokedexInformation = {
	nationalNumber = 69,
	description = "Prefers hot and humid places. It ensnares tiny bugs with its vines and devours them.",
	height = 0.7,
	weight = 4.0,
}

pokemon.evolutions = {
	{ name = "weepinbell", stone = "leaf stone", level = 21 }
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
	{ text = "Beell!", yell = false },
	{ text = "Beellsprout!", yell = false },
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
