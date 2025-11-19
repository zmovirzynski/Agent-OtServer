local pType = Game.createPokemonType("Drowzee")
local pokemon = { }

pokemon.description = "an Drowzee"
pokemon.experience = 66
pokemon.portrait = 2391
pokemon.corpse = 2557

pokemon.outfit = {
	lookType = 96
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 25,
}

pokemon.baseStats = {
	health = 60,
	attack = 48,
	defense = 45,
	specialAttack = 43,
	specialDefense = 90,
	speed = 42
}

pokemon.types = {
	first = POKEMON_TYPE_PSYCHIC,
}

pokemon.pokedexInformation = {
	nationalNumber = 96,
	description = "It remembers every dream it eats. It rarely eats the dreams of adults because children’s are much tastier.",
	height = 1.0,
	weight = 32.4,
}

pokemon.evolutions = {
	{ name = "hypno", stone = "psychic stone", level = 26 }
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
	{ text = "Drowzeee!", yell = false },
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
