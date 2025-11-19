local pType = Game.createPokemonType("Articuno")
local pokemon = { }

pokemon.description = "an Articuno"
pokemon.experience = 290
pokemon.portrait = 2439
pokemon.corpse = 2604

pokemon.outfit = {
	lookType = 144
}

pokemon.gender = {
	malePercent = 0,
	femalePercent = 0
}

pokemon.spawnLevel = {
	min = 50,
	max = 100,
}

pokemon.baseStats = {
	health = 90,
	attack = 85,
	defense = 100,
	specialAttack = 95,
	specialDefense = 125,
	speed = 85
}

pokemon.types = {
	first = POKEMON_TYPE_ICE,
	second = POKEMON_TYPE_FLYING,
}

pokemon.pokedexInformation = {
	nationalNumber = 144,
	description = "This legendary bird Pokémon can create blizzards by freezing moisture in the air.",
	height = 1.7,
	weight = 55.4,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 16,
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
	{ text = "Articunoo!", yell = false },
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
