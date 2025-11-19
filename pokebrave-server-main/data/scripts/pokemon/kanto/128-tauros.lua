local pType = Game.createPokemonType("Tauros")
local pokemon = { }

pokemon.description = "an Tauros"
pokemon.experience = 172
pokemon.portrait = 2423
pokemon.corpse = 2588

pokemon.outfit = {
	lookType = 128
}

pokemon.gender = {
	malePercent = 100,
	femalePercent = 0
}

pokemon.spawnLevel = {
	min = 36,
	max = 100,
}

pokemon.baseStats = {
	health = 75,
	attack = 100,
	defense = 95,
	specialAttack = 40,
	specialDefense = 70,
	speed = 110
}

pokemon.types = {
	first = POKEMON_TYPE_NORMAL,
}

pokemon.pokedexInformation = {
	nationalNumber = 128,
	description = "Once it takes aim at its prey, it makes a headlong charge. It is famous for its violent nature.",
	height = 1.4,
	weight = 88.4,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 119,
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
	{ text = "Tauroos!", yell = false },
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
