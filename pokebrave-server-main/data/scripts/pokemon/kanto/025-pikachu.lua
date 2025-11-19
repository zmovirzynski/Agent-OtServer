local pType = Game.createPokemonType("Pikachu")
local pokemon = { }

pokemon.description = "an Pikachu"
pokemon.experience = 112
pokemon.portrait = 2320
pokemon.corpse = 26886

pokemon.outfit = {
	lookType = 25
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 1,
	max = 100,
}

pokemon.baseStats = {
	health = 35,
	attack = 55,
	defense = 40,
	specialAttack = 50,
	specialDefense = 50,
	speed = 90
}

pokemon.types = {
	first = POKEMON_TYPE_ELETRIC,
}

pokemon.pokedexInformation = {
	nationalNumber = 25,
	description = "When it is angered, it immediately discharges the energy stored in the pouches in its cheeks.",
	height = 0.4,
	weight = 6.0,
}

pokemon.evolutions = {
	{ name = "raichu", stone = "thunder stone" }
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
	{ text = "Pika!", yell = false },
	{ text = "Pikachu!", yell = false },
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
