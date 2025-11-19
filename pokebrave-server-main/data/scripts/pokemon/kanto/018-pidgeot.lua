local pType = Game.createPokemonType("Pidgeot")
local pokemon = { }

pokemon.description = "an Pidgeot"
pokemon.experience = 216
pokemon.portrait = 2313
pokemon.corpse = 26879

pokemon.outfit = {
	lookType = 18
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 36,
	max = 100,
}

pokemon.baseStats = {
	health = 83,
	attack = 80,
	defense = 75,
	specialAttack = 70,
	specialDefense = 70,
	speed = 101
}

pokemon.types = {
	first = POKEMON_TYPE_NORMAL,
	second = POKEMON_TYPE_FLYING
}

pokemon.pokedexInformation = {
	nationalNumber = 18,
	description = "This Pokémon flies at Mach 2 speed, seeking prey. Its large talons are feared as wicked weapons.",
	height = 1.5,
	weight = 39.5,
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
	{ text = "Pidgeoot!", yell = false },
	{ text = "Geoot!", yell = false },
}

pokemon.loot = {

}

pokemon.moves = {
	{id = 1, name = "whirlwind", level = 1},
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
