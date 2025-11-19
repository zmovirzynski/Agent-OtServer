local pType = Game.createPokemonType("Kadabra")
local pokemon = { }

pokemon.description = "an Kadabra"
pokemon.experience = 140
pokemon.portrait = 2359
pokemon.corpse = 2525

pokemon.outfit = {
	lookType = 64
}

pokemon.gender = {
	malePercent = 75,
	femalePercent = 25
}

pokemon.spawnLevel = {
	min = 16,
	max = 35,
}

pokemon.baseStats = {
	health = 40,
	attack = 35,
	defense = 30,
	specialAttack = 120,
	specialDefense = 70,
	speed = 105
}

pokemon.types = {
	first = POKEMON_TYPE_PSYCHIC,
}

pokemon.pokedexInformation = {
	nationalNumber = 64,
	description = "Using its psychic power, Kadabra levitates as it sleeps. It uses its springy tail as a pillow.",
	height = 1.3,
	weight = 56.5,
}

pokemon.evolutions = {
	{ name = "alakazam", stone = "psychic stone" }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 217,
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
	{ text = "Kadabraa!", yell = false },
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
