local pType = Game.createPokemonType("Raticate")
local pokemon = { }

pokemon.description = "an Raticate"
pokemon.experience = 145
pokemon.portrait = 2315
pokemon.corpse = 26881

pokemon.outfit = {
	lookType = 20
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 20,
	max = 100,
}

pokemon.baseStats = {
	health = 55,
	attack = 81,
	defense = 60,
	specialAttack = 50,
	specialDefense = 70,
	speed = 97
}

pokemon.types = {
	first = POKEMON_TYPE_NORMAL,
}

pokemon.pokedexInformation = {
	nationalNumber = 20,
	description = "Its hind feet are webbed. They act as flippers, so it can swim in rivers and hunt for prey.",
	height = 0.7,
	weight = 18.5,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 260,
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
	{ text = "Raticatee!", yell = false },
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
