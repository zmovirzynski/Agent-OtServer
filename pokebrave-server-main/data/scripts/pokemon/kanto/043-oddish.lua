local pType = Game.createPokemonType("Oddish")
local pokemon = { }

pokemon.description = "an Oddish"
pokemon.experience = 64
pokemon.portrait = 2338
pokemon.corpse = 2504

pokemon.outfit = {
	lookType = 43
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 20,
}

pokemon.baseStats = {
	health = 45,
	attack = 50,
	defense = 55,
	specialAttack = 75,
	specialDefense = 65,
	speed = 30
}

pokemon.types = {
	first = POKEMON_TYPE_GRASS,
	second = POKEMON_TYPE_POISON,
}

pokemon.pokedexInformation = {
	nationalNumber = 43,
	description = "If exposed to moonlight, it starts to move. It roams far and wide at night to scatter its seeds.",
	height = 0.5,
	weight = 5.4,
}

pokemon.evolutions = {
	{ name = "gloom", stone = "leaf stone", level = 21 }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 439,
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
	{ text = "Oddish!!", yell = false },
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
