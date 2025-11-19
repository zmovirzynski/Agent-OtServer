local pType = Game.createPokemonType("Kabutops")
local pokemon = { }

pokemon.description = "an Kabutops"
pokemon.experience = 173
pokemon.portrait = 2436
pokemon.corpse = 2601

pokemon.outfit = {
	lookType = 141
}

pokemon.gender = {
	malePercent = 87.5,
	femalePercent = 12.5
}

pokemon.spawnLevel = {
	min = 40,
	max = 100,
}

pokemon.baseStats = {
	health = 60,
	attack = 115,
	defense = 105,
	specialAttack = 65,
	specialDefense = 70,
	speed = 80
}

pokemon.types = {
	first = POKEMON_TYPE_ROCK,
	second = POKEMON_TYPE_WATER,
}

pokemon.pokedexInformation = {
	nationalNumber = 141,
	description = "Kabutops slices its prey apart and sucks out the fluids. The discarded body parts become food for other Pokémon.",
	height = 1.3,
	weight = 40.5,
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
	{ text = "Kabutoops!", yell = false },
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
