local pType = Game.createPokemonType("Graveler")
local pokemon = { }

pokemon.description = "an Graveler"
pokemon.experience = 137
pokemon.portrait = 2370
pokemon.corpse = 2536

pokemon.outfit = {
	lookType = 75
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 24,
	max = 35,
}

pokemon.baseStats = {
	health = 55,
	attack = 95,
	defense = 115,
	specialAttack = 45,
	specialDefense = 45,
	speed = 35
}

pokemon.types = {
	first = POKEMON_TYPE_ROCK,
	second = POKEMON_TYPE_GROUND,
}

pokemon.pokedexInformation = {
	nationalNumber = 75,
	description = "Often seen rolling down mountain trails. Obstacles are just things to roll straight over, not avoid.",
	height = 1.0,
	weight = 105.0,
}

pokemon.evolutions = {
	{ name = "golem", stone = "rock stone" }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 249,
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
	{ text = "Graveleer!", yell = false },
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
