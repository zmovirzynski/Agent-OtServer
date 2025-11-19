local pType = Game.createPokemonType("Scyther")
local pokemon = { }

pokemon.description = "an Scyther"
pokemon.experience = 100
pokemon.portrait = 2418
pokemon.corpse = 2583

pokemon.outfit = {
	lookType = 123
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 100,
}

pokemon.baseStats = {
	health = 70,
	attack = 110,
	defense = 80,
	specialAttack = 55,
	specialDefense = 80,
	speed = 105
}

pokemon.types = {
	first = POKEMON_TYPE_BUG,
	second = POKEMON_TYPE_FLYING
}

pokemon.pokedexInformation = {
	nationalNumber = 123,
	description = "It slashes through grass with its sharp scythes, moving too fast for the human eye to track.",
	height = 1.5,
	weight = 56.0,
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
	{ text = "Scytheer!", yell = false },
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
