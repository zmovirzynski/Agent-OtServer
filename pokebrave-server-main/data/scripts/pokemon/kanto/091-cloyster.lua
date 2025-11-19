local pType = Game.createPokemonType("Cloyster")
local pokemon = { }

pokemon.description = "an Cloyster"
pokemon.experience = 184
pokemon.portrait = 2386
pokemon.corpse = 2552

pokemon.outfit = {
	lookType = 91
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
	health = 50,
	attack = 95,
	defense = 180,
	specialAttack = 85,
	specialDefense = 45,
	speed = 70
}

pokemon.types = {
	first = POKEMON_TYPE_WATER,
	second = POKEMON_TYPE_ICE
}

pokemon.pokedexInformation = {
	nationalNumber = 91,
	description = "Cloyster that live in seas with harsh tidal currents grow large, sharp spikes on their shells.",
	height = 1.5,
	weight = 132.5,
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
	{ text = "Cloysteer!", yell = false },
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
