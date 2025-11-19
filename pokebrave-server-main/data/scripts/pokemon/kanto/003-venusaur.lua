local pType = Game.createPokemonType("Venusaur")
local pokemon = { }

pokemon.description = "an Venusaur"
pokemon.experience = 236
pokemon.portrait = 2298
pokemon.corpse = 26864

pokemon.outfit = {
	lookType = 3
}

pokemon.gender = {
	malePercent = 87.5,
	femalePercent = 12.5
}

pokemon.spawnLevel = {
	min = 36,
	max = 100
}

pokemon.baseStats = {
	health = 80,
	attack = 82,
	defense = 83,
	specialAttack = 100,
	specialDefense = 100,
	speed = 80
}

pokemon.types = {
	first = POKEMON_TYPE_GRASS,
	second = POKEMON_TYPE_POISON
}

pokemon.pokedexInformation = {
	nationalNumber = 3,
	description = "Its plant blooms when it is absorbing solar energy. It stays on the move to seek sunlight.",
	height = 2.0,
	weight = 100.0,
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
	{ text = "Venusaur!", yell = false },
	{ text = "Saaur!", yell = false }
}

pokemon.loot = {

}

pokemon.moves = {
	{ id = 1, name = "vine whip", level = 1 },
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
	{ ability = "ride" }
}

pType:register(pokemon)
