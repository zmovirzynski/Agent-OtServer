local pType = Game.createPokemonType("Pidgeotto")
local pokemon = { }

pokemon.description = "an Pidgeotto"
pokemon.experience = 122
pokemon.portrait = 2312
pokemon.corpse = 26878

pokemon.outfit = {
	lookType = 17
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 18,
	max = 35,
}

pokemon.baseStats = {
	health = 63,
	attack = 60,
	defense = 55,
	specialAttack = 50,
	specialDefense = 50,
	speed = 71
}

pokemon.types = {
	first = POKEMON_TYPE_NORMAL,
	second = POKEMON_TYPE_FLYING
}

pokemon.pokedexInformation = {
	nationalNumber = 17,
	description = "This Pokémon is full of vitality. It constantly flies around its large territory in search of prey.",
	height = 1.1,
	weight = 30.0,
}

pokemon.evolutions = {
	{ name = "pidgeot", stone = "heart stone", level = 36 }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 249,
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
	{ text = "Pidgeotto!", yell = false },
	{ text = "Piid!", yell = false },
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
