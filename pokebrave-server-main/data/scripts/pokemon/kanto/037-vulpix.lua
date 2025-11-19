local pType = Game.createPokemonType("Vulpix")
local pokemon = { }

pokemon.description = "an Vulpix"
pokemon.experience = 60
pokemon.portrait = 2332
pokemon.corpse = 26898

pokemon.outfit = {
	lookType = 37
}

pokemon.gender = {
	malePercent = 25,
	femalePercent = 75
}

pokemon.spawnLevel = {
	min = 1,
	max = 100,
}

pokemon.baseStats = {
	health = 38,
	attack = 41,
	defense = 40,
	specialAttack = 50,
	specialDefense = 65,
	speed = 65
}

pokemon.types = {
	first = POKEMON_TYPE_FIRE,
}

pokemon.pokedexInformation = {
	nationalNumber = 37,
	description = "While young, it has six gorgeous tails. When it grows, several new tails are sprouted.",
	height = 0.6,
	weight = 9.9,
}

pokemon.evolutions = {
	{ name = "ninetales", stone = "fire stone" }
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
	{ text = "Vulpix!!", yell = false },
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
