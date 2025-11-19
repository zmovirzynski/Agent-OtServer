local pType = Game.createPokemonType("Bulbasaur")
local pokemon = { }

pokemon.description = "an Bulbasaur"
pokemon.experience = 64
pokemon.portrait = 2296
pokemon.corpse = 26862

pokemon.outfit = {
	lookType = 1
}

pokemon.gender = {
	malePercent = 87.5,
	femalePercent = 12.5
}

pokemon.spawnLevel = {
	min = 15,
	max = 22,
}

pokemon.baseStats = {
	health = 45,
	attack = 49,
	defense = 49,
	specialAttack = 65,
	specialDefense = 65,
	speed = 45
}

pokemon.types = {
	first = POKEMON_TYPE_GRASS,
	second = POKEMON_TYPE_POISON,
}

pokemon.pokedexInformation = {
	nationalNumber = 1,
	description = "There is a plant seed on its back right from the day this Pokémon is born. The seed slowly grows larger.",
	height = 0.7,
	weight = 6.9,
}

pokemon.evolutions = {
	{ name = "ivysaur", stone = "leaf stone", level = 16 }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 99,
	requiredLevel = 1,
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
	{ text = "Bulbasaur!", yell = false },
	{ text = "Saar!", yell = false }
}

pokemon.loot = {

}

pokemon.moves = {
	{ id = 1, name = "tackle", level = 1 },
	{ id = 2, name = "leech seed", level = 9 },
	{ id = 3, name = "razor leaf", level = 12 },
	{ id = 4, name = "vine whip", level = 1},
	{ id = 5, name = "poison powder", level = 1},
	{ id = 6, name = "seed bomb", level = 1},
}

pokemon.attacks = {
	{ name = "melee", minDamage = 0, maxDamage = -8, interval = 2*1000 },
}

pokemon.defenses = {
	defense = 1,
	armor = 1,
}

pokemon.elements = {
	{ type = COMBAT_FIREDAMAGE, percent = EFFECTIVE_ELEMENT },
	{ type = COMBAT_FLYINGDAMAGE, percent = EFFECTIVE_ELEMENT },
	{ type = COMBAT_ICEDAMAGE, percent = EFFECTIVE_ELEMENT },
	{ type = COMBAT_PSYCHICDAMAGE, percent = EFFECTIVE_ELEMENT },
	{ type = COMBAT_GRASSDAMAGE, percent = SUPER_INEFFECTIVE_ELEMENT },
	{ type = COMBAT_FIGHTINGDAMAGE, percent = INEFFECTIVE_ELEMENT },
	{ type = COMBAT_ELETRICDAMAGE, percent = INEFFECTIVE_ELEMENT },
	{ type = COMBAT_FAIRYDAMAGE, percent = INEFFECTIVE_ELEMENT },
	{ type = COMBAT_WATERDAMAGE, percent = INEFFECTIVE_ELEMENT },
}

pokemon.immunities = {
    combats = { },
    conditions = { },
}

pokemon.learnableTMs = {
	{ move = "flamethrower" }
}

pokemon.learnableHMs = {

}

pType:register(pokemon)
