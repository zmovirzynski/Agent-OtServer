local pType = Game.createPokemonType("Spearow")
local pokemon = { }

pokemon.description = "an Spearow"
pokemon.experience = 52
pokemon.portrait = 2316
pokemon.corpse = 26882

pokemon.outfit = {
	lookType = 21
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 19,
}

pokemon.baseStats = {
	health = 40,
	attack = 60,
	defense = 30,
	specialAttack = 31,
	specialDefense = 31,
	speed = 70
}

pokemon.types = {
	first = POKEMON_TYPE_NORMAL,
	second = POKEMON_TYPE_FLYING
}

pokemon.pokedexInformation = {
	nationalNumber = 21,
	description = "Inept at flying high. However, it can fly around very fast to protect its territory.",
	height = 0.3,
	weight = 2.0,
}

pokemon.evolutions = {
	{ name = "fearow", stone = "heart stone", level = 20 }
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
	{ text = "Spearoow!", yell = false },
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
