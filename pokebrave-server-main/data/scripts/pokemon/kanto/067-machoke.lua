local pType = Game.createPokemonType("Machoke")
local pokemon = { }

pokemon.description = "an Machoke"
pokemon.experience = 142
pokemon.portrait = 2362
pokemon.corpse = 2528

pokemon.outfit = {
	lookType = 67
}

pokemon.gender = {
	malePercent = 75,
	femalePercent = 25
}

pokemon.spawnLevel = {
	min = 27,
	max = 35,
}

pokemon.baseStats = {
	health = 80,
	attack = 100,
	defense = 70,
	specialAttack = 50,
	specialDefense = 60,
	speed = 45
}

pokemon.types = {
	first = POKEMON_TYPE_FIGHTING,
}

pokemon.pokedexInformation = {
	nationalNumber = 67,
	description = "Its muscular body is so powerful, it must wear a power-save belt to be able to regulate its motions.",
	height = 1.5,
	weight = 70.5,
}

pokemon.evolutions = {
	{ name = "machamp", stone = "punch stone" }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 201,
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
	{ text = "Machooke!", yell = false },
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
