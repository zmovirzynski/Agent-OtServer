local pType = Game.createPokemonType("Omanyte")
local pokemon = { }

pokemon.description = "an Omanyte"
pokemon.experience = 71
pokemon.portrait = 2433
pokemon.corpse = 2598

pokemon.outfit = {
	lookType = 138
}

pokemon.gender = {
	malePercent = 87.5,
	femalePercent = 12.5
}

pokemon.spawnLevel = {
	min = 1,
	max = 39,
}

pokemon.baseStats = {
	health = 35,
	attack = 40,
	defense = 100,
	specialAttack = 90,
	specialDefense = 55,
	speed = 35
}

pokemon.types = {
	first = POKEMON_TYPE_ROCK,
	second = POKEMON_TYPE_WATER,
}

pokemon.pokedexInformation = {
	nationalNumber = 138,
	description = "Because some Omanyte manage to escape after being restored or are released into the wild by people, this species is becoming a problem.",
	height = 0.4,
	weight = 7.5,
}

pokemon.evolutions = {
	{ name = "omastar", stone = "water stone", level = 40 }
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
	{ text = "Omanytee!", yell = false },
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
