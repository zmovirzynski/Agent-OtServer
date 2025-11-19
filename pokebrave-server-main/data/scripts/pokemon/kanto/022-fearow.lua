local pType = Game.createPokemonType("Fearow")
local pokemon = { }

pokemon.description = "an Fearow"
pokemon.experience = 155
pokemon.portrait = 2317
pokemon.corpse = 26883

pokemon.outfit = {
	lookType = 22
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
	health = 65,
	attack = 90,
	defense = 65,
	specialAttack = 61,
	specialDefense = 61,
	speed = 100
}

pokemon.types = {
	first = POKEMON_TYPE_NORMAL,
	second = POKEMON_TYPE_FLYING
}

pokemon.pokedexInformation = {
	nationalNumber = 22,
	description = "A Pokémon that dates back many years. If it senses danger, it flies high and away, instantly.",
	height = 1.2,
	weight = 38.0,
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
	{ text = "Spearoow!", yell = false },
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
