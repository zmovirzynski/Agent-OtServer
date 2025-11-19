local pType = Game.createPokemonType("Dratini")
local pokemon = { }

pokemon.description = "an Dratini"
pokemon.experience = 60
pokemon.portrait = 2442
pokemon.corpse = 2607

pokemon.outfit = {
	lookType = 147
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 29,
}

pokemon.baseStats = {
	health = 41,
	attack = 64,
	defense = 45,
	specialAttack = 50,
	specialDefense = 50,
	speed = 50
}

pokemon.types = {
	first = POKEMON_TYPE_DRAGON,
}

pokemon.pokedexInformation = {
	nationalNumber = 147,
	description = "It sheds many layers of skin as it grows larger. During this process, it is protected by a rapid waterfall.",
	height = 1.8,
	weight = 3.3,
}

pokemon.evolutions = {
	{ name = "dragonair", stone = "crystal stone", level = 30 }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 119,
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
	{ text = "Dratinii!", yell = false },
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
