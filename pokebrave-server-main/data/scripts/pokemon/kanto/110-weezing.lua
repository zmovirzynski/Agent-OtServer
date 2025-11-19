local pType = Game.createPokemonType("Weezing")
local pokemon = { }

pokemon.description = "an Weezing"
pokemon.experience = 172
pokemon.portrait = 2405
pokemon.corpse = 2571

pokemon.outfit = {
	lookType = 110
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 35,
	max = 100,
}

pokemon.baseStats = {
	health = 65,
	attack = 90,
	defense = 120,
	specialAttack = 85,
	specialDefense = 70,
	speed = 60
}

pokemon.types = {
	first = POKEMON_TYPE_POISON,
}

pokemon.pokedexInformation = {
	nationalNumber = 110,
	description = "It grows by feeding on gases released by garbage. Though very rare, triplets have been found.",
	height = 1.2,
	weight = 9.5,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 148,
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
	{ text = "Weeziing!", yell = false },
	{ text = "Weee!", yell = false },
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
