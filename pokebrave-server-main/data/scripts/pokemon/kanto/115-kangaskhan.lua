local pType = Game.createPokemonType("Kangaskhan")
local pokemon = { }

pokemon.description = "an Kangaskhan"
pokemon.experience = 172
pokemon.portrait = 2410
pokemon.corpse = 2576

pokemon.outfit = {
	lookType = 115
}

pokemon.gender = {
	malePercent = 0,
	femalePercent = 100
}

pokemon.spawnLevel = {
	min = 1,
	max = 100,
}

pokemon.baseStats = {
	health = 105,
	attack = 95,
	defense = 80,
	specialAttack = 40,
	specialDefense = 80,
	speed = 90
}

pokemon.types = {
	first = POKEMON_TYPE_NORMAL
}

pokemon.pokedexInformation = {
	nationalNumber = 115,
	description = "Although it’s carrying its baby in a pouch on its belly, Kangaskhan is swift on its feet. It intimidates its opponents with quick jabs.",
	height = 2.2,
	weight = 80.0,
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
	{ text = "Kaaan!", yell = false },
	{ text = "Kanghaskaan!", yell = false },
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
