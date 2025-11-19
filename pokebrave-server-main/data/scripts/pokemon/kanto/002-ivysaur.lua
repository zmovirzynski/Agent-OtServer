local pType = Game.createPokemonType("Ivysaur")
local pokemon = { }

pokemon.description = "an Ivysaur"
pokemon.experience = 142
pokemon.portrait = 2297
pokemon.corpse = 26863

pokemon.outfit = {
	lookType = 2
}

pokemon.gender = {
	malePercent = 87.5,
	femalePercent = 12.5
}

pokemon.spawnLevel = {
	min = 16,
	max = 35
}

pokemon.baseStats = {
	health = 60,
	attack = 62,
	defense = 63,
	specialAttack = 80,
	specialDefense = 80,
	speed = 60
}

pokemon.types = {
	first = POKEMON_TYPE_GRASS,
	second = POKEMON_TYPE_POISON
}

pokemon.pokedexInformation = {
	nationalNumber = 2,
	description = "When the bulb on its back grows large, it appears to lose the ability to stand on its hind legs.",
	height = 1.0,
	weight = 13.0,
}

pokemon.evolutions = {
	{ name = "venusaur", stone = "leaf stone", level = 32 }
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
	{ text = "Ivysaur!", yell = false },
	{ text = "Saaur!", yell = false }
}

pokemon.loot = {

}

pokemon.moves = {
	{ id = 1, name = "vine whip", level = 1 },
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
