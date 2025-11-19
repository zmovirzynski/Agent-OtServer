local pType = Game.createPokemonType("Magmar")
local pokemon = { }

pokemon.description = "an Magmar"
pokemon.experience = 173
pokemon.portrait = 2421
pokemon.corpse = 2586

pokemon.outfit = {
	lookType = 126
}

pokemon.gender = {
	malePercent = 75,
	femalePercent = 25
}

pokemon.spawnLevel = {
	min = 30,
	max = 100,
}

pokemon.baseStats = {
	health = 65,
	attack = 95,
	defense = 57,
	specialAttack = 100,
	specialDefense = 85,
	speed = 93
}

pokemon.types = {
	first = POKEMON_TYPE_FIRE,
}

pokemon.pokedexInformation = {
	nationalNumber = 126,
	description = "Magmar dispatches its prey with fire. But it regrets this habit once it realizes that it has burned its intended prey to a charred crisp.",
	height = 1.3,
	weight = 44.5,
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
	{ text = "Magmaar!", yell = false },
	{ text = "Maag!", yell = false },
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
