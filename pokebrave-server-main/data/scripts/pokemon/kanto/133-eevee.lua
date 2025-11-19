local pType = Game.createPokemonType("Eevee")
local pokemon = { }

pokemon.description = "an Eevee"
pokemon.experience = 65
pokemon.portrait = 2428
pokemon.corpse = 2593

pokemon.outfit = {
	lookType = 133
}

pokemon.gender = {
	malePercent = 87.5,
	femalePercent = 12.5
}

pokemon.spawnLevel = {
	min = 1,
	max = 35,
}

pokemon.baseStats = {
	health = 55,
	attack = 55,
	defense = 50,
	specialAttack = 45,
	specialDefense = 65,
	speed = 55
}

pokemon.types = {
	first = POKEMON_TYPE_NORMAL,
}

pokemon.pokedexInformation = {
	nationalNumber = 133,
	description = "Its ability to evolve into many forms allows it to adapt smoothly and perfectly to any environment.",
	height = 0.3,
	weight = 6.5,
}

pokemon.evolutions = {
	{ name = "vaporeon", stone = "water stone" },
	{ name = "jolteon", stone = "thunder stone" },
	{ name = "flareon", stone = "fire stone" },
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
	{ text = "Eeveee!", yell = false },
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
