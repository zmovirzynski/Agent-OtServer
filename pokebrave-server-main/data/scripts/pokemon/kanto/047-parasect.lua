local pType = Game.createPokemonType("Parasect")
local pokemon = { }

pokemon.description = "an Parasect"
pokemon.experience = 142
pokemon.portrait = 2342
pokemon.corpse = 2508

pokemon.outfit = {
	lookType = 47
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 24,
	max = 100,
}

pokemon.baseStats = {
	health = 60,
	attack = 95,
	defense = 80,
	specialAttack = 60,
	specialDefense = 80,
	speed = 30
}

pokemon.types = {
	first = POKEMON_TYPE_BUG,
	second = POKEMON_TYPE_GRASS,
}

pokemon.pokedexInformation = {
	nationalNumber = 47,
	description = "The bug host is drained of energy by the mushroom on its back. The mushroom appears to do all the thinking.",
	height = 1.0,
	weight = 29.5,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 175,
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
	{ text = "Paraseect!", yell = false },
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
