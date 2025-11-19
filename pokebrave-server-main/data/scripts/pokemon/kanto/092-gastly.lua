local pType = Game.createPokemonType("Gastly")
local pokemon = { }

pokemon.description = "an Gastly"
pokemon.experience = 62
pokemon.portrait = 2387
pokemon.corpse = 2553

pokemon.outfit = {
	lookType = 92
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 24,
}

pokemon.baseStats = {
	health = 30,
	attack = 35,
	defense = 30,
	specialAttack = 100,
	specialDefense = 35,
	speed = 80
}

pokemon.types = {
	first = POKEMON_TYPE_GHOST,
	second = POKEMON_TYPE_POISON
}

pokemon.pokedexInformation = {
	nationalNumber = 92,
	description = "It wraps its opponent in its gas-like body, slowly weakening its prey by poisoning it through the skin.",
	height = 1.3,
	weight = 0.1,
}

pokemon.evolutions = {
	{ name = "haunter", stone = "dusk stone", level = 25 }
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
	{ text = "Gaastly!", yell = false },
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
