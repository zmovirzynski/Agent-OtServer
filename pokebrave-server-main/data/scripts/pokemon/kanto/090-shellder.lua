local pType = Game.createPokemonType("Shellder")
local pokemon = { }

pokemon.description = "an Shellder"
pokemon.experience = 61
pokemon.portrait = 2385
pokemon.corpse = 2551

pokemon.outfit = {
	lookType = 90
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 35,
}

pokemon.baseStats = {
	health = 30,
	attack = 65,
	defense = 100,
	specialAttack = 45,
	specialDefense = 25,
	speed = 40
}

pokemon.types = {
	first = POKEMON_TYPE_WATER,
}

pokemon.pokedexInformation = {
	nationalNumber = 90,
	description = "It is encased in a shell that is harder than diamond. Inside, however, it is surprisingly tender.",
	height = 0.3,
	weight = 4.0,
}

pokemon.evolutions = {
	{ name = "cloyster", stone = "water stone" }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 352,
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
	{ text = "Shell!", yell = false },
	{ text = "Shellder!", yell = false },
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
