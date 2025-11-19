local pType = Game.createPokemonType("Hypno")
local pokemon = { }

pokemon.description = "an Hypno"
pokemon.experience = 169
pokemon.portrait = 2392
pokemon.corpse = 2558

pokemon.outfit = {
	lookType = 97
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 26,
	max = 100,
}

pokemon.baseStats = {
	health = 85,
	attack = 73,
	defense = 70,
	specialAttack = 73,
	specialDefense = 115,
	speed = 67
}

pokemon.types = {
	first = POKEMON_TYPE_PSYCHIC,
}

pokemon.pokedexInformation = {
	nationalNumber = 97,
	description = "When it locks eyes with an enemy, it will use a mix of psi moves, such as Hypnosis and Confusion.",
	height = 1.6,
	weight = 75.6,
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
	{ text = "Hypnoo!", yell = false },
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
