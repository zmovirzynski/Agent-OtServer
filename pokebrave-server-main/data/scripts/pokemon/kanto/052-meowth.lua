local pType = Game.createPokemonType("Meowth")
local pokemon = { }

pokemon.description = "an Meowth"
pokemon.experience = 58
pokemon.portrait = 2347
pokemon.corpse = 2513

pokemon.outfit = {
	lookType = 52
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
	health = 40,
	attack = 45,
	defense = 35,
	specialAttack = 40,
	specialDefense = 40,
	speed = 90
}

pokemon.types = {
	first = POKEMON_TYPE_NORMAL,
}

pokemon.pokedexInformation = {
	nationalNumber = 52,
	description = "All it does is sleep during the daytime. At night, it patrols its territory with its eyes aglow.",
	height = 0.4,
	weight = 4.2,
}

pokemon.evolutions = {
	{ name = "persian", stone = "heart stone", level = 28 }
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
	{ text = "Meoow!", yell = false },
	{ text = "Meowth!", yell = false },
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
