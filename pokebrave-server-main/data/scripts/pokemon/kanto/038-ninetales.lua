local pType = Game.createPokemonType("Ninetales")
local pokemon = { }

pokemon.description = "an Ninetales"
pokemon.experience = 177
pokemon.portrait = 2333
pokemon.corpse = 26899

pokemon.outfit = {
	lookType = 38
}

pokemon.gender = {
	malePercent = 25,
	femalePercent = 75
}

pokemon.spawnLevel = {
	min = 36,
	max = 100,
}

pokemon.baseStats = {
	health = 73,
	attack = 76,
	defense = 75,
	specialAttack = 81,
	specialDefense = 100,
	speed = 100
}

pokemon.types = {
	first = POKEMON_TYPE_FIRE,
}

pokemon.pokedexInformation = {
	nationalNumber = 38,
	description = "It is said to live 1,000 years, and each of its tails is loaded with supernatural powers.",
	height = 1.1,
	weight = 19.9,
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
	{ text = "Talees!!", yell = false },
	{ text = "Ninetalees!", yell = false },
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
