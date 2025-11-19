local pType = Game.createPokemonType("Porygon")
local pokemon = { }

pokemon.description = "an Porygon"
pokemon.experience = 79
pokemon.portrait = 2432
pokemon.corpse = 2597

pokemon.outfit = {
	lookType = 137
}

pokemon.gender = {
	malePercent = 0,
	femalePercent = 0
}

pokemon.spawnLevel = {
	min = 36,
	max = 100,
}

pokemon.baseStats = {
	health = 65,
	attack = 60,
	defense = 70,
	specialAttack = 85,
	specialDefense = 75,
	speed = 40
}

pokemon.types = {
	first = POKEMON_TYPE_NORMAL,
}

pokemon.pokedexInformation = {
	nationalNumber = 137,
	description = "State-of-the-art technology was used to create Porygon. It was the first artificial Pokémon to be created via computer programming.",
	height = 0.8,
	weight = 36.5,
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
	{ text = "Porygoon!", yell = false },
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
