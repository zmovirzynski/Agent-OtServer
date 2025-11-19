local pType = Game.createPokemonType("Pinsir")
local pokemon = { }

pokemon.description = "an Pinsir"
pokemon.experience = 175
pokemon.portrait = 2422
pokemon.corpse = 2587

pokemon.outfit = {
	lookType = 127
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
	health = 65,
	attack = 125,
	defense = 100,
	specialAttack = 55,
	specialDefense = 70,
	speed = 85
}

pokemon.types = {
	first = POKEMON_TYPE_BUG,
}

pokemon.pokedexInformation = {
	nationalNumber = 127,
	description = "These Pokémon judge one another based on pincers. Thicker, more impressive pincers make for more popularity with the opposite gender.",
	height = 1.5,
	weight = 55.0,
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
	{ text = "Piin!", yell = false },
	{ text = "Piinsir!", yell = false },
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
