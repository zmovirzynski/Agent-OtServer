local pType = Game.createPokemonType("Mew")
local pokemon = { }

pokemon.description = "an Mew"
pokemon.experience = 300
pokemon.portrait = 2446
pokemon.corpse = 2611

pokemon.outfit = {
	lookType = 151
}

pokemon.gender = {
	malePercent = 0,
	femalePercent = 0
}

pokemon.spawnLevel = {
	min = 70,
	max = 100,
}

pokemon.baseStats = {
	health = 100,
	attack = 100,
	defense = 100,
	specialAttack = 100,
	specialDefense = 100,
	speed = 100
}

pokemon.types = {
	first = POKEMON_TYPE_PSYCHIC,
}

pokemon.pokedexInformation = {
	nationalNumber = 151,
	description = "When viewed through a microscope, this Pokémon’s short, fine, delicate hair can be seen.",
	height = 0.4,
	weight = 4.0,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 8,
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
	{ text = "Meew!", yell = false },
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
