local pType = Game.createPokemonType("Seaking")
local pokemon = { }

pokemon.description = "an Seaking"
pokemon.experience = 158
pokemon.portrait = 2414
pokemon.corpse = 2580

pokemon.outfit = {
	lookType = 119
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 33,
	max = 100,
}

pokemon.baseStats = {
	health = 80,
	attack = 92,
	defense = 65,
	specialAttack = 65,
	specialDefense = 80,
	speed = 68
}

pokemon.types = {
	first = POKEMON_TYPE_WATER
}

pokemon.pokedexInformation = {
	nationalNumber = 119,
	description = "In autumn, its body becomes more fatty in preparing to propose to a mate. It takes on beautiful colors.",
	height = 1.3,
	weight = 39.0,
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
	{ text = "Seakiing!", yell = false },
	{ text = "Kiing!", yell = false },
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
