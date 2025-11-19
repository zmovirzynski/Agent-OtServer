local pType = Game.createPokemonType("Marowak")
local pokemon = { }

pokemon.description = "an Marowak"
pokemon.experience = 149
pokemon.portrait = 2400
pokemon.corpse = 2566

pokemon.outfit = {
	lookType = 105
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 28,
	max = 100,
}

pokemon.baseStats = {
	health = 60,
	attack = 80,
	defense = 110,
	specialAttack = 50,
	specialDefense = 80,
	speed = 45
}

pokemon.types = {
	first = POKEMON_TYPE_GROUND,
}

pokemon.pokedexInformation = {
	nationalNumber = 105,
	description = "This Pokémon overcame its sorrow to evolve a sturdy new body. Marowak faces its opponents bravely, using a bone as a weapon.",
	height = 1.0,
	weight = 45.0,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 175,
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
	{ text = "Marowaak!", yell = false },
	{ text = "Waak!", yell = false },
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
