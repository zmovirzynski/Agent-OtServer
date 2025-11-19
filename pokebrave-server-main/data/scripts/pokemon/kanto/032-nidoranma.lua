local pType = Game.createPokemonType("Nidoranma")
local pokemon = { }

pokemon.description = "an Nidoranma"
pokemon.experience = 55
pokemon.portrait = 2327
pokemon.corpse = 26893

pokemon.outfit = {
	lookType = 32
}

pokemon.gender = {
	malePercent = 100,
	femalePercent = 0
}

pokemon.spawnLevel = {
	min = 1,
	max = 15,
}

pokemon.baseStats = {
	health = 46,
	attack = 57,
	defense = 40,
	specialAttack = 40,
	specialDefense = 40,
	speed = 50
}

pokemon.types = {
	first = POKEMON_TYPE_POISON,
}

pokemon.pokedexInformation = {
	nationalNumber = 32,
	description = "The horn on a male Nidoran’s forehead contains a powerful poison. This is a very cautious Pokémon, always straining its large ears.",
	height = 0.5,
	weight = 9.0,
}

pokemon.evolutions = {
	{ name = "nidorino", stone = "moon stone", level = 16 }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 413,
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
	{ text = "Nidoraan!", yell = false },
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
