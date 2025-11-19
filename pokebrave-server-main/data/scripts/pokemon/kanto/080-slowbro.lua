local pType = Game.createPokemonType("Slowbro")
local pokemon = { }

pokemon.description = "an Slowbro"
pokemon.experience = 172
pokemon.portrait = 2375
pokemon.corpse = 2541

pokemon.outfit = {
	lookType = 80
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 37,
	max = 100,
}

pokemon.baseStats = {
	health = 95,
	attack = 75,
	defense = 110,
	specialAttack = 100,
	specialDefense = 80,
	speed = 30
}

pokemon.types = {
	first = POKEMON_TYPE_WATER,
	second = POKEMON_TYPE_PSYCHIC,
}

pokemon.pokedexInformation = {
	nationalNumber = 80,
	description = "When a Slowpoke went hunting in the sea, its tail was bitten by a Shellder. That made it evolve into Slowbro.",
	height = 1.6,
	weight = 78.5,
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
	{ text = "Slowbroo!", yell = false },
	{ text = "Sloow!", yell = false },
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
