local pType = Game.createPokemonType("Raichu")
local pokemon = { }

pokemon.description = "an Raichu"
pokemon.experience = 243
pokemon.portrait = 2321
pokemon.corpse = 26887

pokemon.outfit = {
	lookType = 26
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 100,
}

pokemon.baseStats = {
	health = 60,
	attack = 90,
	defense = 55,
	specialAttack = 90,
	specialDefense = 80,
	speed = 110
}

pokemon.types = {
	first = POKEMON_TYPE_ELETRIC,
}

pokemon.pokedexInformation = {
	nationalNumber = 26,
	description = "Its tail discharges electricity into the ground, protecting it from getting shocked.",
	height = 0.8,
	weight = 30.0,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 175,
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
	{ text = "Raichu!", yell = false },
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
