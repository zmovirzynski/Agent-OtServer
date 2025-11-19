local pType = Game.createPokemonType("Metapod")
local pokemon = { }

pokemon.description = "an Metapod"
pokemon.experience = 72
pokemon.portrait = 2306
pokemon.corpse = 26872

pokemon.outfit = {
	lookType = 11
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 6,
	max = 9
}

pokemon.baseStats = {
	health = 50,
	attack = 20,
	defense = 55,
	specialAttack = 25,
	specialDefense = 25,
	speed = 30
}

pokemon.types = {
	first = POKEMON_TYPE_BUG,
}

pokemon.pokedexInformation = {
	nationalNumber = 11,
	description = "It is waiting for the moment to evolve. At this stage, it can only harden, so it remains motionless to avoid attack.",
	height = 0.7,
	weight = 9.9,
}

pokemon.evolutions = {
	{ name = "butterfree", stone = "insect stone", level = 10 }
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
	{ text = "Metapod!", yell = false },
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
