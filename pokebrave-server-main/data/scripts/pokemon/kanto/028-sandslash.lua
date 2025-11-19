local pType = Game.createPokemonType("Sandslash")
local pokemon = { }

pokemon.description = "an Sandslash"
pokemon.experience = 158
pokemon.portrait = 2323
pokemon.corpse = 26889

pokemon.outfit = {
	lookType = 28
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 22,
	max = 100,
}

pokemon.baseStats = {
	health = 75,
	attack = 100,
	defense = 110,
	specialAttack = 45,
	specialDefense = 55,
	speed = 65
}

pokemon.types = {
	first = POKEMON_TYPE_GROUND,
}

pokemon.pokedexInformation = {
	nationalNumber = 28,
	description = "The drier the area Sandslash lives in, the harder and smoother the Pokémon’s spikes will feel when touched.",
	height = 1.0,
	weight = 29.5,
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
	{ text = "Slaash!", yell = false },
	{ text = "Sandslaash!", yell = false },
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
