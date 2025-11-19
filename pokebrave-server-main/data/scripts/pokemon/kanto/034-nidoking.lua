local pType = Game.createPokemonType("Nidoking")
local pokemon = { }

pokemon.description = "an Nidoking"
pokemon.experience = 227
pokemon.portrait = 2329
pokemon.corpse = 26895

pokemon.outfit = {
	lookType = 34
}

pokemon.gender = {
	malePercent = 100,
	femalePercent = 0
}

pokemon.spawnLevel = {
	min = 36,
	max = 100,
}

pokemon.baseStats = {
	health = 81,
	attack = 102,
	defense = 77,
	specialAttack = 85,
	specialDefense = 75,
	speed = 85
}

pokemon.types = {
	first = POKEMON_TYPE_POISON,
	second = POKEMON_TYPE_GROUND
}

pokemon.pokedexInformation = {
	nationalNumber = 34,
	description = "When it goes on a rampage, it’s impossible to control. But in the presence of a Nidoqueen it’s lived with for a long time, Nidoking calms down.",
	height = 1.4,
	weight = 62.0,
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
	{ text = "Nidokiing!", yell = false },
	{ text = "Kiing!", yell = false },
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
