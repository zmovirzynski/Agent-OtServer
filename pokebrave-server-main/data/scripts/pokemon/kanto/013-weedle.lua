local pType = Game.createPokemonType("Weedle")
local pokemon = { }

pokemon.description = "an Weedle"
pokemon.experience = 39
pokemon.portrait = 2308
pokemon.corpse = 26874

pokemon.outfit = {
	lookType = 13
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 6
}

pokemon.baseStats = {
	health = 40,
	attack = 35,
	defense = 30,
	specialAttack = 20,
	specialDefense = 20,
	speed = 50
}

pokemon.types = {
	first = POKEMON_TYPE_BUG,
	second = POKEMON_TYPE_POISON
}

pokemon.pokedexInformation = {
	nationalNumber = 13,
	description = "Beware of the sharp stinger on its head. It hides in grass and bushes where it eats leaves.",
	height = 0.3,
	weight = 3.2,
}

pokemon.evolutions = {
	{ name = "kakuna", stone = "insect stone", level = 7 }
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
	{ text = "Weedle!", yell = false },
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
