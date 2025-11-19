local pType = Game.createPokemonType("Clefairy")
local pokemon = { }

pokemon.description = "an Clefairy"
pokemon.experience = 113
pokemon.portrait = 2330
pokemon.corpse = 26896

pokemon.outfit = {
	lookType = 35
}

pokemon.gender = {
	malePercent = 25,
	femalePercent = 75
}

pokemon.spawnLevel = {
	min = 1,
	max = 100,
}

pokemon.baseStats = {
	health = 70,
	attack = 45,
	defense = 48,
	specialAttack = 60,
	specialDefense = 65,
	speed = 35
}

pokemon.types = {
	first = POKEMON_TYPE_FAIRY,
}

pokemon.pokedexInformation = {
	nationalNumber = 35,
	description = "It is said that happiness will come to those who see a gathering of Clefairy dancing under a full moon.",
	height = 0.6,
	weight = 7.5,
}

pokemon.evolutions = {
	{ name = "clefable", stone = "fairy stone" }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 295,
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
	{ text = "Fairyy!", yell = false },
	{ text = "Clefaa!", yell = false },
	{ text = "Clefaairy!", yell = false },
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
