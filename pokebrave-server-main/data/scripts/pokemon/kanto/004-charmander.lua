local pType = Game.createPokemonType("Charmander")
local pokemon = { }

pokemon.description = "an Charmander"
pokemon.experience = 62
pokemon.portrait = 2299
pokemon.corpse = 26865

pokemon.outfit = {
	lookType = 4
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
	health = 39,
	attack = 52,
	defense = 43,
	specialAttack = 60,
	specialDefense = 50,
	speed = 65
}

pokemon.types = {
	first = POKEMON_TYPE_FIRE,
}

pokemon.pokedexInformation = {
	nationalNumber = 4,
	description = "It has a preference for hot things. When it rains, steam is said to spout from the tip of its tail.",
	height = 0.6,
	weight = 8.5,
}

pokemon.evolutions = {
	{ name = "charmeleon", stone = "fire stone", level = 16 }
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
	{ text = "Charmander!", yell = false },
	{ text = "Mandeer!", yell = false }
}

pokemon.loot = {

}

pokemon.moves = {
	{ id = 1, name = "flamethrower", level = 1 },
	{ id = 2, name = "ember", level = 1},
	{ id = 3, name = "scratch", level = 1},
	{ id = 4, name = "fire ball", level = 1},
}

pokemon.attacks = {
	{ name = "melee", minDamage = 0, maxDamage = -8, interval = 2*1000 },
}

pokemon.defenses = {
	defense = 1,
	armor = 1,
}

pokemon.elements = {
    { type = COMBAT_WATERDAMAGE, percent = EFFECTIVE_ELEMENT },
    { type = COMBAT_GROUNDDAMAGE, percent = EFFECTIVE_ELEMENT },
    { type = COMBAT_ROCKDAMAGE, percent = EFFECTIVE_ELEMENT },
    { type = COMBAT_GRASSDAMAGE, percent = INEFFECTIVE_ELEMENT },
    { type = COMBAT_ICEDAMAGE, percent = INEFFECTIVE_ELEMENT },
    { type = COMBAT_FIREDAMAGE, percent = INEFFECTIVE_ELEMENT },
	{ type = COMBAT_BUGDAMAGE, percent = INEFFECTIVE_ELEMENT },
    { type = COMBAT_STEELDAMAGE, percent = INEFFECTIVE_ELEMENT },
    { type = COMBAT_FAIRYDAMAGE, percent = INEFFECTIVE_ELEMENT },
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
