#pragma once
#include "item.h"

#include "pokemon.h"
#include "configmanager.h"
#include "pokemons.h"

extern ConfigManager g_config;
extern Pokemons g_pokemons;

class Pokeball : public Item
{
public:
	explicit Pokeball(uint16_t itemId) : Item(itemId) {}

	Pokeball* getPokeball() override final {
		return this;
	}

	const Pokeball* getPokeball() const override final {
		return this;
	}

	Attr_ReadValue readAttr(AttrTypes_t attr, PropStream& propStream) override;
	void serializeAttr(PropWriteStream& propWriteStream) const override;

	Pokemon* getPokemon() {
		return pokemon;
	}
	void setPokemon(Pokemon* pokemon) {
		this->pokemon = pokemon;
		if (pokemon) {
			PokemonType* pType = g_pokemons.getPokemonType(pokemon->getName());
			setPortrait(pType->info.portrait);
			pokemon->setPokeball(this);
			pokemon->setAbilities(abilities);
			updatePokemonMoves();
		}
	}

	void setPokemonName(std::string name);
	std::string getPokemonName() {
		return name;
	}

	void setPokemonNickname(std::string name){
		this->nickname = name;
	}
	std::string getPokemonNickname() {
		return nickname;
	}

	PokemonValues& getIvs() {
		return ivs;
	}

	PokemonValues& getEvs() {
		return evs;
	}

	std::string getIvsStats() {
		return getPokemonStats(ivs);
	}

	void setPokemonLevel(uint32_t level) {
		this->level = std::min<uint32_t>(level, g_config.getNumber(ConfigManager::MAX_POKEMON_LEVEL));
	}

	uint32_t getPokemonLevel() {
		return level;
	}

	void setPokemonGender(uint8_t gender) {
		if (gender > POKEMON_GENDER_LAST) {
			gender = POKEMON_GENDER_UNDEFINED;
		}
		this->gender = gender;
	}

	uint8_t getPokemonGender() {
		return gender;
	}

	void setPokemonNature(uint8_t nature) {
		this->nature = nature;
	}

	uint8_t getPokemonNature() {
		return nature;
	}

	void setPokemonExperience(uint64_t experience) {
		this->experience = experience;
	}

	uint8_t getPokemonExperience() {
		return experience;
	}

	void setInfoId(uint16_t infoId) {
		this->infoId = infoId;
	}

	uint16_t getInfoId() {
		return infoId;
	}

	void setPokemonHealth(int32_t health) {
		this->health = health;
	}

	int32_t getPokemonHealth() {
		return health;
	}

	void setState(uint8_t state) {
		this->state = state;
	}

	uint8_t getState() const {
		return state;
	}

	void setPortrait(uint32_t id) {
		this->portraitId = id;
	}

	uint32_t getPortrait() const {
		return portraitId;
	}

	void updatePokemonMoves();
	MoveList getPokemonMoves() const {
		return moves;
	};

	bool pokemonLearnMove(moveBlock_t& move);
	bool hasLearnedMoveByName(const std::string& moveName);
	bool hasLearnedMoveId(uint16_t moveId);
	bool hasMoveByName(const std::string& moveName);

	void updatePokemonAbilities() {
		if (!pokemon) {
			return;
		}
		this->abilities = pokemon->getAbilities();
	}

	void refresh();

	void resetMoveCooldown(const std::string& moveName);
	uint32_t getMoveOsTime(const std::string& moveName);
	int32_t getMoveCooldown(const std::string& moveName);

private:
	Pokemon* pokemon = nullptr;

	PokemonValues ivs;
	PokemonValues evs;

	MoveList learnedMoves;
	MoveList moves;

	StringVector abilities;
	std::map<std::string, uint32_t> moveCooldowns;

	std::string name;
	std::string nickname;

	uint16_t infoId{ 0 };
	uint32_t level{ 1 };
	uint32_t portraitId{ 0 };
	uint8_t gender{ 0 };
	uint8_t nature{ 0 };
	uint8_t state{ 0 };
	uint64_t experience{ 0 };

	int32_t health{ 100 };
	int32_t healthMax{ health };
};
