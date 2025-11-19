local pType = Game.createPokemonType("Charmeleon")
local pokemon = { }

pokemon.description = "an Charmeleon"
pokemon.experience = 142
pokemon.portrait = 2300
pokemon.corpse = 26866

pokemon.outfit = {
	lookType = 5
}

pokemon.gender = {
	malePercent = 87.5,
	femalePercent = 12.5
}

pokemon.spawnLevel = {
	min = 16,
	max = 35
}

pokemon.baseStats = {
	health = 58,
	attack = 64,
	defense = 58,
	specialAttack = 80,
	specialDefense = 65,
	speed = 80
}

pokemon.types = {
	first = POKEMON_TYPE_FIRE,
}

pokemon.pokedexInformation = {
	nationalNumber = 5,
	description = "It has a barbaric nature. In battle, it whips its fiery tail around and slashes away with sharp claws.",
	height = 1.1,
	weight = 19.0,
}

pokemon.evolutions = {
	{ name = "charizard", stone = "fire stone", level = 36 }
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
	{ text = "Charmeleon!", yell = false },
	{ text = "Chaar!", yell = false }
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
