local pType = Game.createPokemonType("Snorlax")
local pokemon = { }

pokemon.description = "an Snorlax"
pokemon.experience = 189
pokemon.portrait = 2438
pokemon.corpse = 2603

pokemon.outfit = {
	lookType = 143
}

pokemon.gender = {
	malePercent = 87.5,
	femalePercent = 12.5
}

pokemon.spawnLevel = {
	min = 40,
	max = 100,
}

pokemon.baseStats = {
	health = 160,
	attack = 110,
	defense = 65,
	specialAttack = 65,
	specialDefense = 110,
	speed = 30
}

pokemon.types = {
	first = POKEMON_TYPE_NORMAL,
}

pokemon.pokedexInformation = {
	nationalNumber = 143,
	description = "Its stomach can digest any kind of food, even if it happens to be moldy or rotten.",
	height = 2.1,
	weight = 460.0,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 77,
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
	{ text = "Snorlaax!", yell = false },
	{ text = "Laax!", yell = false },
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
