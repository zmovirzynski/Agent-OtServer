local pType = Game.createPokemonType("Butterfree")
local pokemon = { }

pokemon.description = "an Butterfree"
pokemon.experience = 178
pokemon.portrait = 2307
pokemon.corpse = 26873

pokemon.outfit = {
	lookType = 12
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 5,
	max = 20
}

pokemon.baseStats = {
	health = 60,
	attack = 45,
	defense = 50,
	specialAttack = 90,
	specialDefense = 80,
	speed = 70
}

pokemon.types = {
	first = POKEMON_TYPE_BUG,
	second = POKEMON_TYPE_FLYING
}

pokemon.pokedexInformation = {
	nationalNumber = 12,
	description = "It loves the nectar of flowers and can locate flower patches that have even tiny amounts of pollen.",
	height = 1.1,
	weight = 32.0,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 119,
	requiredLevel = 1,
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
	{ text = "Butterfree!", yell = false },
	{ text = "Free!", yell = false },
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
