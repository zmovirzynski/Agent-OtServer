local pType = Game.createPokemonType("Alakazam")
local pokemon = { }

pokemon.description = "an Alakazam"
pokemon.experience = 225
pokemon.portrait = 2360
pokemon.corpse = 2526

pokemon.outfit = {
	lookType = 65
}

pokemon.gender = {
	malePercent = 75,
	femalePercent = 25
}

pokemon.spawnLevel = {
	min = 36,
	max = 100,
}

pokemon.baseStats = {
	health = 55,
	attack = 50,
	defense = 45,
	specialAttack = 135,
	specialDefense = 95,
	speed = 120
}

pokemon.types = {
	first = POKEMON_TYPE_PSYCHIC,
}

pokemon.pokedexInformation = {
	nationalNumber = 65,
	description = "It has an incredibly high level of intelligence. Some say that Alakazam remembers everything that ever happens to it, from birth till death.",
	height = 1.5,
	weight = 48.0,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 129,
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
	{ text = "Zaam!", yell = false },
	{ text = "Alakazaam!", yell = false },
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
