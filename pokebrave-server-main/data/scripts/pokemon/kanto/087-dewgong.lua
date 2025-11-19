local pType = Game.createPokemonType("Dewgong")
local pokemon = { }

pokemon.description = "an Dewgong"
pokemon.experience = 166
pokemon.portrait = 2382
pokemon.corpse = 2548

pokemon.outfit = {
	lookType = 87
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 34,
	max = 100,
}

pokemon.baseStats = {
	health = 90,
	attack = 70,
	defense = 80,
	specialAttack = 70,
	specialDefense = 95,
	speed = 70
}

pokemon.types = {
	first = POKEMON_TYPE_WATER,
	second = POKEMON_TYPE_ICE,
}

pokemon.pokedexInformation = {
	nationalNumber = 87,
	description = "Its entire body is a snowy white. Unharmed by even intense cold, it swims powerfully in icy waters.",
	height = 1.7,
	weight = 120.0,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 175,
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
	{ text = "Deew!", yell = false },
	{ text = "Deewgong!", yell = false },
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
