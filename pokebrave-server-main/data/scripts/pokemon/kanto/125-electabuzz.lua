local pType = Game.createPokemonType("Electabuzz")
local pokemon = { }

pokemon.description = "an Electabuzz"
pokemon.experience = 172
pokemon.portrait = 2420
pokemon.corpse = 2585

pokemon.outfit = {
	lookType = 125
}

pokemon.gender = {
	malePercent = 75,
	femalePercent = 25
}

pokemon.spawnLevel = {
	min = 30,
	max = 100,
}

pokemon.baseStats = {
	health = 65,
	attack = 83,
	defense = 57,
	specialAttack = 95,
	specialDefense = 85,
	speed = 105
}

pokemon.types = {
	first = POKEMON_TYPE_ELETRIC,
}

pokemon.pokedexInformation = {
	nationalNumber = 125,
	description = "Many power plants keep Ground-type Pokémon around as a defense against Electabuzz that come seeking electricity.",
	height = 1.1,
	weight = 30.0,
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
	{ text = "Buzz!", yell = false },
	{ text = "Electabuuzz!", yell = false },
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
