local pType = Game.createPokemonType("Hitmonlee")
local pokemon = { }

pokemon.description = "an Hitmonlee"
pokemon.experience = 159
pokemon.portrait = 2401
pokemon.corpse = 2567

pokemon.outfit = {
	lookType = 106
}

pokemon.gender = {
	malePercent = 100,
	femalePercent = 0
}

pokemon.spawnLevel = {
	min = 1,
	max = 100,
}

pokemon.baseStats = {
	health = 50,
	attack = 120,
	defense = 53,
	specialAttack = 35,
	specialDefense = 110,
	speed = 87
}

pokemon.types = {
	first = POKEMON_TYPE_FIGHTING,
}

pokemon.pokedexInformation = {
	nationalNumber = 106,
	description = "This amazing Pokémon has an awesome sense of balance. It can kick in succession from any position.",
	height = 1.5,
	weight = 49.8,
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
	{ text = "Hitmonlee!", yell = false },
	{ text = "Leee!", yell = false },
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
