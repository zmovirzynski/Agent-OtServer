local pType = Game.createPokemonType("Pidgey")
local pokemon = { }

pokemon.description = "an Pidgey"
pokemon.experience = 50
pokemon.portrait = 2311
pokemon.corpse = 26877

pokemon.outfit = {
	lookType = 16
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 3,
	max = 7,
}

pokemon.baseStats = {
	health = 40,
	attack = 45,
	defense = 40,
	specialAttack = 35,
	specialDefense = 35,
	speed = 56
}

pokemon.types = {
	first = POKEMON_TYPE_NORMAL,
	second = POKEMON_TYPE_FLYING
}

pokemon.pokedexInformation = {
	nationalNumber = 16,
	description = "Very docile. If attacked, it will often kick up sand to protect itself rather than fight back.",
	height = 0.3,
	weight = 1.8,
}

pokemon.evolutions = {
	{ name = "pidgeotto", stone = "heart stone", level = 18 }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 239,
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
	{ text = "Pidgey!", yell = false },
	{ text = "Piid!", yell = false },
}

pokemon.loot = {

}

pokemon.moves = {
	{ id = 1, name = "tackle", level = 1 },
	{ id = 2, name = "sand attack", level = 3 },
	{ id = 3, name = "gust", level = 5 },
	{ id = 4, name = "quick attack", level = 7 },
	{ id = 5, name = "agility", level = 12 },
	{ id = 6, name = "drill peck", level = 1 },
	{ id = 7, name = "air slash", level = 20 },
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
	{ type = COMBAT_ROCKDAMAGE, percent = EFFECTIVE_ELEMENT },
	{ type = COMBAT_ICEDAMAGE, percent = EFFECTIVE_ELEMENT },
	{ type = COMBAT_BUGDAMAGE, percent = INEFFECTIVE_ELEMENT },
	{ type = COMBAT_GRASSDAMAGE, percent = INEFFECTIVE_ELEMENT },
}

pokemon.immunities = {
    combats = {
        COMBAT_GHOSTDAMAGE,
		COMBAT_GROUNDDAMAGE,
    },
    conditions = { },
}

pokemon.learnableTMs = {

}

pokemon.learnableHMs = {

}

pType:register(pokemon)
