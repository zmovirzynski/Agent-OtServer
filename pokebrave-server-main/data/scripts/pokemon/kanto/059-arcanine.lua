local pType = Game.createPokemonType("Arcanine")
local pokemon = { }

pokemon.description = "an Arcanine"
pokemon.experience = 194
pokemon.portrait = 2354
pokemon.corpse = 2520

pokemon.outfit = {
	lookType = 59
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
	health = 90,
	attack = 110,
	defense = 80,
	specialAttack = 100,
	specialDefense = 80,
	speed = 95
}

pokemon.types = {
	first = POKEMON_TYPE_FIRE,
}

pokemon.pokedexInformation = {
	nationalNumber = 59,
	description = "An ancient picture scroll shows that people were captivated by its movement as it ran through prairies.",
	height = 1.9,
	weight = 155.0,
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
	{ text = "Arcaninee!", yell = false },
}

pokemon.loot = {

}

pokemon.moves = {
	{ id = 1, name = "flamethrower", level = 1 }
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
