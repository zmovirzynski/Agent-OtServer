local pType = Game.createPokemonType("Diglett")
local pokemon = { }

pokemon.description = "an Diglett"
pokemon.experience = 53
pokemon.portrait = 2345
pokemon.corpse = 2511

pokemon.outfit = {
	lookType = 50
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 25,
}


pokemon.baseStats = {
	health = 10,
	attack = 55,
	defense = 25,
	specialAttack = 35,
	specialDefense = 45,
	speed = 95
}

pokemon.types = {
	first = POKEMON_TYPE_GROUND,
}

pokemon.pokedexInformation = {
	nationalNumber = 50,
	description = "It lives about one yard underground, where it feeds on plant roots. It sometimes appears aboveground.",
	height = 0.2,
	weight = 0.8,
}

pokemon.evolutions = {
	{ name = "dugtrio", stone = "earth stone", level = 26 }
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
	{ text = "Diggleet!", yell = false },
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
