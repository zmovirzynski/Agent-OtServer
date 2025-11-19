local pType = Game.createPokemonType("Staryu")
local pokemon = { }

pokemon.description = "an Staryu"
pokemon.experience = 68
pokemon.portrait = 2415
pokemon.corpse = 2581

pokemon.outfit = {
	lookType = 120
}

pokemon.gender = {
	malePercent = 0,
	femalePercent = 0
}

pokemon.spawnLevel = {
	min = 1,
	max = 35,
}

pokemon.baseStats = {
	health = 30,
	attack = 45,
	defense = 55,
	specialAttack = 70,
	specialDefense = 55,
	speed = 85
}

pokemon.types = {
	first = POKEMON_TYPE_WATER
}

pokemon.pokedexInformation = {
	nationalNumber = 120,
	description = "If you visit a beach at the end of summer, you’ll be able to see groups of Staryu lighting up in a steady rhythm.",
	height = 0.8,
	weight = 34.5,
}

pokemon.evolutions = {
	{ name = "starmie", stone = "water stone" }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 399,
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
	{ text = "Staryuu!", yell = false },
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
