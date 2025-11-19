local pType = Game.createPokemonType("Magnemite")
local pokemon = { }

pokemon.description = "an Magnemite"
pokemon.experience = 65
pokemon.portrait = 2376
pokemon.corpse = 2542

pokemon.outfit = {
	lookType = 81
}

pokemon.gender = {
	malePercent = 0,
	femalePercent = 0
}

pokemon.spawnLevel = {
	min = 1,
	max = 29,
}

pokemon.baseStats = {
	health = 25,
	attack = 35,
	defense = 70,
	specialAttack = 95,
	specialDefense = 55,
	speed = 45
}

pokemon.types = {
	first = POKEMON_TYPE_ELETRIC,
	second = POKEMON_TYPE_STEEL,
}

pokemon.pokedexInformation = {
	nationalNumber = 81,
	description = "The electromagnetic waves emitted by the units at the sides of its head expel antigravity, which allows it to float.",
	height = 0.3,
	weight = 6.0,
}

pokemon.evolutions = {
	{ name = "magneton", stone = "thunder stone", level = 30 }
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
	{ text = "Magnemitee!", yell = false },
	{ text = "Mitee!", yell = false },
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
