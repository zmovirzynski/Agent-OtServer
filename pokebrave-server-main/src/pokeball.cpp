#include "otpch.h"

#include <cmath>

#include "pokeball.h"
#include "spells.h"

extern Spells* g_spells;
extern Pokemons g_pokemons;

Attr_ReadValue Pokeball::readAttr(AttrTypes_t attr, PropStream& propStream)
{
	switch (attr)
	{
	case ATTR_POKEBALL_INFO: {
		if (!propStream.readString(name)) {
			return ATTR_READ_ERROR;
		}
		if (!propStream.readString(nickname)) {
			return ATTR_READ_ERROR;
		}
		if (!propStream.read<uint32_t>(level)) {
			return ATTR_READ_ERROR;
		}
		if (!propStream.read<uint8_t>(gender)) {
			return ATTR_READ_ERROR;
		}
		if (!propStream.read<uint8_t>(nature)) {
			return ATTR_READ_ERROR;
		}
		if (!propStream.read<uint64_t>(experience)) {
			return ATTR_READ_ERROR;
		}
		if (!propStream.read<int32_t>(health)) {
			return ATTR_READ_ERROR;
		}
		if (!propStream.read<uint16_t>(infoId)) {
			return ATTR_READ_ERROR;
		}
		if (!propStream.read<uint8_t>(state)) {
			return ATTR_READ_ERROR;
		}
		if (!propStream.read<uint32_t>(portraitId)) {
			return ATTR_READ_ERROR;
		}

		if (!propStream.read<uint16_t>(ivs.attack)) {
			return ATTR_READ_ERROR;
		}
		if (!propStream.read<uint16_t>(ivs.defense)) {
			return ATTR_READ_ERROR;
		}
		if (!propStream.read<uint16_t>(ivs.health)) {
			return ATTR_READ_ERROR;
		}
		if (!propStream.read<uint16_t>(ivs.specialAttack)) {
			return ATTR_READ_ERROR;
		}
		if (!propStream.read<uint16_t>(ivs.specialDefense)) {
			return ATTR_READ_ERROR;
		}
		if (!propStream.read<uint16_t>(ivs.speed)) {
			return ATTR_READ_ERROR;
		}

		if (!propStream.read<uint16_t>(evs.attack)) {
			return ATTR_READ_ERROR;
		}
		if (!propStream.read<uint16_t>(evs.defense)) {
			return ATTR_READ_ERROR;
		}
		if (!propStream.read<uint16_t>(evs.health)) {
			return ATTR_READ_ERROR;
		}
		if (!propStream.read<uint16_t>(evs.specialAttack)) {
			return ATTR_READ_ERROR;
		}
		if (!propStream.read<uint16_t>(evs.specialDefense)) {
			return ATTR_READ_ERROR;
		}
		if (!propStream.read<uint16_t>(evs.speed)) {
			return ATTR_READ_ERROR;
		}

		uint8_t movesSize{ 0 };
		if (!propStream.read<uint8_t>(movesSize)) {
			return ATTR_READ_ERROR;
		}
		for (size_t i = 0; i < movesSize; i++) {
			moveBlock_t move;
			if (!propStream.read<uint16_t>(move.id)) {
				return ATTR_READ_ERROR;
			}
			if (!propStream.read<uint16_t>(move.level)) {
				return ATTR_READ_ERROR;
			}
			if (!propStream.readString(move.name)) {
				return ATTR_READ_ERROR;
			}
			learnedMoves.insert(std::make_pair(move.id, move));
		}

		uint8_t abilitiesSize{ 0 };
		if (!propStream.read<uint8_t>(abilitiesSize)) {
			return ATTR_READ_ERROR;
		}

		std::string ability;
		for (size_t i = 0; i < abilitiesSize; i++) {
			if (!propStream.readString(ability)) {
				return ATTR_READ_ERROR;
			}
			abilities.push_back(ability);
		}

		uint8_t cooldownsSize{ 0 };
		if (!propStream.read<uint8_t>(cooldownsSize)) {
			return ATTR_READ_ERROR;
		}

		for (size_t i = 0; i < cooldownsSize; i++) {
			std::string moveName;
			uint32_t osTime{ 0 };

			if (!propStream.readString(moveName)) {
				return ATTR_READ_ERROR;
			}
			if (!propStream.read<uint32_t>(osTime)) {
				return ATTR_READ_ERROR;
			}
			moveCooldowns.insert(std::make_pair(moveName, osTime));
		}
		return ATTR_READ_CONTINUE;
	}
	default:
		break;
	}
	return Item::readAttr(attr, propStream);
}

void Pokeball::serializeAttr(PropWriteStream& propWriteStream) const
{
	Item::serializeAttr(propWriteStream);
	propWriteStream.write<uint8_t>(ATTR_POKEBALL_INFO);
	propWriteStream.writeString(name);
	propWriteStream.writeString(nickname);
	propWriteStream.write<uint32_t>(level);
	propWriteStream.write<uint8_t>(gender);
	propWriteStream.write<uint8_t>(nature);
	propWriteStream.write<uint64_t>(experience);
	propWriteStream.write<int32_t>(health);
	propWriteStream.write<uint16_t>(infoId);
	propWriteStream.write<uint8_t>(state);
	propWriteStream.write<uint32_t>(portraitId);

	propWriteStream.write<uint16_t>(ivs.attack);
	propWriteStream.write<uint16_t>(ivs.defense);
	propWriteStream.write<uint16_t>(ivs.health);
	propWriteStream.write<uint16_t>(ivs.specialAttack);
	propWriteStream.write<uint16_t>(ivs.specialDefense);
	propWriteStream.write<uint16_t>(ivs.speed);

	propWriteStream.write<uint16_t>(evs.attack);
	propWriteStream.write<uint16_t>(evs.defense);
	propWriteStream.write<uint16_t>(evs.health);
	propWriteStream.write<uint16_t>(evs.specialAttack);
	propWriteStream.write<uint16_t>(evs.specialDefense);
	propWriteStream.write<uint16_t>(evs.speed);

	propWriteStream.write<uint8_t>(learnedMoves.size());
	for (auto& [id, move] : learnedMoves) {
		propWriteStream.write<uint16_t>(move.id);
		propWriteStream.write<uint16_t>(move.level);
		propWriteStream.writeString(move.name);
	}

	propWriteStream.write<uint8_t>(abilities.size());
	for (auto& ability : abilities) {
		propWriteStream.writeString(ability);
	}

	propWriteStream.write<uint8_t>(moveCooldowns.size());
	for (auto& [moveName, osTime] : moveCooldowns) {
		propWriteStream.writeString(moveName);
		propWriteStream.write<uint32_t>(osTime);
	}
}

void Pokeball::setPokemonName(std::string name)
{
	PokemonType* pType = g_pokemons.getPokemonType(name);
	if (!pType)
	{
		std::cout << "[Warning - Pokeball::setPokemonName] Unknown pokemon " << name << std::endl;
		return;
	}
	this->name = pType->name;
}

void Pokeball::updatePokemonMoves()
{
	if (!pokemon) {
		return;
	}

	PokemonType* pType = g_pokemons.getPokemonType(pokemon->getName());
	if (!pType) {
		return;
	}

	moves.clear();
	for (auto& [id, move] : pType->moves) {
		if (learnedMoves.find(id) != learnedMoves.end()) {
			moves.insert(std::make_pair(id, learnedMoves[id]));
		} else {
			moves.insert(std::make_pair(id, move));
		}
	}
}

bool Pokeball::pokemonLearnMove(moveBlock_t& move)
{
	if (!pokemon) {
		return false;
	}

	PokemonType* pType = g_pokemons.getPokemonType(pokemon->getName());
	if (!pType) {
		return false;
	}

	for (auto& [id, otherMove] : moves) {
		if (move.name == otherMove.name) {
			return false;
		}
	}

	if (hasLearnedMoveId(move.id)) {
		moveBlock_t& learnedMove = learnedMoves[move.id];
		learnedMove.name = move.name;
		learnedMove.level = move.level;
		return true;
	}

	learnedMoves.insert(std::make_pair(move.id, move));
	return true;
}

bool Pokeball::hasLearnedMoveByName(const std::string& moveName)
{
	for (auto& [id, move] : learnedMoves) {
		if (move.name == moveName) {
			return true;
		}
	}
	return false;
}

bool Pokeball::hasLearnedMoveId(uint16_t moveId)
{
	for (auto& [id, move] : learnedMoves) {
		if (move.id == moveId) {
			return true;
		}
	}
	return false;
}

bool Pokeball::hasMoveByName(const std::string& moveName)
{
	for (auto& [id, move] : moves) {
		if (asLowerCaseString(move.name) == asLowerCaseString(moveName)) {
			return true;
		}
	}
	return false;
}

void Pokeball::refresh()
{
	if (!pokemon) {
		return;
	}

	PokemonType* pType = g_pokemons.getPokemonType(pokemon->getName());
	PokemonValues pokemonIvs = pokemon->getIvs();
	PokemonValues pokemonEvs = pokemon->getEvs();

	Pokemon::setPokemonValues(ivs, pokemonIvs.attack, pokemonIvs.defense, pokemonIvs.health, pokemonIvs.specialAttack, pokemonIvs.specialDefense, pokemonIvs.speed);
	Pokemon::setPokemonValues(evs, pokemonEvs.attack, pokemonEvs.defense, pokemonEvs.health, pokemonEvs.specialAttack, pokemonEvs.specialDefense, pokemonEvs.speed);

	setPokemonName(pType->name);
	setPokemonHealth(pType->info.health);

	setPokemonLevel(pokemon->getLevel());
	setPokemonExperience(pokemon->getExperience());
	setPokemonGender(pokemon->getGender());
	setPokemonNature(pokemon->getNature());

	updatePokemonAbilities();
}

void Pokeball::resetMoveCooldown(const std::string& moveName)
{
	if (!hasMoveByName(moveName)) {
		return;
	}

	if (moveCooldowns.find(moveName) != moveCooldowns.end()) {
		moveCooldowns[moveName] = OTSYS_TIME();
	} else {
		moveCooldowns.insert(std::make_pair(moveName, OTSYS_TIME()));
	}
}

uint32_t Pokeball::getMoveOsTime(const std::string& moveName)
{
	if (moveCooldowns.find(moveName) != moveCooldowns.end()) {
		return OTSYS_TIME() - moveCooldowns[moveName];
	}
	return 0;
}

int32_t Pokeball::getMoveCooldown(const std::string& moveName)
{
	InstantSpell* spell = g_spells->getInstantSpellByName(moveName);
	if (!spell) {
		return 0;
	}

	if (moveCooldowns.find(moveName) != moveCooldowns.end()) {
		int32_t elapsedTime = OTSYS_TIME() - moveCooldowns[moveName];
		int32_t spellCooldown = spell->getCooldown();
		int32_t cooldown = (spellCooldown - std::min(elapsedTime, spellCooldown));
		return std::max(0, cooldown);
	}
	return 0;
}
