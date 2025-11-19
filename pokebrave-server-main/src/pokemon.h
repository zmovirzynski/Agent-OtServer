// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#ifndef FS_POKEMON_H_9F5EEFE64314418CA7DA41D1B9409DD0
#define FS_POKEMON_H_9F5EEFE64314418CA7DA41D1B9409DD0

#include "tile.h"
#include "pokemons.h"
#include "configmanager.h"

extern ConfigManager g_config;

class Creature;
class Game;
class Spawn;
class Pokeball;

using CreatureHashSet = std::unordered_set<Creature*>;
using CreatureList = std::list<Creature*>;

enum TargetSearchType_t {
	TARGETSEARCH_DEFAULT,
	TARGETSEARCH_RANDOM,
	TARGETSEARCH_ATTACKRANGE,
	TARGETSEARCH_NEAREST,
};

class Pokemon final : public Creature
{
	public:
		static Pokemon* createPokemon(const std::string& name);
		static int32_t despawnRange;
		static int32_t despawnRadius;

		explicit Pokemon(PokemonType* pType);
		~Pokemon();

		// non-copyable
		Pokemon(const Pokemon&) = delete;
		Pokemon& operator=(const Pokemon&) = delete;

		Pokemon* getPokemon() override {
			return this;
		}
		const Pokemon* getPokemon() const override {
			return this;
		}

		void setID() override {
			if (id == 0) {
				id = pokemonAutoID++;
			}
		}

		void addList() override;
		void removeList() override;

		const std::string& getName() const override;
		void setName(const std::string& name);

		const std::string& getNameDescription() const override;
		void setNameDescription(const std::string& nameDescription) {
			this->nameDescription = nameDescription;
		};

		std::string getDescription(int32_t) const override {
			return nameDescription + '.';
		}

		CreatureType_t getType() const override {
			return CREATURETYPE_POKEMON;
		}

		const Position& getMasterPos() const {
			return masterPos;
		}
		void setMasterPos(Position pos) {
			masterPos = pos;
		}

		PokemonType_t getFirstType() const override {
			return pType->info.firstType;
		}
		PokemonType_t getSecondType() const override {
			return pType->info.secondType;
		}

		int32_t getArmor() const override {
			return pType->info.armor;
		}
		int32_t getDefense() const override {
			return pType->info.defense;
		}
		bool isPushable() const override {
			return pType->info.pushable && baseSpeed != 0;
		}
		bool isAttackable() const override {
			return pType->info.isAttackable;
		}

		bool canPushItems() const;
		bool canPushCreatures() const {
			return pType->info.canPushCreatures;
		}
		bool isHostile() const {
			return pType->info.isHostile;
		}
		bool canSee(const Position& pos) const override;
		bool canSeeInvisibility() const override {
			return isImmune(CONDITION_INVISIBLE);
		}
		void setSpawn(Spawn* spawn) {
			this->spawn = spawn;
		}
		bool canWalkOnFieldType(CombatType_t combatType) const;

		void onAttackedCreatureDisappear(bool isLogout) override;

		void onCreatureAppear(Creature* creature, bool isLogin) override;
		void onRemoveCreature(Creature* creature, bool isLogout) override;
		void onCreatureMove(Creature* creature, const Tile* newTile, const Position& newPos, const Tile* oldTile, const Position& oldPos, bool teleport) override;
		void onCreatureSay(Creature* creature, SpeakClasses type, const std::string& text) override;
		void onGainExperience(uint64_t gainExp, Creature* target) override;
		void drainHealth(Creature* attacker, int32_t damage) override;
		void changeHealth(int32_t healthChange, bool sendHealthChange = true) override;

		uint32_t getLevel() const {
			return level;
		}
		uint8_t getLevelPercent() const {
			return levelPercent;
		}
		void setLevel(uint32_t level) {
			this->level = std::min<uint32_t>(level, g_config.getNumber(ConfigManager::MAX_POKEMON_LEVEL));
		}

		uint8_t getGender() const {
			return gender;
		}
		void setGender(uint8_t gender) {
			if (gender > POKEMON_GENDER_LAST) {
				gender = POKEMON_GENDER_UNDEFINED;
			}
			this->gender = gender;
		}

		uint8_t getNature() const {
			return nature;
		}
		void setNature(uint8_t nature);

		uint64_t getExperience() const {
			return experience;
		}
		void setExperience(uint64_t exp) {
			this->experience = exp;
		}
		void addExperience(uint64_t exp);
		static uint64_t getExpForLevel(const uint64_t level) {
			return (((level - 6ULL) * level + 17ULL) * level - 12ULL) / 6ULL * 100ULL;
		}
		static uint8_t getPercentLevel(uint64_t count, uint64_t nextLevelCount);

		std::string getIvsStats() {
			return getPokemonStats(ivs);
		}

		PokemonValues& getIvs() {
			return ivs;
		}

		PokemonValues& getEvs() {
			return evs;
		}

		Pokeball* getPokeball() {
			return pokeball;
		}
		void setPokeball(Pokeball* pokeball) {
			this->pokeball = pokeball;
		}

		bool learnAbility(const std::string& ability);
		bool hasAbility(const std::string& ability);

		void setAbilities(StringVector abilities) {
			this->abilities = abilities;
		}
		StringVector getAbilities() {
			return abilities;
		}

		static void setPokemonValues(PokemonValues& values, uint16_t attack, uint16_t defense, uint16_t health, uint16_t specialAttack, uint16_t specialDefense, uint16_t speed);

		void setEvAttack(uint16_t attack) {
			evs.attack = std::min<uint16_t>(attack, MAX_POKEMON_EV_VALUE);
		}
		void setEvDefense(uint16_t defense) {
			evs.defense = std::min<uint16_t>(defense, MAX_POKEMON_EV_VALUE);
		}
		void setEvHealth(uint16_t health) {
			evs.health = std::min<uint16_t>(health, MAX_POKEMON_EV_VALUE);
		}
		void setEvSpecialAttack(uint16_t specialAttack) {
			evs.specialAttack = std::min<uint16_t>(specialAttack, MAX_POKEMON_EV_VALUE);
		}
		void setEvSpecialDefense(uint16_t specialDefense) {
			evs.specialDefense = std::min<uint16_t>(specialDefense, MAX_POKEMON_EV_VALUE);
		}
		void setEvSpeed(uint16_t speed) {
			evs.speed = std::min<uint16_t>(speed, MAX_POKEMON_EV_VALUE);
		}

		void setBaseStats(const PokemonValues& baseStats) {
			this->baseStats = baseStats;
		}

		void generateIvs();
		void generateGender();
		void generateNature();
		void generateLevel();

		void updateMaxHealth();
		static int32_t getUpdatedMaxHealth(const std::string& pokemonName, uint32_t level, uint8_t gender, uint16_t healthIv, uint16_t healthEv);
		void updateSpeed();

		double getStatusAttack();
		double getStatusDefense();
		double getStatusHealth();
		double getStatusSpecialAttack();
		double getStatusSpecialDefense();
		double getStatusSpeed();

		bool hasMoveByName(const std::string& moveName);
		bool learnMove(moveBlock_t& move);

		bool isWalkingToSpawn() const {
			return walkingToSpawn;
		}
		bool walkToSpawn();
		void onWalk() override;
		void onWalkComplete() override;
		bool getNextStep(Direction& direction, uint32_t& flags) override;
		void onFollowCreatureComplete(const Creature* creature) override;

		void onThink(uint32_t interval) override;

		bool challengeCreature(Creature* creature, bool force = false) override;

		void setNormalCreatureLight() override;
		bool getCombatValues(int32_t& min, int32_t& max) override;

		void doAttacking(uint32_t interval) override;
		bool hasExtraSwing() override {
			return lastMeleeAttack == 0;
		}

		bool searchTarget(TargetSearchType_t searchType = TARGETSEARCH_DEFAULT);
		bool selectTarget(Creature* creature);

		const CreatureList& getTargetList() const {
			return targetList;
		}
		const CreatureHashSet& getFriendList() const {
			return friendList;
		}

		bool isTarget(const Creature* creature) const;
		bool isFleeing() const {
			return !isSummon() && getHealth() <= pType->info.runAwayHealth && challengeFocusDuration <= 0;
		}

		bool getDistanceStep(const Position& targetPos, Direction& direction, bool flee = false);
		bool isTargetNearby() const {
			return stepDuration >= 1;
		}
		bool isIgnoringFieldDamage() const {
			return ignoreFieldDamage;
		}

		bool teleportToPlayer();

		BlockType_t blockHit(Creature* attacker, CombatType_t combatType, int32_t& damage,
		                     bool checkDefense = false, bool checkArmor = false, bool field = false, bool ignoreResistances = false) override;

		void setHoldPosition(bool hold) {
			holdPosition = hold;
		}
		bool isHoldingPosition() {
			return holdPosition;

		}

		const Position& getOrderPosition() const {
			return orderPosition;
		}

		void setOrderPosition(const Position& newOrderPosition);

		void goToOrderPosition();

		void goToFollowCreature() override;

		void addEventWalk(bool firstStep = false);

		bool setFollowCreature(Creature* creature) override;

		static uint32_t pokemonAutoID;

	private:
		CreatureHashSet friendList;
		CreatureList targetList;

		std::string name;
		std::string nameDescription;

		StringVector abilities;

		PokemonValues ivs;
		PokemonValues evs;
		PokemonValues baseStats;
		PokemonNatureValues natureValues;
		PokemonType* pType;
		Pokeball* pokeball = nullptr;
		Spawn* spawn = nullptr;

		int64_t lastMeleeAttack = 0;
		uint64_t experience = 0;

		uint32_t attackTicks = 0;
		uint32_t targetTicks = 0;
		uint32_t targetChangeTicks = 0;
		uint32_t defenseTicks = 0;
		uint32_t yellTicks = 0;
		uint32_t level = 1;

		uint8_t gender = 0;
		uint8_t nature = 0;
		uint8_t levelPercent = 0;

		int32_t minCombatValue = 0;
		int32_t maxCombatValue = 0;
		int32_t targetChangeCooldown = 0;
		int32_t challengeFocusDuration = 0;
		int32_t stepDuration = 0;

		Position masterPos;

		Position rawOrderPosition;
		Position orderPosition;

		bool ignoreFieldDamage = false;
		bool isIdle = true;
		bool isMasterInRange = false;
		bool randomStepping = false;
		bool walkingToSpawn = false;
		bool holdPosition = false;

		bool hasOrderPosition = false;
		bool followingOrderPosition = false;

		void onCreatureEnter(Creature* creature);
		void onCreatureLeave(Creature* creature);
		void onCreatureFound(Creature* creature, bool pushFront = false);

		void updateLookDirection();

		void addFriend(Creature* creature);
		void removeFriend(Creature* creature);
		void addTarget(Creature* creature, bool pushFront = false);
		void removeTarget(Creature* creature);

		void updateTargetList();
		void clearTargetList();
		void clearFriendList();

		void death(Creature* lastHitCreature) override;
		Item* getCorpse(Creature* lastHitCreature, Creature* mostDamageCreature) override;

		void setIdle(bool idle);
		void updateIdleStatus();
		bool getIdleStatus() const {
			return isIdle;
		}

		void onAddCondition(ConditionType_t type) override;
		void onEndCondition(ConditionType_t type) override;

		bool canUseAttack(const Position& pos, const Creature* target) const;
		bool canUseSpell(const Position& pos, const Position& targetPos,
		                 const spellBlock_t& sb, uint32_t interval, bool& inRange, bool& resetTicks);
		bool getRandomStep(const Position& creaturePos, Direction& direction) const;
		bool getDanceStep(const Position& creaturePos, Direction& direction,
		                  bool keepAttack = true, bool keepDistance = true);
		bool isInSpawnRange(const Position& pos) const;
		bool canWalkTo(Position pos, Direction direction) const;

		static bool pushItem(Item* item);
		static void pushItems(Tile* tile);
		static bool pushCreature(Creature* creature);
		static void pushCreatures(Tile* tile);

		void onThinkTarget(uint32_t interval);
		void onThinkYell(uint32_t interval);
		void onThinkDefense(uint32_t interval);

		bool isFriend(const Creature* creature) const;
		bool isOpponent(const Creature* creature) const;

		uint64_t getLostExperience() const override {
			return skillLoss ? pType->info.experience : 0;
		}
		uint16_t getLookCorpse() const override {
			return pType->info.lookcorpse;
		}
		void dropLoot(Container* corpse, Creature* lastHitCreature) override;
		uint32_t getDamageImmunities() const override {
			return pType->info.damageImmunities;
		}
		uint32_t getConditionImmunities() const override {
			return pType->info.conditionImmunities;
		}
		void getPathSearchParams(const Creature* creature, FindPathParams& fpp) const override;
		bool useCacheMap() const override {
			return !randomStepping;
		}

		friend class LuaScriptInterface;
};

#endif
