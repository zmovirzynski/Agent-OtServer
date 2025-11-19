local pType = Game.createPokemonType("Growlithe")
local pokemon = { }

pokemon.description = "an Growlithe"
pokemon.experience = 70
pokemon.portrait = 2353
pokemon.corpse = 2519

pokemon.outfit = {
	lookType = 58
}

pokemon.gender = {
	malePercent = 75,
	femalePercent = 25
}

pokemon.spawnLevel = {
	min = 1,
	max = 35,
}

pokemon.baseStats = {
	health = 55,
	attack = 70,
	defense = 45,
	specialAttack = 70,
	specialDefense = 50,
	speed = 60
}

pokemon.types = {
	first = POKEMON_TYPE_FIRE,
}

pokemon.pokedexInformation = {
	nationalNumber = 58,
	description = "It has a brave and trustworthy nature. It fearlessly stands up to bigger and stronger foes.",
	height = 0.7,
	weight = 19.0,
}

pokemon.evolutions = {
	{ name = "arcanine", stone = "fire stone" }
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
	{ text = "Groow!", yell = false },
	{ text = "Groowlithe!", yell = false },
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
