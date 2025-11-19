local pType = Game.createPokemonType("Tentacool")
local pokemon = { }

pokemon.description = "an Tentacool"
pokemon.experience = 67
pokemon.portrait = 2367
pokemon.corpse = 2533

pokemon.outfit = {
	lookType = 72
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 29,
}

pokemon.baseStats = {
	health = 40,
	attack = 40,
	defense = 35,
	specialAttack = 50,
	specialDefense = 100,
	speed = 70
}

pokemon.types = {
	first = POKEMON_TYPE_WATER,
	second = POKEMON_TYPE_POISON,
}

pokemon.pokedexInformation = {
	nationalNumber = 72,
	description = "Tentacool is not a particularly strong swimmer. It drifts across the surface of shallow seas as it searches for prey.",
	height = 0.9,
	weight = 45.5,
}

pokemon.evolutions = {
	{ name = "tentacruel", stone = "water stone", level = 30 }
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
	{ text = "Tentacool!", yell = false },
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
