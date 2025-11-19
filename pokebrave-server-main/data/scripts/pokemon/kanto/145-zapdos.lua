local pType = Game.createPokemonType("Zapdos")
local pokemon = { }

pokemon.description = "an Zapdos"
pokemon.experience = 290
pokemon.portrait = 2440
pokemon.corpse = 2605

pokemon.outfit = {
	lookType = 145
}

pokemon.gender = {
	malePercent = 0,
	femalePercent = 0
}

pokemon.spawnLevel = {
	min = 50,
	max = 100,
}

pokemon.baseStats = {
	health = 90,
	attack = 90,
	defense = 85,
	specialAttack = 125,
	specialDefense = 90,
	speed = 100
}

pokemon.types = {
	first = POKEMON_TYPE_ELETRIC,
	second = POKEMON_TYPE_FLYING,
}

pokemon.pokedexInformation = {
	nationalNumber = 145,
	description = "This legendary Pokémon is said to live in thunderclouds. It freely controls lightning bolts.",
	height = 1.6,
	weight = 52.6,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 16,
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
	{ text = "Zapdoos!", yell = false },
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
