local pType = Game.createPokemonType("Grimer")
local pokemon = { }

pokemon.description = "an Grimer"
pokemon.experience = 65
pokemon.portrait = 2383
pokemon.corpse = 2549

pokemon.outfit = {
	lookType = 88
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 37,
}

pokemon.baseStats = {
	health = 80,
	attack = 80,
	defense = 50,
	specialAttack = 40,
	specialDefense = 50,
	speed = 25
}

pokemon.types = {
	first = POKEMON_TYPE_POISON,
}

pokemon.pokedexInformation = {
	nationalNumber = 88,
	description = "Born from sludge, these Pokémon now gather in polluted places and increase the bacteria in their bodies.",
	height = 0.9,
	weight = 30.0,
}

pokemon.evolutions = {
	{ name = "muk", stone = "venom stone", level = 38 }
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
	{ text = "Grimeer!", yell = false },
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
