local pType = Game.createPokemonType("Poliwhirl")
local pokemon = { }

pokemon.description = "an Poliwrhil"
pokemon.experience = 135
pokemon.portrait = 2356
pokemon.corpse = 2522

pokemon.outfit = {
	lookType = 61
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 25,
	max = 35,
}

pokemon.baseStats = {
	health = 65,
	attack = 65,
	defense = 65,
	specialAttack = 50,
	specialDefense = 50,
	speed = 90
}

pokemon.types = {
	first = POKEMON_TYPE_WATER,
}

pokemon.pokedexInformation = {
	nationalNumber = 61,
	description = "Staring at the swirl on its belly causes drowsiness. This trait of Poliwhirl’s has been used in place of lullabies to get children to go to sleep.",
	height = 1.0,
	weight = 20.0,
}

pokemon.evolutions = {
	{ name = "poliwrhil", stone = "water stone" }
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
	{ text = "Poliwrhill!", yell = false },
	{ text = "Wrhill!", yell = false },
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
