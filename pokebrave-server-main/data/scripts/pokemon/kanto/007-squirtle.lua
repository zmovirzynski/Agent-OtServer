local pType = Game.createPokemonType("Squirtle")
local pokemon = { }

pokemon.description = "an Squirtle"
pokemon.experience = 63
pokemon.portrait = 2302
pokemon.corpse = 26868

pokemon.outfit = {
	lookType = 7
}

pokemon.gender = {
	malePercent = 87.5,
	femalePercent = 12.5
}

pokemon.spawnLevel = {
	min = 10,
	max = 16,
}

pokemon.baseStats = {
	health = 44,
	attack = 48,
	defense = 65,
	specialAttack = 50,
	specialDefense = 64,
	speed = 43
}

pokemon.types = {
	first = POKEMON_TYPE_WATER,
}

pokemon.pokedexInformation = {
	nationalNumber = 7,
	description = "When it retracts its long neck into its shell, it squirts out water with vigorous force.",
	height = 0.5,
	weight = 9.0,
}

pokemon.evolutions = {
	{ name = "wartortle", stone = "water stone", level = 16 }
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
	{ text = "Squirtle!", yell = false },
}

pokemon.loot = {

}

pokemon.moves = {
	{ id = 1, name = "tackle", level = 1 },
	{ id = 2, name = "bubbles", level = 1},
	{ id = 3, name = "bubble beam", level = 1},
	{ id = 4, name = "water gun", level = 1},
	{ id = 5, name = "water ball", level = 1},
	{ id = 6, name = "water pulse", level = 1},
	{ id = 7, name = "waterfall", level = 1},
}

pokemon.attacks = {
	{ name = "melee", minDamage = 0, maxDamage = -8, interval = 2*1000 },
}

pokemon.defenses = {
	defense = 1,
	armor = 1,
}

pokemon.elements = {
	{ type = COMBAT_ELETRICDAMAGE, percent = EFFECTIVE_ELEMENT },
	{ type = COMBAT_GRASSDAMAGE, percent = EFFECTIVE_ELEMENT },
	{ type = COMBAT_FIREDAMAGE, percent = INEFFECTIVE_ELEMENT },
	{ type = COMBAT_WATERDAMAGE, percent = INEFFECTIVE_ELEMENT },
	{ type = COMBAT_STEELDAMAGE, percent = INEFFECTIVE_ELEMENT },
	{ type = COMBAT_ICEDAMAGE, percent = INEFFECTIVE_ELEMENT },
}

pokemon.immunities = {
    combats = { },
    conditions = { },
}

pokemon.learnableTMs = {

}

pokemon.learnableHMs = {

}

pType:register(pokemon)
