local pType = Game.createPokemonType("Jigglypuff")
local pokemon = { }

pokemon.description = "an Jigglypuff"
pokemon.experience = 95
pokemon.portrait = 2334
pokemon.corpse = 2500

pokemon.outfit = {
	lookType = 39
}

pokemon.gender = {
	malePercent = 25,
	femalePercent = 75
}

pokemon.spawnLevel = {
	min = 1,
	max = 100,
}

pokemon.baseStats = {
	health = 115,
	attack = 45,
	defense = 20,
	specialAttack = 45,
	specialDefense = 25,
	speed = 20
}

pokemon.types = {
	first = POKEMON_TYPE_NORMAL,
	second = POKEMON_TYPE_FAIRY,
}

pokemon.pokedexInformation = {
	nationalNumber = 39,
	description = "When its huge eyes waver, it sings a mysteriously soothing melody that lulls its enemies to sleep.",
	height = 0.5,
	weight = 5.5,
}

pokemon.evolutions = {
	{ name = "wigglytuff", stone = "heart stone" }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 324,
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
	{ text = "Puff!!", yell = false },
	{ text = "Jiggly!", yell = false },
	{ text = "Jigglypuff!", yell = false },
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
