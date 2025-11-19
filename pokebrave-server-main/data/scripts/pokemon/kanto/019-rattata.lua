local pType = Game.createPokemonType("Rattata")
local pokemon = { }

pokemon.description = "an Rattata"
pokemon.experience = 51
pokemon.portrait = 2314
pokemon.corpse = 26880

pokemon.outfit = {
	lookType = 19
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 19,
}

pokemon.baseStats = {
	health = 30,
	attack = 56,
	defense = 35,
	specialAttack = 25,
	specialDefense = 35,
	speed = 72
}

pokemon.types = {
	first = POKEMON_TYPE_NORMAL,
}

pokemon.pokedexInformation = {
	nationalNumber = 19,
	description = "Will chew on anything with its fangs. If you see one, you can be certain that 40 more live in the area.",
	height = 0.3,
	weight = 3.5,
}


pokemon.evolutions = {
	{ name = "raticate", stone = "heart stone", level = 20 }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 439,
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
	{ text = "Rattataa!", yell = false },
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
