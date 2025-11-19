local pType = Game.createPokemonType("Mewtwo")
local pokemon = { }

pokemon.description = "an Mewtwo"
pokemon.experience = 340
pokemon.portrait = 2445
pokemon.corpse = 2610

pokemon.outfit = {
	lookType = 150
}

pokemon.gender = {
	malePercent = 0,
	femalePercent = 0
}

pokemon.spawnLevel = {
	min = 70,
	max = 100,
}

pokemon.baseStats = {
	health = 106,
	attack = 110,
	defense = 90,
	specialAttack = 154,
	specialDefense = 90,
	speed = 130
}

pokemon.types = {
	first = POKEMON_TYPE_PSYCHIC,
}

pokemon.pokedexInformation = {
	nationalNumber = 150,
	description = "Its DNA is almost the same as Mew’s. However, its size and disposition are vastly different.",
	height = 2.0,
	weight = 122.0,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 8,
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
	{ text = "Meew!", yell = false },
	{ text = "Mewtwoo!", yell = false },
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
