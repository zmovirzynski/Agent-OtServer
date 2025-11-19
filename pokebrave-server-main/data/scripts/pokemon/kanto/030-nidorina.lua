local pType = Game.createPokemonType("Nidorina")
local pokemon = { }

pokemon.description = "an Nidorina"
pokemon.experience = 128
pokemon.portrait = 2325
pokemon.corpse = 26891

pokemon.outfit = {
	lookType = 30
}

pokemon.gender = {
	malePercent = 0,
	femalePercent = 100
}

pokemon.spawnLevel = {
	min = 16,
	max = 35,
}

pokemon.baseStats = {
	health = 70,
	attack = 62,
	defense = 67,
	specialAttack = 55,
	specialDefense = 55,
	speed = 56
}

pokemon.types = {
	first = POKEMON_TYPE_POISON,
}

pokemon.pokedexInformation = {
	nationalNumber = 30,
	description = "The horn on its head has atrophied. It’s thought that this happens so Nidorina’s children won’t get poked while their mother is feeding them.",
	height = 0.8,
	weight = 20.0,
}

pokemon.evolutions = {
	{ name = "nidoqueen", stone = "moon stone" }
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
	{ text = "Nidorinaa!", yell = false },
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
