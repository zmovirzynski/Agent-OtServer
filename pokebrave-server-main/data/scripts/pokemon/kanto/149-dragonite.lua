local pType = Game.createPokemonType("Dragonite")
local pokemon = { }

pokemon.description = "an Dragonite"
pokemon.experience = 300
pokemon.portrait = 2444
pokemon.corpse = 2609

pokemon.outfit = {
	lookType = 149
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 55,
	max = 100,
}

pokemon.baseStats = {
	health = 91,
	attack = 134,
	defense = 95,
	specialAttack = 100,
	specialDefense = 100,
	speed = 80
}

pokemon.types = {
	first = POKEMON_TYPE_DRAGON,
	second = POKEMON_TYPE_FLYING
}

pokemon.pokedexInformation = {
	nationalNumber = 149,
	description = "It is said that somewhere in the ocean lies an island where these gather. Only they live there.",
	height = 2.2,
	weight = 210.0,
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
	{ text = "Dragoniite!", yell = false },
	{ text = "Dragoon!", yell = false },
	{ text = "Niiite!", yell = false },
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
