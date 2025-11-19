local pType = Game.createPokemonType("Dugtrio")
local pokemon = { }

pokemon.description = "an Dugtrio"
pokemon.experience = 149
pokemon.portrait = 2346
pokemon.corpse = 2512

pokemon.outfit = {
	lookType = 51
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 26,
	max = 100,
}

pokemon.baseStats = {
	health = 35,
	attack = 100,
	defense = 50,
	specialAttack = 50,
	specialDefense = 70,
	speed = 120
}

pokemon.types = {
	first = POKEMON_TYPE_GROUND,
}

pokemon.pokedexInformation = {
	nationalNumber = 51,
	description = "Its three heads bob separately up and down to loosen the soil nearby, making it easier for it to burrow.",
	height = 0.7,
	weight = 33.3,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 129,
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
	{ text = "Dugtriooo!", yell = false },
	{ text = "Trioo!", yell = false },
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
