local pType = Game.createPokemonType("Nidorino")
local pokemon = { }

pokemon.description = "an Nidorino"
pokemon.experience = 128
pokemon.portrait = 2328
pokemon.corpse = 26894

pokemon.outfit = {
	lookType = 33
}

pokemon.gender = {
	malePercent = 100,
	femalePercent = 0
}

pokemon.spawnLevel = {
	min = 16,
	max = 35,
}

pokemon.baseStats = {
	health = 61,
	attack = 72,
	defense = 57,
	specialAttack = 55,
	specialDefense = 55,
	speed = 65
}

pokemon.types = {
	first = POKEMON_TYPE_POISON,
}

pokemon.pokedexInformation = {
	nationalNumber = 33,
	description = "With a horn that’s harder than diamond, this Pokémon goes around shattering boulders as it searches for a moon stone.",
	height = 0.9,
	weight = 19.5,
}

pokemon.evolutions = {
	{ name = "nidoking", stone = "moon stone" }
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
	{ text = "Nidorinoo!", yell = false },
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
