local pType = Game.createPokemonType("Persian")
local pokemon = { }

pokemon.description = "an Persian"
pokemon.experience = 154
pokemon.portrait = 2348
pokemon.corpse = 2514

pokemon.outfit = {
	lookType = 53
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 28,
	max = 100,
}

pokemon.baseStats = {
	health = 65,
	attack = 70,
	defense = 60,
	specialAttack = 65,
	specialDefense = 65,
	speed = 115
}

pokemon.types = {
	first = POKEMON_TYPE_NORMAL,
}

pokemon.pokedexInformation = {
	nationalNumber = 53,
	description = "Although its fur has many admirers, it is tough to raise as a pet because of its fickle meanness.",
	height = 1.0,
	weight = 32.0,
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
	{ text = "Persiaan!", yell = false },
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
