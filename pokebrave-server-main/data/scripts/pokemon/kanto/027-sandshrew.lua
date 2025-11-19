local pType = Game.createPokemonType("Sandshrew")
local pokemon = { }

pokemon.description = "an Sandshrew"
pokemon.experience = 60
pokemon.portrait = 2322
pokemon.corpse = 26888

pokemon.outfit = {
	lookType = 27
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 21,
}

pokemon.baseStats = {
	health = 50,
	attack = 75,
	defense = 85,
	specialAttack = 20,
	specialDefense = 30,
	speed = 40
}

pokemon.types = {
	first = POKEMON_TYPE_GROUND,
}

pokemon.pokedexInformation = {
	nationalNumber = 27,
	description = "It loves to bathe in the grit of dry, sandy areas. By sand bathing, the Pokémon rids itself of dirt and moisture clinging to its body.",
	height = 0.6,
	weight = 12.0,
}

pokemon.evolutions = {
	{ name = "sandslash", stone = "earth stone", level = 22 }
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 439,
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
	{ text = "Shreeew!", yell = false },
	{ text = "Sandshreew!", yell = false },
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
