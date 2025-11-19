local pType = Game.createPokemonType("Kabuto")
local pokemon = { }

pokemon.description = "an Kabuto"
pokemon.experience = 71
pokemon.portrait = 2435
pokemon.corpse = 2600

pokemon.outfit = {
	lookType = 140
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
	health = 30,
	attack = 80,
	defense = 90,
	specialAttack = 55,
	specialDefense = 45,
	speed = 55
}

pokemon.types = {
	first = POKEMON_TYPE_ROCK,
	second = POKEMON_TYPE_WATER,
}

pokemon.pokedexInformation = {
	nationalNumber = 140,
	description = "This species is almost entirely extinct. Kabuto molt every three days, making their shells harder and harder.",
	height = 0.5,
	weight = 11.5,
}

pokemon.evolutions = {
	{ name = "kabutops", stone = "rock stone", level = 40 }
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
	{ text = "Kabutoo!", yell = false },
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
