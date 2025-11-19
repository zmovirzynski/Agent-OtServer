local pType = Game.createPokemonType("Moltres")
local pokemon = { }

pokemon.description = "an Moltres"
pokemon.experience = 290
pokemon.portrait = 2441
pokemon.corpse = 2606

pokemon.outfit = {
	lookType = 146
}

pokemon.gender = {
	malePercent = 0,
	femalePercent = 0
}

pokemon.spawnLevel = {
	min = 50,
	max = 100,
}

pokemon.baseStats = {
	health = 90,
	attack = 100,
	defense = 90,
	specialAttack = 125,
	specialDefense = 85,
	speed = 90
}

pokemon.types = {
	first = POKEMON_TYPE_FIRE,
	second = POKEMON_TYPE_FLYING,
}

pokemon.pokedexInformation = {
	nationalNumber = 146,
	description = "It is one of the legendary bird Pokémon. Its appearance is said to indicate the coming of spring.",
	height = 2.0,
	weight = 60.0,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 16,
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
	{ text = "Moltrees!", yell = false },
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
