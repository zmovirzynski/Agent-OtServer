local pType = Game.createPokemonType("Machop")
local pokemon = { }

pokemon.description = "an Machop"
pokemon.experience = 61
pokemon.portrait = 2361
pokemon.corpse = 2527

pokemon.outfit = {
	lookType = 66
}

pokemon.gender = {
	malePercent = 75,
	femalePercent = 25
}

pokemon.spawnLevel = {
	min = 1,
	max = 27,
}

pokemon.baseStats = {
	health = 70,
	attack = 80,
	defense = 50,
	specialAttack = 35,
	specialDefense = 35,
	speed = 35
}

pokemon.types = {
	first = POKEMON_TYPE_FIGHTING,
}

pokemon.pokedexInformation = {
	nationalNumber = 66,
	description = "Its whole body is composed of muscles. Even though it’s the size of a human child, it can hurl 100 grown-ups.",
	height = 0.8,
	weight = 19.5,
}

pokemon.evolutions = {
	{ name = "machoke", stone = "punch stone", level = 28 }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 338,
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
	{ text = "Machoop!", yell = false },
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
