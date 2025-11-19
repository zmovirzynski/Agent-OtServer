local pType = Game.createPokemonType("Beedrill")
local pokemon = { }

pokemon.description = "an Beedrill"
pokemon.experience = 178
pokemon.portrait = 2310
pokemon.corpse = 26876

pokemon.outfit = {
	lookType = 15
}

pokemon.gender = {
	malePercent = 50,
	femalePercent = 50
}

pokemon.spawnLevel = {
	min = 5,
	max = 20,
}

pokemon.baseStats = {
	health = 65,
	attack = 90,
	defense = 40,
	specialAttack = 45,
	specialDefense = 80,
	speed = 75
}

pokemon.types = {
	first = POKEMON_TYPE_BUG,
	second = POKEMON_TYPE_POISON
}

pokemon.pokedexInformation = {
	nationalNumber = 15,
	description = "It has three poisonous stingers on its forelegs and its tail. They are used to jab its enemy repeatedly.",
	height = 1.0,
	weight = 29.5,
}

pokemon.changeTarget = {
	interval = 4*1000,
	chance = 20
}

pokemon.flags = {
	catchRate = 119,
	requiredLevel = 5,
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
	{ text = "Drill!", yell = false },
	{ text = "Beedrilll!", yell = false },
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
