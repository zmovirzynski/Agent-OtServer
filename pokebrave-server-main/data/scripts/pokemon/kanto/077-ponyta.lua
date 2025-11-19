local pType = Game.createPokemonType("Ponyta")
local pokemon = { }

pokemon.description = "an Ponyta"
pokemon.experience = 82
pokemon.portrait = 2372
pokemon.corpse = 2538

pokemon.outfit = {
	lookType = 77
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 39,
}

pokemon.baseStats = {
	health = 50,
	attack = 85,
	defense = 55,
	specialAttack = 65,
	specialDefense = 65,
	speed = 90
}

pokemon.types = {
	first = POKEMON_TYPE_FIRE,
}

pokemon.pokedexInformation = {
	nationalNumber = 77,
	description = "About an hour after birth, Ponyta’s fiery mane and tail grow out, giving the Pokémon an impressive appearance.",
	height = 1.0,
	weight = 30.0,
}

pokemon.evolutions = {
	{ name = "rapidash", stone = "fire stone", level = 40 }
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
	{ text = "Ponytaa!", yell = false },
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
