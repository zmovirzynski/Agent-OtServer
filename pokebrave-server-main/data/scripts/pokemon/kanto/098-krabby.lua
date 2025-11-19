local pType = Game.createPokemonType("Krabby")
local pokemon = { }

pokemon.description = "an Krabby"
pokemon.experience = 65
pokemon.portrait = 2393
pokemon.corpse = 2559

pokemon.outfit = {
	lookType = 98
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 27,
}

pokemon.baseStats = {
	health = 30,
	attack = 105,
	defense = 90,
	specialAttack = 25,
	specialDefense = 25,
	speed = 50
}

pokemon.types = {
	first = POKEMON_TYPE_WATER,
}

pokemon.pokedexInformation = {
	nationalNumber = 98,
	description = "It can be found near the sea. The large pincers grow back if they are torn out of their sockets.",
	height = 0.4,
	weight = 6.5,
}

pokemon.evolutions = {
	{ name = "kingler", stone = "water stone", level = 28 }
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
	{ text = "Krabby!", yell = false },
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
