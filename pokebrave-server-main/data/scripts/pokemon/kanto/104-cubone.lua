local pType = Game.createPokemonType("Cubone")
local pokemon = { }

pokemon.description = "an Cubone"
pokemon.experience = 70
pokemon.portrait = 2399
pokemon.corpse = 2565

pokemon.outfit = {
	lookType = 104
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
	health = 50,
	attack = 50,
	defense = 95,
	specialAttack = 40,
	specialDefense = 50,
	speed = 35
}

pokemon.types = {
	first = POKEMON_TYPE_GROUND,
}

pokemon.pokedexInformation = {
	nationalNumber = 104,
	description = "When the memory of its departed mother brings it to tears, its cries echo mournfully within the skull it wears on its head.",
	height = 0.4,
	weight = 6.5,
}

pokemon.evolutions = {
	{ name = "marowak", stone = "heart stone", level = 28 }
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
	{ text = "Cubonee!", yell = false },
	{ text = "Boone!", yell = false },
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
