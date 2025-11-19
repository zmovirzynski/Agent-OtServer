local pType = Game.createPokemonType("Hitmonchan")
local pokemon = { }

pokemon.description = "an Hitmonchan"
pokemon.experience = 159
pokemon.portrait = 2402
pokemon.corpse = 2568

pokemon.outfit = {
	lookType = 107
}

pokemon.gender = {
	malePercent = 100,
	femalePercent = 0
}

pokemon.spawnLevel = {
	min = 1,
	max = 100,
}

pokemon.baseStats = {
	health = 50,
	attack = 105,
	defense = 79,
	specialAttack = 35,
	specialDefense = 110,
	speed = 76
}

pokemon.types = {
	first = POKEMON_TYPE_FIGHTING,
}

pokemon.pokedexInformation = {
	nationalNumber = 107,
	description = "Its punches slice the air. They are launched at such high speed, even a slight graze could cause a burn.",
	height = 1.4,
	weight = 50.2,
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
	{ text = "Hitmonchaan!", yell = false },
	{ text = "Chaan!", yell = false },
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
