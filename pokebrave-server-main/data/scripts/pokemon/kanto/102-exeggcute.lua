local pType = Game.createPokemonType("Exeggcute")
local pokemon = { }

pokemon.description = "an Exeggcute"
pokemon.experience = 65
pokemon.portrait = 2397
pokemon.corpse = 2563

pokemon.outfit = {
	lookType = 102
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 35,
}

pokemon.baseStats = {
	health = 60,
	attack = 40,
	defense = 80,
	specialAttack = 60,
	specialDefense = 45,
	speed = 40
}

pokemon.types = {
	first = POKEMON_TYPE_GRASS,
	second = POKEMON_TYPE_PSYCHIC,
}

pokemon.pokedexInformation = {
	nationalNumber = 102,
	description = "Though it may look like it’s just a bunch of eggs, it’s a proper Pokémon. Exeggcute communicates with others of its kind via telepathy, apparently.",
	height = 0.4,
	weight = 2.5,
}

pokemon.evolutions = {
	{ name = "exeggutor", stone = "leaf stone" }
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
	{ text = "Exeggcuute!", yell = false },
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
