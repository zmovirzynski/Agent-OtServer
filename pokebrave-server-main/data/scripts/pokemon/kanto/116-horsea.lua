local pType = Game.createPokemonType("Horsea")
local pokemon = { }

pokemon.description = "an Horsea"
pokemon.experience = 59
pokemon.portrait = 2411
pokemon.corpse = 2577

pokemon.outfit = {
	lookType = 116
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 31,
}

pokemon.baseStats = {
	health = 30,
	attack = 40,
	defense = 70,
	specialAttack = 70,
	specialDefense = 25,
	speed = 60
}

pokemon.types = {
	first = POKEMON_TYPE_WATER
}

pokemon.pokedexInformation = {
	nationalNumber = 116,
	description = "Horsea makes its home in oceans with gentle currents. If this Pokémon is under attack, it spits out pitch-black ink and escapes.",
	height = 0.4,
	weight = 8.0,
}

pokemon.evolutions = {
	{ name = "seadra", stone = "water stone", level = 32 }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 399,
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
	{ text = "Horseaa!", yell = false },
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
