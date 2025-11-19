local pType = Game.createPokemonType("Rhyhorn")
local pokemon = { }

pokemon.description = "an Rhyhorn"
pokemon.experience = 69
pokemon.portrait = 2406
pokemon.corpse = 2572

pokemon.outfit = {
	lookType = 111
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 41,
}

pokemon.baseStats = {
	health = 80,
	attack = 85,
	defense = 95,
	specialAttack = 30,
	specialDefense = 30,
	speed = 25
}

pokemon.types = {
	first = POKEMON_TYPE_GROUND,
	second = POKEMON_TYPE_ROCK,
}

pokemon.pokedexInformation = {
	nationalNumber = 111,
	description = "Strong, but not too bright, this Pokémon can shatter even a skyscraper with its charging tackles.",
	height = 1.0,
	weight = 115.0,
}

pokemon.evolutions = {
	{ name = "Rhydon", stone = "rock stone", level = 42 }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 249,
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
	{ text = "Rhyhoorn!", yell = false },
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
