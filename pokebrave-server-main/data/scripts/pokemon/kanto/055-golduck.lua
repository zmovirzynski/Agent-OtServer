local pType = Game.createPokemonType("Golduck")
local pokemon = { }

pokemon.description = "an Golduck"
pokemon.experience = 175
pokemon.portrait = 2350
pokemon.corpse = 2516

pokemon.outfit = {
	lookType = 55
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 33,
	max = 100,
}

pokemon.baseStats = {
	health = 80,
	attack = 82,
	defense = 78,
	specialAttack = 95,
	specialDefense = 80,
	speed = 85
}

pokemon.types = {
	first = POKEMON_TYPE_WATER,
}

pokemon.pokedexInformation = {
	nationalNumber = 55,
	description = "When it swims at full speed using its long, webbed limbs, its forehead somehow begins to glow.",
	height = 1.7,
	weight = 76.6,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 175,
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
	{ text = "Goolduck!", yell = false },
	{ text = "Duuck!", yell = false },
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
