local pType = Game.createPokemonType("Magikarp")
local pokemon = { }

pokemon.description = "an Magikarp"
pokemon.experience = 40
pokemon.portrait = 2424
pokemon.corpse = 2589

pokemon.outfit = {
	lookType = 129
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
	health = 20,
	attack = 10,
	defense = 55,
	specialAttack = 15,
	specialDefense = 20,
	speed = 80
}

pokemon.types = {
	first = POKEMON_TYPE_WATER,
}

pokemon.pokedexInformation = {
	nationalNumber = 129,
	description = "An underpowered, pathetic Pokémon. It may jump high on rare occasions but never more than seven feet.",
	height = 0.9,
	weight = 10.0,
}

pokemon.evolutions = {
	{ name = "gyarados", stone = "crystal stone", level = 20 }
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
	{ text = "Magikaarp!", yell = false },
	{ text = "Magii!", yell = false },
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
