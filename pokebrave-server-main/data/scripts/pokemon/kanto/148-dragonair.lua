local pType = Game.createPokemonType("Dragonair")
local pokemon = { }

pokemon.description = "an Dragonair"
pokemon.experience = 147
pokemon.portrait = 2443
pokemon.corpse = 2608

pokemon.outfit = {
	lookType = 148
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 30,
	max = 54,
}

pokemon.baseStats = {
	health = 61,
	attack = 84,
	defense = 65,
	specialAttack = 70,
	specialDefense = 70,
	speed = 70
}

pokemon.types = {
	first = POKEMON_TYPE_DRAGON,
}

pokemon.pokedexInformation = {
	nationalNumber = 148,
	description = "They say that if it emits an aura from its whole body, the weather will begin to change instantly.",
	height = 4.0,
	weight = 16.5,
}

pokemon.evolutions = {
	{ name = "dragonite", stone = "crystal stone", level = 55 }
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
	{ text = "Dragonaair!", yell = false },
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
