local pType = Game.createPokemonType("Psyduck")
local pokemon = { }

pokemon.description = "an Psyduck"
pokemon.experience = 64
pokemon.portrait = 2349
pokemon.corpse = 2515

pokemon.outfit = {
	lookType = 54
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 32,
}

pokemon.baseStats = {
	health = 50,
	attack = 52,
	defense = 48,
	specialAttack = 65,
	specialDefense = 50,
	speed = 55
}

pokemon.types = {
	first = POKEMON_TYPE_WATER,
}

pokemon.pokedexInformation = {
	nationalNumber = 54,
	description = "It is constantly wracked by a headache. When the headache turns intense, it begins using mysterious powers.",
	height = 0.8,
	weight = 19.6,
}

pokemon.evolutions = {
	{ name = "golduck", stone = "water stone", level = 33 }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 352,
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
	{ text = "Psyy!", yell = false },
	{ text = "Psyduuck!", yell = false },
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
