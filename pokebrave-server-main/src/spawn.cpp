// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#include "otpch.h"

#include "spawn.h"
#include "game.h"
#include "pokemon.h"
#include "configmanager.h"
#include "scheduler.h"

#include "pugicast.h"
#include "events.h"

extern ConfigManager g_config;
extern Pokemons g_pokemons;
extern Game g_game;
extern Events* g_events;

static constexpr int32_t MINSPAWN_INTERVAL = 10 * 1000; // 10 seconds to match RME
static constexpr int32_t MAXSPAWN_INTERVAL = 24 * 60 * 60 * 1000; // 1 day

bool Spawns::loadFromXml(const std::string& filename)
{
	if (loaded) {
		return true;
	}

	pugi::xml_document doc;
	pugi::xml_parse_result result = doc.load_file(filename.c_str());
	if (!result) {
		printXMLError("Error - Spawns::loadFromXml", filename, result);
		return false;
	}

	this->filename = filename;
	loaded = true;

	for (auto spawnNode : doc.child("spawns").children()) {
		Position centerPos(
			pugi::cast<uint16_t>(spawnNode.attribute("centerx").value()),
			pugi::cast<uint16_t>(spawnNode.attribute("centery").value()),
			pugi::cast<uint16_t>(spawnNode.attribute("centerz").value())
		);

		int32_t radius;
		pugi::xml_attribute radiusAttribute = spawnNode.attribute("radius");
		if (radiusAttribute) {
			radius = pugi::cast<int32_t>(radiusAttribute.value());
		} else {
			radius = -1;
		}

		if (radius > 30) {
			std::cout << "[Warning - Spawns::loadFromXml] Radius size bigger than 30 at position: " << centerPos << ", consider lowering it." << std::endl;
		}

		if (!spawnNode.first_child()) {
			std::cout << "[Warning - Spawns::loadFromXml] Empty spawn at position: " << centerPos << " with radius: " << radius << '.' << std::endl;
			continue;
		}

		spawnList.emplace_front(centerPos, radius);
		Spawn& spawn = spawnList.front();

		for (auto childNode : spawnNode.children()) {
			if (strcasecmp(childNode.name(), "pokemons") == 0) {
				Position pos(
					centerPos.x + pugi::cast<uint16_t>(childNode.attribute("x").value()),
					centerPos.y + pugi::cast<uint16_t>(childNode.attribute("y").value()),
					centerPos.z
				);

				int32_t interval = pugi::cast<int32_t>(childNode.attribute("spawntime").value()) * 1000;
				if (interval < MINSPAWN_INTERVAL) {
					std::cout << "[Warning - Spawns::loadFromXml] " << pos << " spawntime can not be less than " << MINSPAWN_INTERVAL / 1000 << " seconds." << std::endl;
					continue;
				} else if (interval > MAXSPAWN_INTERVAL) {
					std::cout << "[Warning - Spawns::loadFromXml] " << pos << " spawntime can not be more than " << MAXSPAWN_INTERVAL / 1000 << " seconds." << std::endl;
					continue;
				}

				size_t pokemonsCount = std::distance(childNode.children().begin(), childNode.children().end());
				if (pokemonsCount == 0) {
					std::cout << "[Warning - Spawns::loadFromXml] " << pos << " empty pokemons set." << std::endl;
					continue;
				}

				uint16_t totalChance = 0;
				spawnBlock_t sb;
				sb.pos = pos;
				sb.direction = DIRECTION_NORTH;
				sb.interval = interval;
				sb.lastSpawn = 0;

				for (auto pokemonNode : childNode.children()) {
					pugi::xml_attribute nameAttribute = pokemonNode.attribute("name");
					if (!nameAttribute) {
						continue;
					}

					PokemonType* pType = g_pokemons.getPokemonType(nameAttribute.as_string());
					if (!pType) {
						std::cout << "[Warning - Spawn::loadFromXml] " << pos << " can not find " << nameAttribute.as_string() << std::endl;
						continue;
					}

					uint16_t chance = 100 / pokemonsCount;
					pugi::xml_attribute chanceAttribute = pokemonNode.attribute("chance");
					if (chanceAttribute) {
						chance = pugi::cast<uint16_t>(chanceAttribute.value());
					}

					if (chance + totalChance > 100) {
						chance = 100 - totalChance;
						totalChance = 100;
						std::cout << "[Warning - Spawns::loadFromXml] " << pType->name << ' ' << pos << " total chance for set can not be higher than 100." << std::endl;
					} else {
						totalChance += chance;
					}

					sb.mTypes.push_back({pType, chance});
				}

				if (sb.mTypes.empty()) {
					std::cout << "[Warning - Spawns::loadFromXml] " << pos << " empty pokemons set." << std::endl;
					continue;
				}

				sb.mTypes.shrink_to_fit();
				if (sb.mTypes.size() > 1) {
					std::sort(sb.mTypes.begin(), sb.mTypes.end(), [](std::pair<PokemonType*, uint16_t> a, std::pair<PokemonType*, uint16_t> b) {
						return a.second > b.second;
					});
				}

				spawn.addBlock(sb);
			} else if (strcasecmp(childNode.name(), "monster") == 0) {
				pugi::xml_attribute nameAttribute = childNode.attribute("name");
				if (!nameAttribute) {
					continue;
				}

				Direction dir;

				pugi::xml_attribute directionAttribute = childNode.attribute("direction");
				if (directionAttribute) {
					dir = static_cast<Direction>(pugi::cast<uint16_t>(directionAttribute.value()));
				} else {
					dir = DIRECTION_NORTH;
				}

				Position pos(
					centerPos.x + pugi::cast<uint16_t>(childNode.attribute("x").value()),
					centerPos.y + pugi::cast<uint16_t>(childNode.attribute("y").value()),
					centerPos.z
				);
				int32_t interval = pugi::cast<int32_t>(childNode.attribute("spawntime").value()) * 1000;
				if (interval >= MINSPAWN_INTERVAL && interval <= MAXSPAWN_INTERVAL) {
					spawn.addPokemon(nameAttribute.as_string(), pos, dir, static_cast<uint32_t>(interval));
				} else {
					if (interval < MINSPAWN_INTERVAL) {
						std::cout << "[Warning - Spawns::loadFromXml] " << nameAttribute.as_string() << ' ' << pos << " spawntime can not be less than " << MINSPAWN_INTERVAL / 1000 << " seconds." << std::endl;
					} else {
						std::cout << "[Warning - Spawns::loadFromXml] " << nameAttribute.as_string() << ' ' << pos << " spawntime can not be more than " << MAXSPAWN_INTERVAL / 1000 << " seconds." << std::endl;
					}
				}
			} else if (strcasecmp(childNode.name(), "npc") == 0) {
				pugi::xml_attribute nameAttribute = childNode.attribute("name");
				if (!nameAttribute) {
					continue;
				}

				Npc* npc = Npc::createNpc(nameAttribute.as_string());
				if (!npc) {
					continue;
				}

				pugi::xml_attribute directionAttribute = childNode.attribute("direction");
				if (directionAttribute) {
					npc->setDirection(static_cast<Direction>(pugi::cast<uint16_t>(directionAttribute.value())));
				}

				npc->setMasterPos(Position(
					centerPos.x + pugi::cast<uint16_t>(childNode.attribute("x").value()),
					centerPos.y + pugi::cast<uint16_t>(childNode.attribute("y").value()),
					centerPos.z
				), radius);
				npcList.push_front(npc);
			}
		}
	}
	return true;
}

void Spawns::startup()
{
	if (!loaded || isStarted()) {
		return;
	}

	for (Npc* npc : npcList) {
		if (!g_game.placeCreature(npc, npc->getMasterPos(), false, true)) {
			std::cout << "[Warning - Spawns::startup] Couldn't spawn npc \"" << npc->getName() << "\" on position: " << npc->getMasterPos() << '.' << std::endl;
			delete npc;
		}
	}
	npcList.clear();

	for (Spawn& spawn : spawnList) {
		spawn.startup();
	}

	started = true;
}

void Spawns::clear()
{
	for (Spawn& spawn : spawnList) {
		spawn.stopEvent();
	}
	spawnList.clear();

	loaded = false;
	started = false;
	filename.clear();
}

bool Spawns::isInZone(const Position& centerPos, int32_t radius, const Position& pos)
{
	if (radius == -1) {
		return true;
	}

	return ((pos.getX() >= centerPos.getX() - radius) && (pos.getX() <= centerPos.getX() + radius) &&
			(pos.getY() >= centerPos.getY() - radius) && (pos.getY() <= centerPos.getY() + radius));
}

void Spawn::startSpawnCheck()
{
	if (checkSpawnEvent == 0) {
		checkSpawnEvent = g_scheduler.addEvent(createSchedulerTask(getInterval(), std::bind(&Spawn::checkSpawn, this)));
	}
}

Spawn::~Spawn()
{
	for (const auto& it : spawnedMap) {
		Pokemon* pokemon = it.second;
		pokemon->setSpawn(nullptr);
		pokemon->decrementReferenceCounter();
	}
}

bool Spawn::findPlayer(const Position& pos)
{
	SpectatorVec spectators;
	g_game.map.getSpectators(spectators, pos, false, true);
	for (Creature* spectator : spectators) {
		if (!spectator->getPlayer()->hasFlag(PlayerFlag_IgnoredByPokemons)) {
			return true;
		}
	}
	return false;
}

bool Spawn::isInSpawnZone(const Position& pos)
{
	return Spawns::isInZone(centerPos, radius, pos);
}

bool Spawn::spawnPokemon(uint32_t spawnId, spawnBlock_t sb, bool startup/* = false*/)
{
	bool isBlocked = !startup && findPlayer(sb.pos);
	size_t pokemonsCount = sb.mTypes.size(), blockedPokemons = 0;

	const auto spawnFunc = [&](bool roll) {
		for (const auto& pair : sb.mTypes) {
			if (isBlocked && !pair.first->info.isIgnoringSpawnBlock) {
				++blockedPokemons;
				continue;
			}

			if (!roll) {
				return spawnPokemon(spawnId, pair.first, sb.pos, sb.direction, startup);
			}

			if (pair.second >= normal_random(1, 100) && spawnPokemon(spawnId, pair.first, sb.pos, sb.direction, startup)) {
				return true;
			}
		}

		return false;
	};

	// Try to spawn something with chance check, unless it's single spawn
	if (spawnFunc(pokemonsCount > 1)) {
		return true;
	}

	// Every pokemon spawn is blocked, bail out
	if (pokemonsCount == blockedPokemons) {
		return false;
	}

	// Just try to spawn something without chance check
	return spawnFunc(false);
}

bool Spawn::spawnPokemon(uint32_t spawnId, PokemonType* pType, const Position& pos, Direction dir, bool startup/*= false*/)
{
	std::unique_ptr<Pokemon> pokemon_ptr(new Pokemon(pType));
	if (!g_events->eventPokemonOnSpawn(pokemon_ptr.get(), pos, startup, false)) {
		return false;
	}

	if (startup) {
		//No need to send out events to the surrounding since there is no one out there to listen!
		if (!g_game.internalPlaceCreature(pokemon_ptr.get(), pos, true)) {
			std::cout << "[Warning - Spawns::startup] Couldn't spawn pokemon \"" << pokemon_ptr->getName() << "\" on position: " << pos << '.' << std::endl;
			return false;
		}
	} else {
		if (!g_game.placeCreature(pokemon_ptr.get(), pos, false, true)) {
			return false;
		}
	}

	Pokemon* pokemon = pokemon_ptr.release();
	pokemon->setDirection(dir);
	pokemon->setSpawn(this);
	pokemon->setMasterPos(pos);
	pokemon->incrementReferenceCounter();

	spawnedMap.insert({spawnId, pokemon});
	spawnMap[spawnId].lastSpawn = OTSYS_TIME();
	return true;
}

void Spawn::startup()
{
	for (const auto& it : spawnMap) {
		uint32_t spawnId = it.first;
		const spawnBlock_t& sb = it.second;
		spawnPokemon(spawnId, sb, true);
	}
}

void Spawn::checkSpawn()
{
	checkSpawnEvent = 0;

	cleanup();

	uint32_t spawnCount = 0;

	for (auto& it : spawnMap) {
		uint32_t spawnId = it.first;
		if (spawnedMap.find(spawnId) != spawnedMap.end()) {
			continue;
		}

		spawnBlock_t& sb = it.second;
		if (OTSYS_TIME() >= sb.lastSpawn + sb.interval) {
			if (!spawnPokemon(spawnId, sb)) {
				sb.lastSpawn = OTSYS_TIME();
				continue;
			}

			if (++spawnCount >= static_cast<uint32_t>(g_config.getNumber(ConfigManager::RATE_SPAWN))) {
				break;
			}
		}
	}

	if (spawnedMap.size() < spawnMap.size()) {
		checkSpawnEvent = g_scheduler.addEvent(createSchedulerTask(getInterval(), std::bind(&Spawn::checkSpawn, this)));
	}
}

void Spawn::cleanup()
{
	auto it = spawnedMap.begin();
	while (it != spawnedMap.end()) {
		uint32_t spawnId = it->first;
		Pokemon* pokemon = it->second;
		if (pokemon->isRemoved()) {
			pokemon->decrementReferenceCounter();
			it = spawnedMap.erase(it);
		} else if (!isInSpawnZone(pokemon->getPosition()) && spawnId != 0) {
			spawnedMap.insert({0, pokemon});
			it = spawnedMap.erase(it);
		} else {
			++it;
		}
	}
}

bool Spawn::addBlock(spawnBlock_t sb)
{
	interval = std::min(interval, sb.interval);
	spawnMap[spawnMap.size() + 1] = sb;

	return true;
}

bool Spawn::addPokemon(const std::string& name, const Position& pos, Direction dir, uint32_t interval)
{
	PokemonType* pType = g_pokemons.getPokemonType(name);
	if (!pType) {
		std::cout << "[Warning - Spawn::addPokemon] Can not find " << name << std::endl;
		return false;
	}

	spawnBlock_t sb;
	sb.mTypes.push_back({pType, 100});
	sb.pos = pos;
	sb.direction = dir;
	sb.interval = interval;
	sb.lastSpawn = 0;

	return addBlock(sb);
}

void Spawn::removePokemon(Pokemon* pokemon)
{
	for (auto it = spawnedMap.begin(), end = spawnedMap.end(); it != end; ++it) {
		if (it->second == pokemon) {
			pokemon->decrementReferenceCounter();
			spawnedMap.erase(it);
			break;
		}
	}
}

void Spawn::stopEvent()
{
	if (checkSpawnEvent != 0) {
		g_scheduler.stopEvent(checkSpawnEvent);
		checkSpawnEvent = 0;
	}
}
