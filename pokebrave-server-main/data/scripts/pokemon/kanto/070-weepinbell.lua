local pType = Game.createPokemonType("Weepinbell")
local pokemon = { }

pokemon.description = "an Weepinbell"
pokemon.experience = 137
pokemon.portrait = 2365
pokemon.corpse = 2531

pokemon.outfit = {
	lookType = 70
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 21,
	max = 35,
}

pokemon.baseStats = {
	health = 65,
	attack = 90,
	defense = 50,
	specialAttack = 85,
	specialDefense = 45,
	speed = 55
}

pokemon.types = {
	first = POKEMON_TYPE_GRASS,
	second = POKEMON_TYPE_POISON,
}

pokemon.pokedexInformation = {
	nationalNumber = 70,
	description = "When hungry, it swallows anything that moves. Its hapless prey is dissolved by strong acids.",
	height = 1.0,
	weight = 6.4,
}

pokemon.evolutions = {
	{ name = "victreebel", stone = "leaf stone" }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 249,
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
	{ text = "Beell!", yell = false },
	{ text = "Weepinbell!", yell = false },
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
