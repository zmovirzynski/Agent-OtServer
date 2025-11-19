local pType = Game.createPokemonType("Mankey")
local pokemon = { }

pokemon.description = "an Mankey"
pokemon.experience = 61
pokemon.portrait = 2351
pokemon.corpse = 2517

pokemon.outfit = {
	lookType = 56
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 27,
}

pokemon.baseStats = {
	health = 40,
	attack = 80,
	defense = 35,
	specialAttack = 35,
	specialDefense = 45,
	speed = 70
}

pokemon.types = {
	first = POKEMON_TYPE_FIGHTING,
}

pokemon.pokedexInformation = {
	nationalNumber = 56,
	description = "It lives in groups in the treetops. If it loses sight of its group, it becomes infuriated by its loneliness.",
	height = 0.5,
	weight = 28.0,
}

pokemon.evolutions = {
	{ name = "primeape", stone = "punch stone", level = 28 }
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
	{ text = "Mankeey!", yell = false },
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
