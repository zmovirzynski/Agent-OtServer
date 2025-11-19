local pType = Game.createPokemonType("Haunter")
local pokemon = { }

pokemon.description = "an Haunter"
pokemon.experience = 142
pokemon.portrait = 2388
pokemon.corpse = 2554

pokemon.outfit = {
	lookType = 93
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 25,
	max = 35,
}

pokemon.baseStats = {
	health = 45,
	attack = 50,
	defense = 45,
	specialAttack = 115,
	specialDefense = 55,
	speed = 95
}

pokemon.types = {
	first = POKEMON_TYPE_GHOST,
	second = POKEMON_TYPE_POISON
}

pokemon.pokedexInformation = {
	nationalNumber = 93,
	description = "It likes to lurk in the dark and tap shoulders with a gaseous hand. Its touch causes endless shuddering.",
	height = 1.6,
	weight = 0.1,
}

pokemon.evolutions = {
	{ name = "gengar", stone = "dusk stone" }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 201,
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
	{ text = "Haunteer!", yell = false },
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
