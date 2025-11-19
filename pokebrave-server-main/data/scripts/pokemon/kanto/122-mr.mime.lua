local pType = Game.createPokemonType("Mr. Mime")
local pokemon = { }

pokemon.description = "an Mr. Mime"
pokemon.experience = 161
pokemon.portrait = 2417
pokemon.corpse = 2612

pokemon.outfit = {
	lookType = 122
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 100,
}

pokemon.baseStats = {
	health = 40,
	attack = 45,
	defense = 65,
	specialAttack = 100,
	specialDefense = 120,
	speed = 90
}

pokemon.types = {
	first = POKEMON_TYPE_PSYCHIC,
	second = POKEMON_TYPE_FAIRY
}

pokemon.pokedexInformation = {
	nationalNumber = 122,
	description = "It is a pantomime expert that can create invisible but solid walls using miming gestures.",
	height = 1.3,
	weight = 54.5,
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
	{ text = "Mr. Mimee!", yell = false },
	{ text = "Mimee!", yell = false },
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
