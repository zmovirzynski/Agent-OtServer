local pType = Game.createPokemonType("Voltorb")
local pokemon = { }

pokemon.description = "an Voltorb"
pokemon.experience = 66
pokemon.portrait = 2395
pokemon.corpse = 2561

pokemon.outfit = {
	lookType = 100
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 29,
}

pokemon.baseStats = {
	health = 40,
	attack = 30,
	defense = 50,
	specialAttack = 55,
	specialDefense = 55,
	speed = 100
}

pokemon.types = {
	first = POKEMON_TYPE_ELETRIC,
}

pokemon.pokedexInformation = {
	nationalNumber = 100,
	description = "It rolls to move. If the ground is uneven, a sudden jolt from hitting a bump can cause it to explode.",
	height = 0.5,
	weight = 10.4,
}

pokemon.evolutions = {
	{ name = "electrode", stone = "thunder stone", level = 30 }
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
	{ text = "Voltoorb!", yell = false },
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
