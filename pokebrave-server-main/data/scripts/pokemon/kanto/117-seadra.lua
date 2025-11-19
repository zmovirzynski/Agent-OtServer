local pType = Game.createPokemonType("Seadra")
local pokemon = { }

pokemon.description = "an Seadra"
pokemon.experience = 154
pokemon.portrait = 2412
pokemon.corpse = 2578

pokemon.outfit = {
	lookType = 117
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 32,
	max = 100,
}

pokemon.baseStats = {
	health = 55,
	attack = 65,
	defense = 95,
	specialAttack = 95,
	specialDefense = 45,
	speed = 85
}

pokemon.types = {
	first = POKEMON_TYPE_WATER
}

pokemon.pokedexInformation = {
	nationalNumber = 117,
	description = "It’s the males that raise the offspring. While Seadra are raising young, the spines on their backs secrete thicker and stronger poison.",
	height = 1.2,
	weight = 25.0,
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
	{ text = "Seaadra!", yell = false },
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
