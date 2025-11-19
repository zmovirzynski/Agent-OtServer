// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#ifndef FS_POKEMONS_H_776E8327BCE2450EB7C4A260785E6C0D
#define FS_POKEMONS_H_776E8327BCE2450EB7C4A260785E6C0D

#include "creature.h"

const uint32_t MAX_LOOTCHANCE = 100000;

struct LootBlock {
	uint16_t id;
	uint32_t countmax;
	uint32_t chance;

	//optional
	int32_t subType;
	int32_t actionId;
	std::string text;

	std::vector<LootBlock> childLoot;
	LootBlock() {
		id = 0;
		countmax = 1;
		chance = 0;

		subType = -1;
		actionId = -1;
	}
};

class Loot {
	public:
		Loot() = default;

		// non-copyable
		Loot(const Loot&) = delete;
		Loot& operator=(const Loot&) = delete;

		LootBlock lootBlock;
};

struct summonBlock_t {
	std::string name;
	uint32_t chance;
	uint32_t speed;
	uint32_t max;
	bool force = false;
};

class BaseSpell;
struct spellBlock_t {
	constexpr spellBlock_t() = default;
	~spellBlock_t();
	spellBlock_t(const spellBlock_t& other) = delete;
	spellBlock_t& operator=(const spellBlock_t& other) = delete;
	spellBlock_t(spellBlock_t&& other) :
		spell(other.spell),
		chance(other.chance),
		speed(other.speed),
		range(other.range),
		minCombatValue(other.minCombatValue),
		maxCombatValue(other.maxCombatValue),
		combatSpell(other.combatSpell),
		isMelee(other.isMelee) {
		other.spell = nullptr;
	}

	BaseSpell* spell = nullptr;
	uint32_t chance = 100;
	uint32_t speed = 2000;
	uint32_t range = 0;
	int32_t minCombatValue = 0;
	int32_t maxCombatValue = 0;
	bool combatSpell = false;
	bool isMelee = false;
};

struct voiceBlock_t {
	std::string text;
	bool yellText;
};

struct moveBlock_t {
	uint16_t id;
	uint16_t level;
	std::string name;
};
using MoveList = std::map<uint16_t, moveBlock_t>;

struct evolutionBlock_t {
	uint16_t level;
	std::string name;
};
using EvolutionList = std::map<uint16_t, evolutionBlock_t>;

class PokemonType
{
	struct PokemonInfo {
		LuaScriptInterface* scriptInterface;

		std::map<CombatType_t, int32_t> elementMap;

		std::vector<voiceBlock_t> voiceVector;

		std::vector<LootBlock> lootItems;
		std::vector<std::string> scripts;
		std::vector<spellBlock_t> attackSpells;
		std::vector<spellBlock_t> defenseSpells;
		std::vector<summonBlock_t> summons;

		Skulls_t skull = SKULL_NONE;
		Outfit_t outfit = {};

		PokemonType_t firstType = POKEMON_TYPE_NONE;
		PokemonType_t secondType = POKEMON_TYPE_NONE;

		LightInfo light = {};
		uint16_t lookcorpse = 0;

		uint64_t experience = 0;

		uint32_t yellChance = 0;
		uint32_t yellSpeedTicks = 0;
		uint32_t staticAttackChance = 95;
		uint32_t maxSummons = 0;
		uint32_t changeTargetSpeed = 0;
		uint32_t conditionImmunities = 0;
		uint32_t damageImmunities = 0;
		uint32_t baseSpeed = 200;
		uint32_t minSpawnLevel = 1;
		uint32_t maxSpawnLevel = 100;
		uint32_t catchRate = 0;
		uint32_t portrait = 0;
		uint32_t requiredLevel = 0;

		int32_t creatureAppearEvent = -1;
		int32_t creatureDisappearEvent = -1;
		int32_t creatureMoveEvent = -1;
		int32_t creatureSayEvent = -1;
		int32_t thinkEvent = -1;
		int32_t targetDistance = 1;
		int32_t runAwayHealth = 0;
		int32_t health = 100;
		int32_t healthMax = 100;
		int32_t changeTargetChance = 0;
		int32_t defense = 0;
		int32_t armor = 0;

		double genderMalePercent = 0.0;
		double genderFemalePercent = 0.0;

		bool canPushItems = false;
		bool canPushCreatures = false;
		bool pushable = true;
		bool isAttackable = true;
		bool isBoss = false;
		bool isChallengeable = true;
		bool isConvinceable = false;
		bool isHostile = true;
		bool isIgnoringSpawnBlock = false;
		bool isIllusionable = false;
		bool isSummonable = false;
		bool hiddenHealth = false;
		bool canWalkOnEnergy = true;
		bool canWalkOnFire = true;
		bool canWalkOnPoison = true;

		int32_t nationalNumber = 0;
		std::string description = "";
		float height = 0.f;
		float weight = 0.f;

		PokemonsEvent_t eventType = POKEMONS_EVENT_NONE;
	};

	public:
		PokemonType() = default;

		// non-copyable
		PokemonType(const PokemonType&) = delete;
		PokemonType& operator=(const PokemonType&) = delete;

		bool loadCallback(LuaScriptInterface* scriptInterface);
		bool hasMoveId(uint16_t moveId);
		bool addMove(moveBlock_t& move);
		bool addLearnableAbility(const std::string& ability);
		bool addLearnableMove(const std::string& moveName);
		bool canLearnAbility(const std::string& ability);
		bool canLearnMove(const std::string& moveName);

		PokemonGender_t getRandomGender();

		std::string name;
		std::string nameDescription;

		PokemonInfo info;
		MoveList moves;
		PokemonValues baseStats;
		StringVector learnablesHM;
		StringVector learnablesTM;

		EvolutionList evolutions;
		std::map<std::string, std::string> tags;

		void loadLoot(PokemonType* pokemonType, LootBlock lootBlock);
};

class PokemonSpell
{
	public:
		PokemonSpell() = default;

		PokemonSpell(const PokemonSpell&) = delete;
		PokemonSpell& operator=(const PokemonSpell&) = delete;

		std::string name = "";
		std::string scriptName = "";

		uint8_t chance = 100;
		uint8_t range = 0;
		uint8_t drunkenness = 0;

		uint16_t interval = 2000;

		int32_t minCombatValue = 0;
		int32_t maxCombatValue = 0;
		int32_t attack = 0;
		int32_t skill = 0;
		int32_t length = 0;
		int32_t spread = 0;
		int32_t radius = 0;
		int32_t conditionMinDamage = 0;
		int32_t conditionMaxDamage = 0;
		int32_t conditionStartDamage = 0;
		int32_t tickInterval = 0;
		int32_t minSpeedChange = 0;
		int32_t maxSpeedChange = 0;
		int32_t duration = 0;

		bool isScripted = false;
		bool needTarget = false;
		bool needDirection = false;
		bool combatSpell = false;
		bool isMelee = false;

		Outfit_t outfit = {};
		ShootType_t shoot = CONST_ANI_NONE;
		MagicEffectClasses effect = CONST_ME_NONE;
		ConditionType_t conditionType = CONDITION_NONE;
		CombatType_t combatType = COMBAT_GRASSDAMAGE;
};

class Pokemons
{
	public:
		Pokemons() = default;
		// non-copyable
		Pokemons(const Pokemons&) = delete;
		Pokemons& operator=(const Pokemons&) = delete;

		bool isLoaded() const {
			return loaded;
		}
		bool reload();

		PokemonType* getPokemonType(const std::string& name, bool loadFromFile = true);
		bool deserializeSpell(PokemonSpell* spell, spellBlock_t& sb, const std::string& description = "");

		std::unique_ptr<LuaScriptInterface> scriptInterface;
		std::map<std::string, PokemonType> pokemons;

	private:
		ConditionDamage* getDamageCondition(ConditionType_t conditionType,
		                                    int32_t maxDamage, int32_t minDamage, int32_t startDamage, uint32_t tickInterval);
		bool deserializeSpell(const pugi::xml_node& node, spellBlock_t& sb, const std::string& description = "");

		PokemonType* loadPokemon(const std::string& file, const std::string& pokemonName, bool reloading = false);

		void loadLootContainer(const pugi::xml_node& node, LootBlock&);
		bool loadLootItem(const pugi::xml_node& node, LootBlock&);

		std::map<std::string, std::string> unloadedPokemons;

		bool loaded = false;
};

#endif
