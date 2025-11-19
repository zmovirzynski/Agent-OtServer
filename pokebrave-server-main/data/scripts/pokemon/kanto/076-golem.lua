local pType = Game.createPokemonType("Golem")
local pokemon = { }

pokemon.description = "an Golem"
pokemon.experience = 223
pokemon.portrait = 2371
pokemon.corpse = 2537

pokemon.outfit = {
	lookType = 76
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 36,
	max = 100,
}

pokemon.baseStats = {
	health = 80,
	attack = 120,
	defense = 130,
	specialAttack = 55,
	specialDefense = 65,
	speed = 45
}

pokemon.types = {
	first = POKEMON_TYPE_ROCK,
	second = POKEMON_TYPE_GROUND,
}

pokemon.pokedexInformation = {
	nationalNumber = 76,
	description = "Once it sheds its skin, its body turns tender and whitish. Its hide hardens when it’s exposed to air.",
	height = 1.4,
	weight = 300.0,
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
	{ text = "Goleem!", yell = false },
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
