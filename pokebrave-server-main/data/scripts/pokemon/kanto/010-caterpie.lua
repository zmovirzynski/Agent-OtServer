local pType = Game.createPokemonType("Caterpie")
local pokemon = { }

pokemon.description = "an Caterpie"
pokemon.experience = 39
pokemon.portrait = 2305
pokemon.corpse = 26871

pokemon.outfit = {
	lookType = 10
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 6
}

pokemon.baseStats = {
	health = 45,
	attack = 30,
	defense = 35,
	specialAttack = 20,
	specialDefense = 20,
	speed = 45
}

pokemon.types = {
	first = POKEMON_TYPE_BUG,
}

pokemon.pokedexInformation = {
	nationalNumber = 10,
	description = "For protection, it releases a horrible stench from the antenna on its head to drive away enemies.",
	height = 0.3,
	weight = 2.9,
}

pokemon.evolutions = {
	{ name = "metapod", stone = "insect stone", level = 7 }
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
	{ text = "Caterpie!", yell = false },
	{ text = "Piee!", yell = false },
}

pokemon.loot = {

}

pokemon.moves = {
	{id = 1, name = "struggle bug", level = 1}
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
