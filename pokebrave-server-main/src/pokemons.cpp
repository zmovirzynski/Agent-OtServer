// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#include "otpch.h"

#include "pokemons.h"
#include "pokemon.h"
#include "spells.h"
#include "combat.h"
#include "configmanager.h"
#include "game.h"

#include "pugicast.h"

extern Game g_game;
extern Spells* g_spells;
extern Pokemons g_pokemons;
extern ConfigManager g_config;

spellBlock_t::~spellBlock_t()
{
	if (combatSpell) {
		delete spell;
	}
}

void PokemonType::loadLoot(PokemonType* pokemonType, LootBlock lootBlock)
{
	if (lootBlock.childLoot.empty()) {
		bool isContainer = Item::items[lootBlock.id].isContainer();
		if (isContainer) {
			for (LootBlock child : lootBlock.childLoot) {
				lootBlock.childLoot.push_back(child);
			}
		}
		pokemonType->info.lootItems.push_back(lootBlock);
	} else {
		pokemonType->info.lootItems.push_back(lootBlock);
	}
}

bool Pokemons::reload()
{
	loaded = false;
	scriptInterface.reset();
	return true;
}

ConditionDamage* Pokemons::getDamageCondition(ConditionType_t conditionType,
        int32_t maxDamage, int32_t minDamage, int32_t startDamage, uint32_t tickInterval)
{
	ConditionDamage* condition = static_cast<ConditionDamage*>(Condition::createCondition(CONDITIONID_COMBAT, conditionType, 0, 0));
	condition->setParam(CONDITION_PARAM_TICKINTERVAL, tickInterval);
	condition->setParam(CONDITION_PARAM_MINVALUE, minDamage);
	condition->setParam(CONDITION_PARAM_MAXVALUE, maxDamage);
	condition->setParam(CONDITION_PARAM_STARTVALUE, startDamage);
	condition->setParam(CONDITION_PARAM_DELAYED, 1);
	return condition;
}

bool Pokemons::deserializeSpell(const pugi::xml_node& node, spellBlock_t& sb, const std::string& description)
{
	std::string name;
	std::string scriptName;
	bool isScripted;

	pugi::xml_attribute attr;
	if ((attr = node.attribute("script"))) {
		scriptName = attr.as_string();
		isScripted = true;
	} else if ((attr = node.attribute("name"))) {
		name = attr.as_string();
		isScripted = false;
	} else {
		return false;
	}

	if ((attr = node.attribute("speed")) || (attr = node.attribute("interval"))) {
		sb.speed = std::max<int32_t>(1, pugi::cast<int32_t>(attr.value()));
	}

	if ((attr = node.attribute("chance"))) {
		uint32_t chance = pugi::cast<uint32_t>(attr.value());
		if (chance > 100) {
			chance = 100;
			std::cout << "[Warning - Pokemons::deserializeSpell] " << description << " - Chance value out of bounds for spell: " << name << std::endl;
		}
		sb.chance = chance;
	} else if (asLowerCaseString(name) != "melee") {
		std::cout << "[Warning - Pokemons::deserializeSpell] " << description << " - Missing chance value on non-melee spell: " << name << std::endl;
	}

	if ((attr = node.attribute("range"))) {
		uint32_t range = pugi::cast<uint32_t>(attr.value());
		if (range > (Map::maxViewportX * 2)) {
			range = Map::maxViewportX * 2;
		}
		sb.range = range;
	}

	if ((attr = node.attribute("min"))) {
		sb.minCombatValue = pugi::cast<int32_t>(attr.value());
	}

	if ((attr = node.attribute("max"))) {
		sb.maxCombatValue = pugi::cast<int32_t>(attr.value());

		//normalize values
		if (std::abs(sb.minCombatValue) > std::abs(sb.maxCombatValue)) {
			int32_t value = sb.maxCombatValue;
			sb.maxCombatValue = sb.minCombatValue;
			sb.minCombatValue = value;
		}
	}

	if (auto spell = g_spells->getSpellByName(name)) {
		sb.spell = spell;
		return true;
	}

	CombatSpell* combatSpell = nullptr;
	bool needTarget = false;
	bool needDirection = false;

	if (isScripted) {
		if ((attr = node.attribute("direction"))) {
			needDirection = attr.as_bool();
		}

		if ((attr = node.attribute("target"))) {
			needTarget = attr.as_bool();
		}

		std::unique_ptr<CombatSpell> combatSpellPtr(new CombatSpell(nullptr, needTarget, needDirection));
		if (!combatSpellPtr->loadScript("data/" + g_spells->getScriptBaseName() + "/scripts/" + scriptName)) {
			return false;
		}

		if (!combatSpellPtr->loadScriptCombat()) {
			return false;
		}

		combatSpell = combatSpellPtr.release();
		combatSpell->getCombat()->setPlayerCombatValues(COMBAT_FORMULA_DAMAGE, sb.minCombatValue, 0, sb.maxCombatValue, 0);
	} else {
		Combat_ptr combat = std::make_shared<Combat>();
		if ((attr = node.attribute("length"))) {
			int32_t length = pugi::cast<int32_t>(attr.value());
			if (length > 0) {
				int32_t spread = 3;

				//need direction spell
				if ((attr = node.attribute("spread"))) {
					spread = std::max<int32_t>(0, pugi::cast<int32_t>(attr.value()));
				}

				AreaCombat* area = new AreaCombat();
				area->setupArea(length, spread);
				combat->setArea(area);

				needDirection = true;
			}
		}

		if ((attr = node.attribute("radius"))) {
			int32_t radius = pugi::cast<int32_t>(attr.value());

			//target spell
			if ((attr = node.attribute("target"))) {
				needTarget = attr.as_bool();
			}

			AreaCombat* area = new AreaCombat();
			area->setupArea(radius);
			combat->setArea(area);
		}

		std::string tmpName = asLowerCaseString(name);

		if (tmpName == "melee") {
			sb.isMelee = true;

			pugi::xml_attribute attackAttribute, skillAttribute;
			if ((attackAttribute = node.attribute("attack")) && (skillAttribute = node.attribute("skill"))) {
				sb.minCombatValue = 0;
				sb.maxCombatValue = 0;
			}

			ConditionType_t conditionType = CONDITION_NONE;
			int32_t minDamage = 0;
			int32_t maxDamage = 0;
			uint32_t tickInterval = 2000;

			if ((attr = node.attribute("fire"))) {
				conditionType = CONDITION_FIRE;

				minDamage = pugi::cast<int32_t>(attr.value());
				maxDamage = minDamage;
				tickInterval = 9000;
			} else if ((attr = node.attribute("poison"))) {
				conditionType = CONDITION_POISON;

				minDamage = pugi::cast<int32_t>(attr.value());
				maxDamage = minDamage;
				tickInterval = 4000;
			} else if ((attr = node.attribute("energy"))) {
				conditionType = CONDITION_ENERGY;

				minDamage = pugi::cast<int32_t>(attr.value());
				maxDamage = minDamage;
				tickInterval = 10000;
			} else if ((attr = node.attribute("drown"))) {
				conditionType = CONDITION_DROWN;

				minDamage = pugi::cast<int32_t>(attr.value());
				maxDamage = minDamage;
				tickInterval = 5000;
			} else if ((attr = node.attribute("freeze"))) {
				conditionType = CONDITION_FREEZING;

				minDamage = pugi::cast<int32_t>(attr.value());
				maxDamage = minDamage;
				tickInterval = 8000;
			} else if ((attr = node.attribute("dazzle"))) {
				conditionType = CONDITION_DAZZLED;

				minDamage = pugi::cast<int32_t>(attr.value());
				maxDamage = minDamage;
				tickInterval = 10000;
			} else if ((attr = node.attribute("curse"))) {
				conditionType = CONDITION_CURSED;

				minDamage = pugi::cast<int32_t>(attr.value());
				maxDamage = minDamage;
				tickInterval = 4000;
			} else if ((attr = node.attribute("bleed")) || (attr = node.attribute("normal"))) {
				conditionType = CONDITION_BLEEDING;
				tickInterval = 4000;
			}

			if ((attr = node.attribute("tick"))) {
				int32_t value = pugi::cast<int32_t>(attr.value());
				if (value > 0) {
					tickInterval = value;
				}
			}

			if (conditionType != CONDITION_NONE) {
				Condition* condition = getDamageCondition(conditionType, maxDamage, minDamage, 0, tickInterval);
				combat->addCondition(condition);
			}

			sb.range = 1;
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_NORMALDAMAGE);
			combat->setParam(COMBAT_PARAM_BLOCKARMOR, 1);
			combat->setParam(COMBAT_PARAM_BLOCKSHIELD, 1);
			combat->setOrigin(ORIGIN_MELEE);
		} else if (tmpName == "normal") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_NORMALDAMAGE);
			combat->setParam(COMBAT_PARAM_BLOCKARMOR, 1);
			combat->setOrigin(ORIGIN_RANGED);
		} else if (tmpName == "bleed") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_NORMALDAMAGE);
		} else if (tmpName == "rock") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_ROCKDAMAGE);
		} else if (tmpName == "grass") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_GRASSDAMAGE);
		} else if (tmpName == "fire") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE);
		} else if (tmpName == "eletric") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_ELETRICDAMAGE);
		} else if (tmpName == "bug") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_BUGDAMAGE);
		} else if (tmpName == "ice") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE);
		} else if (tmpName == "psychic") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_PSYCHICDAMAGE);
		} else if (tmpName == "water") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_WATERDAMAGE);
		} else if (tmpName == "fairy") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_FAIRYDAMAGE);
		} else if (tmpName == "fighting") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_FIGHTINGDAMAGE);
		} else if (tmpName == "steel") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_STEELDAMAGE);
		} else if (tmpName == "flying") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_FLYINGDAMAGE);
		} else if (tmpName == "dark") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_DARKDAMAGE);
		} else if (tmpName == "ghost") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_GHOSTDAMAGE);
		} else if (tmpName == "ground") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_GROUNDDAMAGE);
		} else if (tmpName == "dragon") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_DRAGONDAMAGE);
		} else if (tmpName == "ground") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_GROUNDDAMAGE);
		} else if (tmpName == "poison") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_POISONDAMAGE);
		} else if (tmpName == "healing") {
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_HEALING);
			combat->setParam(COMBAT_PARAM_AGGRESSIVE, 0);
		} else if (tmpName == "speed") {
			int32_t minSpeedChange = 0;
			int32_t maxSpeedChange = 0;
			int32_t duration = 10000;

			if ((attr = node.attribute("duration"))) {
				duration = pugi::cast<int32_t>(attr.value());
			}

			if ((attr = node.attribute("speedchange"))) {
				minSpeedChange = pugi::cast<int32_t>(attr.value());
			} else if ((attr = node.attribute("minspeedchange"))) {
				minSpeedChange = pugi::cast<int32_t>(attr.value());

				if ((attr = node.attribute("maxspeedchange"))) {
					maxSpeedChange = pugi::cast<int32_t>(attr.value());
				}

				if (minSpeedChange == 0) {
					std::cout << "[Error - Pokemons::deserializeSpell] - " << description << " - missing speedchange/minspeedchange value" << std::endl;
					return false;
				}

				if (maxSpeedChange == 0) {
					maxSpeedChange = minSpeedChange; // static speedchange value
				}
			}

			if (minSpeedChange < -1000) {
				std::cout << "[Warning - Pokemons::deserializeSpell] - " << description << " - you cannot reduce a creatures speed below -1000 (100%)" << std::endl;
				minSpeedChange = -1000;
			}

			ConditionType_t conditionType;
			if (minSpeedChange >= 0) {
				conditionType = CONDITION_HASTE;
				combat->setParam(COMBAT_PARAM_AGGRESSIVE, 0);
			} else {
				conditionType = CONDITION_PARALYZE;
			}

			ConditionSpeed* condition = static_cast<ConditionSpeed*>(Condition::createCondition(CONDITIONID_COMBAT, conditionType, duration, 0));
			condition->setFormulaVars(minSpeedChange / 1000.0, 0, maxSpeedChange / 1000.0, 0);
			combat->addCondition(condition);
		} else if (tmpName == "outfit") {
			int32_t duration = 10000;

			if ((attr = node.attribute("duration"))) {
				duration = pugi::cast<int32_t>(attr.value());
			}

			if ((attr = node.attribute("pokemon"))) {
				PokemonType* pType = g_pokemons.getPokemonType(attr.as_string());
				if (pType) {
					ConditionOutfit* condition = static_cast<ConditionOutfit*>(Condition::createCondition(CONDITIONID_COMBAT, CONDITION_OUTFIT, duration, 0));
					condition->setOutfit(pType->info.outfit);
					combat->setParam(COMBAT_PARAM_AGGRESSIVE, 0);
					combat->addCondition(condition);
				}
			} else if ((attr = node.attribute("item"))) {
				Outfit_t outfit;
				outfit.lookTypeEx = pugi::cast<uint16_t>(attr.value());

				ConditionOutfit* condition = static_cast<ConditionOutfit*>(Condition::createCondition(CONDITIONID_COMBAT, CONDITION_OUTFIT, duration, 0));
				condition->setOutfit(outfit);
				combat->setParam(COMBAT_PARAM_AGGRESSIVE, 0);
				combat->addCondition(condition);
			}
		} else if (tmpName == "invisible") {
			int32_t duration = 10000;

			if ((attr = node.attribute("duration"))) {
				duration = pugi::cast<int32_t>(attr.value());
			}

			Condition* condition = Condition::createCondition(CONDITIONID_COMBAT, CONDITION_INVISIBLE, duration, 0);
			combat->setParam(COMBAT_PARAM_AGGRESSIVE, 0);
			combat->addCondition(condition);
		} else if (tmpName == "drunk") {
			int32_t duration = 10000;
			uint8_t drunkenness = 25;

			if ((attr = node.attribute("duration"))) {
				duration = pugi::cast<int32_t>(attr.value());
			}

			if ((attr = node.attribute("drunkenness"))) {
				drunkenness = pugi::cast<uint8_t>(attr.value());
			}

			Condition* condition = Condition::createCondition(CONDITIONID_COMBAT, CONDITION_DRUNK, duration, drunkenness);
			combat->addCondition(condition);
		} else if (tmpName == "firefield") {
			combat->setParam(COMBAT_PARAM_CREATEITEM, ITEM_FIREFIELD_PVP_FULL);
		} else if (tmpName == "poisonfield") {
			combat->setParam(COMBAT_PARAM_CREATEITEM, ITEM_POISONFIELD_PVP);
		} else if (tmpName == "energyfield") {
			combat->setParam(COMBAT_PARAM_CREATEITEM, ITEM_ENERGYFIELD_PVP);
		} else if (tmpName == "firecondition" || tmpName == "energycondition" ||
				   tmpName == "earthcondition" || tmpName == "poisoncondition" ||
				   tmpName == "icecondition" || tmpName == "freezecondition" ||
				   tmpName == "deathcondition" || tmpName == "cursecondition" ||
				   tmpName == "holycondition" || tmpName == "dazzlecondition" ||
				   tmpName == "drowncondition" || tmpName == "bleedcondition" ||
				   tmpName == "physicalcondition") {
			ConditionType_t conditionType = CONDITION_NONE;
			uint32_t tickInterval = 2000;

			if (tmpName == "firecondition") {
				conditionType = CONDITION_FIRE;
				tickInterval = 10000;
			} else if (tmpName == "poisoncondition" || tmpName == "earthcondition") {
				conditionType = CONDITION_POISON;
				tickInterval = 4000;
			} else if (tmpName == "energycondition") {
				conditionType = CONDITION_ENERGY;
				tickInterval = 10000;
			} else if (tmpName == "drowncondition") {
				conditionType = CONDITION_DROWN;
				tickInterval = 5000;
			} else if (tmpName == "freezecondition" || tmpName == "icecondition") {
				conditionType = CONDITION_FREEZING;
				tickInterval = 10000;
			} else if (tmpName == "cursecondition" || tmpName == "deathcondition") {
				conditionType = CONDITION_CURSED;
				tickInterval = 4000;
			} else if (tmpName == "dazzlecondition" || tmpName == "holycondition") {
				conditionType = CONDITION_DAZZLED;
				tickInterval = 10000;
			} else if (tmpName == "physicalcondition" || tmpName == "bleedcondition") {
				conditionType = CONDITION_BLEEDING;
				tickInterval = 4000;
			}

			if ((attr = node.attribute("tick"))) {
				int32_t value = pugi::cast<int32_t>(attr.value());
				if (value > 0) {
					tickInterval = value;
				}
			}

			int32_t minDamage = std::abs(sb.minCombatValue);
			int32_t maxDamage = std::abs(sb.maxCombatValue);
			int32_t startDamage = 0;

			if ((attr = node.attribute("start"))) {
				int32_t value = std::abs(pugi::cast<int32_t>(attr.value()));
				if (value <= minDamage) {
					startDamage = value;
				}
			}

			Condition* condition = getDamageCondition(conditionType, maxDamage, minDamage, startDamage, tickInterval);
			combat->addCondition(condition);
		} else if (tmpName == "strength") {
			//
		} else if (tmpName == "effect") {
			//
		} else {
			std::cout << "[Error - Pokemons::deserializeSpell] - " << description << " - Unknown spell name: " << name << std::endl;
			return false;
		}

		combat->setPlayerCombatValues(COMBAT_FORMULA_DAMAGE, sb.minCombatValue, 0, sb.maxCombatValue, 0);
		combatSpell = new CombatSpell(combat, needTarget, needDirection);

		for (auto& attributeNode : node.children()) {
			if ((attr = attributeNode.attribute("key"))) {
				const char* value = attr.value();
				if (strcasecmp(value, "shooteffect") == 0) {
					if ((attr = attributeNode.attribute("value"))) {
						ShootType_t shoot = getShootType(asLowerCaseString(attr.as_string()));
						if (shoot != CONST_ANI_NONE) {
							combat->setParam(COMBAT_PARAM_DISTANCEEFFECT, shoot);
						} else {
							std::cout << "[Warning - Pokemons::deserializeSpell] " << description << " - Unknown shootEffect: " << attr.as_string() << std::endl;
						}
					}
				} else if (strcasecmp(value, "areaeffect") == 0) {
					if ((attr = attributeNode.attribute("value"))) {
						MagicEffectClasses effect = getMagicEffect(asLowerCaseString(attr.as_string()));
						if (effect != CONST_ME_NONE) {
							combat->setParam(COMBAT_PARAM_EFFECT, effect);
						} else {
							std::cout << "[Warning - Pokemons::deserializeSpell] " << description << " - Unknown areaEffect: " << attr.as_string() << std::endl;
						}
					}
				} else {
					std::cout << "[Warning - Pokemons::deserializeSpells] Effect type \"" << attr.as_string() << "\" does not exist." << std::endl;
				}
			}
		}
	}

	sb.spell = combatSpell;
	if (combatSpell) {
		sb.combatSpell = true;
	}
	return true;
}

bool Pokemons::deserializeSpell(PokemonSpell* spell, spellBlock_t& sb, const std::string& description)
{
	if (!spell->scriptName.empty()) {
		spell->isScripted = true;
	} else if (!spell->name.empty()) {
		spell->isScripted = false;
	} else {
		return false;
	}

	sb.speed = spell->interval;

	if (spell->chance > 100) {
		sb.chance = 100;
	} else {
		sb.chance = spell->chance;
	}

	if (spell->range > (Map::maxViewportX * 2)) {
		spell->range = Map::maxViewportX * 2;
	}
	sb.range = spell->range;

	sb.minCombatValue = spell->minCombatValue;
	sb.maxCombatValue = spell->maxCombatValue;
	if (std::abs(sb.minCombatValue) > std::abs(sb.maxCombatValue)) {
		int32_t value = sb.maxCombatValue;
		sb.maxCombatValue = sb.minCombatValue;
		sb.minCombatValue = value;
	}

	sb.spell = g_spells->getSpellByName(spell->name);
	if (sb.spell) {
		return true;
	}

	CombatSpell* combatSpell = nullptr;

	if (spell->isScripted) {
		std::unique_ptr<CombatSpell> combatSpellPtr(new CombatSpell(nullptr, spell->needTarget, spell->needDirection));
		if (!combatSpellPtr->loadScript("data/" + g_spells->getScriptBaseName() + "/scripts/" + spell->scriptName)) {
			std::cout << "cannot find file" << std::endl;
			return false;
		}

		if (!combatSpellPtr->loadScriptCombat()) {
			return false;
		}

		combatSpell = combatSpellPtr.release();
		combatSpell->getCombat()->setPlayerCombatValues(COMBAT_FORMULA_DAMAGE, sb.minCombatValue, 0, sb.maxCombatValue, 0);
	} else {
		Combat_ptr combat = std::make_shared<Combat>();
		sb.combatSpell = true;

		if (spell->length > 0) {
			spell->spread = std::max<int32_t>(0, spell->spread);

			AreaCombat* area = new AreaCombat();
			area->setupArea(spell->length, spell->spread);
			combat->setArea(area);

			spell->needDirection = true;
		}

		if (spell->radius > 0) {
			AreaCombat* area = new AreaCombat();
			area->setupArea(spell->radius);
			combat->setArea(area);
		}

		std::string tmpName = asLowerCaseString(spell->name);

		if (tmpName == "melee") {
			sb.isMelee = true;

			if (spell->attack > 0 && spell->skill > 0) {
				sb.minCombatValue = 0;
				sb.maxCombatValue = 0;
			}

			if (spell->conditionType != CONDITION_NONE) {
				ConditionType_t conditionType = spell->conditionType;

				int32_t minDamage = spell->conditionMinDamage;
				int32_t maxDamage = minDamage;

				uint32_t tickInterval = 2000;
				if (spell->tickInterval != 0) {
					tickInterval = spell->tickInterval;
				}

				Condition* condition = getDamageCondition(conditionType, maxDamage, minDamage, spell->conditionStartDamage, tickInterval);
				combat->addCondition(condition);
			}

			sb.range = 1;
			combat->setParam(COMBAT_PARAM_TYPE, COMBAT_NORMALDAMAGE);
			combat->setParam(COMBAT_PARAM_BLOCKARMOR, 1);
			combat->setParam(COMBAT_PARAM_BLOCKSHIELD, 1);
			combat->setOrigin(ORIGIN_MELEE);
		} else if (tmpName == "combat") {
			if (spell->combatType == COMBAT_NORMALDAMAGE) {
				combat->setParam(COMBAT_PARAM_BLOCKARMOR, 1);
				combat->setOrigin(ORIGIN_RANGED);
			} else if (spell->combatType == COMBAT_HEALING) {
				combat->setParam(COMBAT_PARAM_AGGRESSIVE, 0);
			}
			combat->setParam(COMBAT_PARAM_TYPE, spell->combatType);
		} else if (tmpName == "speed") {
			int32_t minSpeedChange = 0;
			int32_t maxSpeedChange = 0;
			int32_t duration = 10000;

			if (spell->duration != 0) {
				duration = spell->duration;
			}

			if (spell->minSpeedChange != 0) {
				minSpeedChange = spell->minSpeedChange;
			} else {
				std::cout << "[Error - Pokemons::deserializeSpell] - " << description << " - missing speedchange/minspeedchange value" << std::endl;
				delete spell;
				return false;
			}

			if (minSpeedChange < -1000) {
				std::cout << "[Warning - Pokemons::deserializeSpell] - " << description << " - you cannot reduce a creatures speed below -1000 (100%)" << std::endl;
				minSpeedChange = -1000;
			}

			if (spell->maxSpeedChange != 0) {
				maxSpeedChange = spell->maxSpeedChange;
			} else {
				maxSpeedChange = minSpeedChange; // static speedchange value
			}

			ConditionType_t conditionType;
			if (minSpeedChange >= 0) {
				conditionType = CONDITION_HASTE;
				combat->setParam(COMBAT_PARAM_AGGRESSIVE, 0);
			} else {
				conditionType = CONDITION_PARALYZE;
			}

			ConditionSpeed* condition = static_cast<ConditionSpeed*>(Condition::createCondition(CONDITIONID_COMBAT, conditionType, duration, 0));
			condition->setFormulaVars(minSpeedChange / 1000.0, 0, maxSpeedChange / 1000.0, 0);
			combat->addCondition(condition);
		} else if (tmpName == "outfit") {
			int32_t duration = 10000;

			if (spell->duration != 0) {
				duration = spell->duration;
			}

			ConditionOutfit* condition = static_cast<ConditionOutfit*>(Condition::createCondition(CONDITIONID_COMBAT, CONDITION_OUTFIT, duration, 0));
			condition->setOutfit(spell->outfit);
			combat->setParam(COMBAT_PARAM_AGGRESSIVE, 0);
			combat->addCondition(condition);
		} else if (tmpName == "invisible") {
			int32_t duration = 10000;

			if (spell->duration != 0) {
				duration = spell->duration;
			}

			Condition* condition = Condition::createCondition(CONDITIONID_COMBAT, CONDITION_INVISIBLE, duration, 0);
			combat->setParam(COMBAT_PARAM_AGGRESSIVE, 0);
			combat->addCondition(condition);
		} else if (tmpName == "drunk") {
			int32_t duration = 10000;
			uint8_t drunkenness = 25;

			if (spell->duration != 0) {
				duration = spell->duration;
			}

			if (spell->drunkenness != 0) {
				drunkenness = spell->drunkenness;
			}

			Condition* condition = Condition::createCondition(CONDITIONID_COMBAT, CONDITION_DRUNK, duration, drunkenness);
			combat->addCondition(condition);
		} else if (tmpName == "firefield") {
			combat->setParam(COMBAT_PARAM_CREATEITEM, ITEM_FIREFIELD_PVP_FULL);
		} else if (tmpName == "poisonfield") {
			combat->setParam(COMBAT_PARAM_CREATEITEM, ITEM_POISONFIELD_PVP);
		} else if (tmpName == "energyfield") {
			combat->setParam(COMBAT_PARAM_CREATEITEM, ITEM_ENERGYFIELD_PVP);
		} else if (tmpName == "condition") {
			uint32_t tickInterval = 2000;

			if (spell->conditionType == CONDITION_NONE) {
				std::cout << "[Error - Pokemons::deserializeSpell] - " << description << " - Condition is not set for: " << spell->name << std::endl;
			}

			if (spell->tickInterval != 0) {
				int32_t value = spell->tickInterval;
				if (value > 0) {
					tickInterval = value;
				}
			}

			int32_t minDamage = std::abs(spell->conditionMinDamage);
			int32_t maxDamage = std::abs(spell->conditionMaxDamage);
			int32_t startDamage = 0;

			if (spell->conditionStartDamage != 0) {
				int32_t value = std::abs(spell->conditionStartDamage);
				if (value <= minDamage) {
					startDamage = value;
				}
			}

			Condition* condition = getDamageCondition(spell->conditionType, maxDamage, minDamage, startDamage, tickInterval);
			combat->addCondition(condition);
		} else if (tmpName == "strength") {
			//
		} else if (tmpName == "effect") {
			//
		} else {
			std::cout << "[Error - Pokemons::deserializeSpell] - " << description << " - Unknown spell name: " << spell->name << std::endl;
		}

		if (spell->needTarget) {
			if (spell->shoot != CONST_ANI_NONE) {
				combat->setParam(COMBAT_PARAM_DISTANCEEFFECT, spell->shoot);
			}
		}

		if (spell->effect != CONST_ME_NONE) {
			combat->setParam(COMBAT_PARAM_EFFECT, spell->effect);
		}

		combat->setPlayerCombatValues(COMBAT_FORMULA_DAMAGE, sb.minCombatValue, 0, sb.maxCombatValue, 0);
		combatSpell = new CombatSpell(combat, spell->needTarget, spell->needDirection);
	}

	sb.spell = combatSpell;
	if (combatSpell) {
		sb.combatSpell = true;
	}
	return true;
}

PokemonType* Pokemons::loadPokemon(const std::string& file, const std::string& pokemonName, bool reloading /*= false*/)
{
	PokemonType* pType = nullptr;

	pugi::xml_document doc;
	pugi::xml_parse_result result = doc.load_file(file.c_str());
	if (!result) {
		printXMLError("Error - Pokemons::loadPokemon", file, result);
		return nullptr;
	}

	pugi::xml_node pokemonNode = doc.child("monster");
	if (!pokemonNode) {
		std::cout << "[Error - Pokemons::loadPokemon] Missing monster node in: " << file << std::endl;
		return nullptr;
	}

	pugi::xml_attribute attr;
	if (!(attr = pokemonNode.attribute("name"))) {
		std::cout << "[Error - Pokemons::loadPokemon] Missing name in: " << file << std::endl;
		return nullptr;
	}

	if (reloading) {
		auto it = pokemons.find(asLowerCaseString(pokemonName));
		if (it != pokemons.end()) {
			pType = &it->second;
			pType->info = {};
		}
	}

	if (!pType) {
		pType = &pokemons[asLowerCaseString(pokemonName)];
	}

	pType->name = attr.as_string();

	if ((attr = pokemonNode.attribute("nameDescription"))) {
		pType->nameDescription = attr.as_string();
	} else {
		pType->nameDescription = "a " + asLowerCaseString(pType->name);
	}

	if ((attr = pokemonNode.attribute("portrait"))) {
		pType->info.portrait = pugi::cast<uint32_t>(attr.value());
	}

	if ((attr = pokemonNode.attribute("experience"))) {
		pType->info.experience = pugi::cast<uint64_t>(attr.value());
	}

	if ((attr = pokemonNode.attribute("speed"))) {
		pType->info.baseSpeed = pugi::cast<int32_t>(attr.value());
	}

	if ((attr = pokemonNode.attribute("skull"))) {
		pType->info.skull = getSkullType(asLowerCaseString(attr.as_string()));
	}

	if ((attr = pokemonNode.attribute("script"))) {
		if (!scriptInterface) {
			scriptInterface.reset(new LuaScriptInterface("Pokemon Interface"));
			scriptInterface->initState();
		}

		std::string script = attr.as_string();
		if (scriptInterface->loadFile("data/pokemon/scripts/" + script) == 0) {
			pType->info.scriptInterface = scriptInterface.get();
			pType->info.creatureAppearEvent = scriptInterface->getEvent("onCreatureAppear");
			pType->info.creatureDisappearEvent = scriptInterface->getEvent("onCreatureDisappear");
			pType->info.creatureMoveEvent = scriptInterface->getEvent("onCreatureMove");
			pType->info.creatureSayEvent = scriptInterface->getEvent("onCreatureSay");
			pType->info.thinkEvent = scriptInterface->getEvent("onThink");
		} else {
			std::cout << "[Warning - Pokemons::loadPokemon] Can not load script: " << script << std::endl;
			std::cout << scriptInterface->getLastLuaError() << std::endl;
		}
	}

	pugi::xml_node node;
	if ((node = pokemonNode.child("health"))) {
		if ((attr = node.attribute("now"))) {
			pType->info.health = pugi::cast<int32_t>(attr.value());
		} else {
			std::cout << "[Error - Pokemons::loadPokemon] Missing health now. " << file << std::endl;
		}

		if ((attr = node.attribute("max"))) {
			pType->info.healthMax = pugi::cast<int32_t>(attr.value());
		} else {
			std::cout << "[Error - Pokemons::loadPokemon] Missing health max. " << file << std::endl;
		}

		if (pType->info.health > pType->info.healthMax) {
			pType->info.health = pType->info.healthMax;
			std::cout << "[Warning - Pokemons::loadPokemon] Health now is greater than health max." << file << std::endl;
		}
	}

	if ((node = pokemonNode.child("level"))) {
		if ((attr = node.attribute("min"))) {
			pType->info.minSpawnLevel = pugi::cast<uint32_t>(attr.value());
		}
		else {
			std::cout << "[Error - Pokemons::loadPokemon] Missing level min. " << file << std::endl;
		}

		if ((attr = node.attribute("max"))) {
			pType->info.maxSpawnLevel = pugi::cast<uint32_t>(attr.value());
		}
		else {
			std::cout << "[Error - Pokemons::loadPokemon] Missing level max. " << file << std::endl;
		}
	}

	if ((node = pokemonNode.child("gender"))) {
		for (auto& sexNode : node.children()) {
			if (attr = sexNode.attribute("name")) {
				if (strcasecmp(attr.as_string(), "male") == 0) {
					attr = sexNode.attribute("percent");
					pType->info.genderMalePercent = attr.as_double();
				}
				else if (strcasecmp(attr.as_string(), "female") == 0) {
					attr = sexNode.attribute("percent");
					pType->info.genderFemalePercent = attr.as_double();
				}
			}
		}
	}

	if ((node = pokemonNode.child("flags"))) {
		for (auto& flagNode : node.children()) {
			attr = flagNode.first_attribute();
			const char* attrName = attr.name();
			if (strcasecmp(attrName, "catchrate") == 0) {
				pType->info.catchRate = pugi::cast<uint32_t>(attr.value());
			} else if (strcasecmp(attrName, "requiredlevel") == 0) {
				pType->info.requiredLevel = pugi::cast<uint32_t>(attr.value());
			} else if (strcasecmp(attrName, "summonable") == 0) {
				pType->info.isSummonable = attr.as_bool();
			} else if (strcasecmp(attrName, "attackable") == 0) {
				pType->info.isAttackable = attr.as_bool();
			} else if (strcasecmp(attrName, "hostile") == 0) {
				pType->info.isHostile = attr.as_bool();
			} else if (strcasecmp(attrName, "ignorespawnblock") == 0) {
				pType->info.isIgnoringSpawnBlock = attr.as_bool();
			} else if (strcasecmp(attrName, "illusionable") == 0) {
				pType->info.isIllusionable = attr.as_bool();
			} else if (strcasecmp(attrName, "challengeable") == 0) {
				pType->info.isChallengeable = attr.as_bool();
			} else if (strcasecmp(attrName, "convinceable") == 0) {
				pType->info.isConvinceable = attr.as_bool();
			} else if (strcasecmp(attrName, "pushable") == 0) {
				pType->info.pushable = attr.as_bool();
			} else if (strcasecmp(attrName, "isboss") == 0) {
				pType->info.isBoss = attr.as_bool();
			} else if (strcasecmp(attrName, "canpushitems") == 0) {
				pType->info.canPushItems = attr.as_bool();
			} else if (strcasecmp(attrName, "canpushcreatures") == 0) {
				pType->info.canPushCreatures = attr.as_bool();
			} else if (strcasecmp(attrName, "staticattack") == 0) {
				uint32_t staticAttack = pugi::cast<uint32_t>(attr.value());
				if (staticAttack > 100) {
					std::cout << "[Warning - Pokemons::loadPokemon] staticattack greater than 100. " << file << std::endl;
					staticAttack = 100;
				}

				pType->info.staticAttackChance = staticAttack;
			} else if (strcasecmp(attrName, "lightlevel") == 0) {
				pType->info.light.level = pugi::cast<uint16_t>(attr.value());
			} else if (strcasecmp(attrName, "lightcolor") == 0) {
				pType->info.light.color = pugi::cast<uint16_t>(attr.value());
			} else if (strcasecmp(attrName, "targetdistance") == 0) {
				int32_t targetDistance = pugi::cast<int32_t>(attr.value());
				if (targetDistance < 1) {
					targetDistance = 1;
					std::cout << "[Warning - Pokemons::loadPokemon] targetdistance less than 1. " << file << std::endl;
				}
				pType->info.targetDistance = targetDistance;
			} else if (strcasecmp(attrName, "runonhealth") == 0) {
				pType->info.runAwayHealth = pugi::cast<int32_t>(attr.value());
			} else if (strcasecmp(attrName, "hidehealth") == 0) {
				pType->info.hiddenHealth = attr.as_bool();
			} else if (strcasecmp(attrName, "canwalkonenergy") == 0) {
				pType->info.canWalkOnEnergy = attr.as_bool();
			} else if (strcasecmp(attrName, "canwalkonfire") == 0) {
				pType->info.canWalkOnFire = attr.as_bool();
			} else if (strcasecmp(attrName, "canwalkonpoison") == 0) {
				pType->info.canWalkOnPoison = attr.as_bool();
			} else {
				std::cout << "[Warning - Pokemons::loadPokemon] Unknown flag attribute: " << attrName << ". " << file << std::endl;
			}
		}

		// if a pokemon can push creatures,
		// it should not be pushable.
		if (pType->info.canPushCreatures) {
			pType->info.pushable = false;
		}
	}

	if ((node = pokemonNode.child("targetchange"))) {
		if ((attr = node.attribute("speed")) || (attr = node.attribute("interval"))) {
			pType->info.changeTargetSpeed = pugi::cast<uint32_t>(attr.value());
		} else {
			std::cout << "[Warning - Pokemons::loadPokemon] Missing targetchange speed. " << file << std::endl;
		}

		if ((attr = node.attribute("chance"))) {
			int32_t chance = pugi::cast<int32_t>(attr.value());
			if (chance > 100) {
				chance = 100;
				std::cout << "[Warning - Pokemons::loadPokemon] targetchange chance value out of bounds. " << file << std::endl;
			}
			pType->info.changeTargetChance = chance;
		} else {
			std::cout << "[Warning - Pokemons::loadPokemon] Missing targetchange chance. " << file << std::endl;
		}
	}

	if ((node = pokemonNode.child("pokedexinfo"))) {
		for (auto pokedexNode : node.children()) {
			attr = pokedexNode.first_attribute();
			const char* attrName = attr.name();

			if (strcasecmp(attrName, "nationalNumber") == 0) {
				pType->info.nationalNumber = pugi::cast<uint32_t>(attr.value());
			} else if (strcasecmp(attrName, "description") == 0) {
				pType->info.description = attr.as_string();
			} else if (strcasecmp(attrName, "height") == 0.f) {
				pType->info.height = pugi::cast<float>(attr.value());
			} else if (strcasecmp(attrName, "weight") == 0.f) {
				pType->info.weight = pugi::cast<float>(attr.value());
			} else {
				std::cout << "[Warning - Pokemons::loadPokemon] Unknown pokedexinfo attribute: " << attrName << ". " << file << std::endl;
			}
		}
	}

	if ((node = pokemonNode.child("look"))) {
		if ((attr = node.attribute("type"))) {
			pType->info.outfit.lookType = pugi::cast<uint16_t>(attr.value());

			if ((attr = node.attribute("head"))) {
				pType->info.outfit.lookHead = pugi::cast<uint16_t>(attr.value());
			}

			if ((attr = node.attribute("body"))) {
				pType->info.outfit.lookBody = pugi::cast<uint16_t>(attr.value());
			}

			if ((attr = node.attribute("legs"))) {
				pType->info.outfit.lookLegs = pugi::cast<uint16_t>(attr.value());
			}

			if ((attr = node.attribute("feet"))) {
				pType->info.outfit.lookFeet = pugi::cast<uint16_t>(attr.value());
			}

			if ((attr = node.attribute("addons"))) {
				pType->info.outfit.lookAddons = pugi::cast<uint16_t>(attr.value());
			}
		} else if ((attr = node.attribute("typeex"))) {
			pType->info.outfit.lookTypeEx = pugi::cast<uint16_t>(attr.value());
		} else {
			std::cout << "[Warning - Pokemons::loadPokemon] Missing look type/typeex. " << file << std::endl;
		}

		if ((attr = node.attribute("mount"))) {
			pType->info.outfit.lookMount = pugi::cast<uint16_t>(attr.value());
		}

		if ((attr = node.attribute("corpse"))) {
			pType->info.lookcorpse = pugi::cast<uint16_t>(attr.value());
		}
	}

	if ((node = pokemonNode.child("attacks"))) {
		for (auto& attackNode : node.children()) {
			spellBlock_t sb;
			if (deserializeSpell(attackNode, sb, pokemonName)) {
				pType->info.attackSpells.emplace_back(std::move(sb));
			} else {
				std::cout << "[Warning - Pokemons::loadPokemon] Cant load spell. " << file << std::endl;
			}
		}
	}

	if ((node = pokemonNode.child("defenses"))) {
		if ((attr = node.attribute("defense"))) {
			pType->info.defense = pugi::cast<int32_t>(attr.value());
		}

		if ((attr = node.attribute("armor"))) {
			pType->info.armor = pugi::cast<int32_t>(attr.value());
		}

		for (auto& defenseNode : node.children()) {
			spellBlock_t sb;
			if (deserializeSpell(defenseNode, sb, pokemonName)) {
				pType->info.defenseSpells.emplace_back(std::move(sb));
			} else {
				std::cout << "[Warning - Pokemons::loadPokemon] Cant load spell. " << file << std::endl;
			}
		}
	}

	if ((node = pokemonNode.child("evolutions"))) {
		for (auto& evolutionNode : node.children()) {
			std::string name;
			std::string stone;
			uint16_t level {0};

			if (!(attr = evolutionNode.attribute("name"))) {
				continue;
			}
			name = asLowerCaseString(attr.as_string());

			if (!(attr = evolutionNode.attribute("stone"))) {
				continue;
			}
			stone = asLowerCaseString(attr.as_string());

			if (!(attr = evolutionNode.attribute("level"))) {
				continue;
			}
			level = pugi::cast<uint16_t>(attr.value());

			uint16_t stoneId = Item::items.getItemIdByName(stone);
			if (stoneId == 0) {
				std::cout << "[Warning - Pokemons::loadPokemon] Not found item id with name: " << stone << ". " << file << std::endl;
				continue;
			}

			evolutionBlock_t evolution {level, name};
			pType->evolutions.insert(std::make_pair(stoneId, evolution));
		}
	}

	if ((node = pokemonNode.child("moves"))) {
		std::string moveName;
		uint16_t moveId;
		uint16_t moveLevel{ 0 };

		for (auto& moveNode : node.children()) {
			if (!(attr = moveNode.attribute("id"))) {
				continue;
			}
			moveId = pugi::cast<uint16_t>(attr.value());

			if (!(attr = moveNode.attribute("name"))) {
				continue;
			}
			moveName = asLowerCaseString(attr.as_string());

			if (!(attr = moveNode.attribute("level"))) {
				moveLevel = 1;
			}
			moveLevel = pugi::cast<uint16_t>(attr.value());

			moveBlock_t move { moveId, moveLevel, moveName };
			pType->moves.insert(std::make_pair(moveId, move));
		}
	}

	if ((node = pokemonNode.child("tags"))) {
		std::string tagName;
		std::string value;

		for (auto& moveNode : node.children()) {
			if (!(attr = moveNode.attribute("name"))) {
				continue;
			}
			tagName = asLowerCaseString(attr.as_string());

			if (attr = moveNode.attribute("value")) {
				value = asLowerCaseString(attr.as_string());
			}
			pType->tags.insert(std::make_pair(tagName, value));
		}
	}

	if ((node = pokemonNode.child("tms"))) {
		for (auto& tmNode : node.children()) {
			std::string moveName;
			if (!(attr = tmNode.attribute("move"))){
				continue;
			}
			moveName = asLowerCaseString(attr.as_string());
			pType->learnablesTM.emplace_back(moveName);
		}
	}

	if ((node = pokemonNode.child("immunities"))) {
		for (auto& immunityNode : node.children()) {
			if ((attr = immunityNode.attribute("name"))) {
				std::string tmpStrValue = asLowerCaseString(attr.as_string());
				if (tmpStrValue == "normal") {
					pType->info.damageImmunities |= COMBAT_NORMALDAMAGE;
					pType->info.conditionImmunities |= CONDITION_BLEEDING;
				} else if (tmpStrValue == "eletric") {
					pType->info.damageImmunities |= COMBAT_ELETRICDAMAGE;
					pType->info.conditionImmunities |= CONDITION_ENERGY;
				} else if (tmpStrValue == "fire") {
					pType->info.damageImmunities |= COMBAT_FIREDAMAGE;
					pType->info.conditionImmunities |= CONDITION_FIRE;
				} else if (tmpStrValue == "rock") {
					pType->info.damageImmunities |= COMBAT_ROCKDAMAGE;
				} else if (tmpStrValue == "grass") {
					pType->info.damageImmunities |= COMBAT_GRASSDAMAGE;
				} else if (tmpStrValue == "bug") {
					pType->info.damageImmunities |= COMBAT_BUGDAMAGE;
					pType->info.conditionImmunities |= CONDITION_DROWN;
				} else if (tmpStrValue == "ice") {
					pType->info.damageImmunities |= COMBAT_ICEDAMAGE;
					pType->info.conditionImmunities |= CONDITION_FREEZING;
				} else if (tmpStrValue == "psychic") {
					pType->info.damageImmunities |= COMBAT_PSYCHICDAMAGE;
					pType->info.conditionImmunities |= CONDITION_DAZZLED;
				} else if (tmpStrValue == "water") {
					pType->info.damageImmunities |= COMBAT_WATERDAMAGE;
					pType->info.conditionImmunities |= CONDITION_CURSED;
				} else if (tmpStrValue == "poison") {
					pType->info.damageImmunities |= COMBAT_POISONDAMAGE;
				} else if (tmpStrValue == "fairy") {
					pType->info.damageImmunities |= COMBAT_FAIRYDAMAGE;
				} else if (tmpStrValue == "fighting") {
					pType->info.damageImmunities |= COMBAT_FIGHTINGDAMAGE;
				} else if (tmpStrValue == "steel") {
					pType->info.damageImmunities |= COMBAT_STEELDAMAGE;
				} else if (tmpStrValue == "flying") {
					pType->info.damageImmunities |= COMBAT_FLYINGDAMAGE;
				} else if (tmpStrValue == "dark") {
					pType->info.damageImmunities |= COMBAT_DARKDAMAGE;
				} else if (tmpStrValue == "ghost") {
					pType->info.damageImmunities |= COMBAT_GHOSTDAMAGE;
				} else if (tmpStrValue == "ground") {
					pType->info.damageImmunities |= COMBAT_GROUNDDAMAGE;
				} else if (tmpStrValue == "dragon") {
					pType->info.damageImmunities |= COMBAT_DRAGONDAMAGE;
				} else if (tmpStrValue == "ground") {
					pType->info.damageImmunities |= COMBAT_GROUNDDAMAGE;
				} else if (tmpStrValue == "paralyze") {
					pType->info.conditionImmunities |= CONDITION_PARALYZE;
				} else if (tmpStrValue == "outfit") {
					pType->info.conditionImmunities |= CONDITION_OUTFIT;
				} else if (tmpStrValue == "drunk") {
					pType->info.conditionImmunities |= CONDITION_DRUNK;
				} else if (tmpStrValue == "invisible" || tmpStrValue == "invisibility") {
					pType->info.conditionImmunities |= CONDITION_INVISIBLE;
				} else if (tmpStrValue == "bleed") {
					pType->info.conditionImmunities |= CONDITION_BLEEDING;
				} else {
					std::cout << "[Warning - Pokemons::loadPokemon] Unknown immunity name " << attr.as_string() << ". " << file << std::endl;
				}
			} else if ((attr = immunityNode.attribute("normal"))) {
				if (attr.as_bool()) {
					pType->info.damageImmunities |= COMBAT_NORMALDAMAGE;
					pType->info.conditionImmunities |= CONDITION_BLEEDING;
				}
			} else if ((attr = immunityNode.attribute("energy"))) {
				if (attr.as_bool()) {
					pType->info.damageImmunities |= COMBAT_ELETRICDAMAGE;
					pType->info.conditionImmunities |= CONDITION_ENERGY;
				}
			} else if ((attr = immunityNode.attribute("fire"))) {
				if (attr.as_bool()) {
					pType->info.damageImmunities |= COMBAT_FIREDAMAGE;
					pType->info.conditionImmunities |= CONDITION_FIRE;
				}
			} else if (attr = immunityNode.attribute("rock")) {
				if (attr.as_bool()) {
					pType->info.damageImmunities |= COMBAT_ROCKDAMAGE;
					pType->info.conditionImmunities |= CONDITION_POISON;
				}
			} else if (attr = immunityNode.attribute("grass")) {
				if (attr.as_bool()) {
					pType->info.damageImmunities |= COMBAT_GRASSDAMAGE;
				}
			} else if ((attr = immunityNode.attribute("bug"))) {
				if (attr.as_bool()) {
					pType->info.damageImmunities |= COMBAT_BUGDAMAGE;
					pType->info.conditionImmunities |= CONDITION_DROWN;
				}
			} else if ((attr = immunityNode.attribute("ice"))) {
				if (attr.as_bool()) {
					pType->info.damageImmunities |= COMBAT_ICEDAMAGE;
					pType->info.conditionImmunities |= CONDITION_FREEZING;
				}
			} else if ((attr = immunityNode.attribute("psychic"))) {
				if (attr.as_bool()) {
					pType->info.damageImmunities |= COMBAT_PSYCHICDAMAGE;
					pType->info.conditionImmunities |= CONDITION_DAZZLED;
				}
			} else if ((attr = immunityNode.attribute("water"))) {
				if (attr.as_bool()) {
					pType->info.damageImmunities |= COMBAT_WATERDAMAGE;
					pType->info.conditionImmunities |= CONDITION_CURSED;
				}
			} else if ((attr = immunityNode.attribute("fairy"))) {
				if (attr.as_bool()) {
					pType->info.damageImmunities |= COMBAT_FAIRYDAMAGE;
				}
			} else if ((attr = immunityNode.attribute("fighting"))) {
				if (attr.as_bool()) {
					pType->info.damageImmunities |= COMBAT_FIGHTINGDAMAGE;
				}
			} else if ((attr = immunityNode.attribute("steel"))) {
				if (attr.as_bool()) {
					pType->info.damageImmunities |= COMBAT_STEELDAMAGE;
				}
			} else if ((attr = immunityNode.attribute("flying"))) {
				if (attr.as_bool()) {
					pType->info.damageImmunities |= COMBAT_FLYINGDAMAGE;
				}
			} else if ((attr = immunityNode.attribute("dark"))) {
				if (attr.as_bool()) {
					pType->info.damageImmunities |= COMBAT_DARKDAMAGE;
				}
			} else if ((attr = immunityNode.attribute("ghost"))) {
				if (attr.as_bool()) {
					pType->info.damageImmunities |= COMBAT_GHOSTDAMAGE;
				}
			} else if ((attr = immunityNode.attribute("ground"))) {
				if (attr.as_bool()) {
					pType->info.damageImmunities |= COMBAT_GHOSTDAMAGE;
				}
			} else if ((attr = immunityNode.attribute("dragon"))) {
				if (attr.as_bool()) {
					pType->info.damageImmunities |= COMBAT_DRAGONDAMAGE;
				}
			} else if ((attr = immunityNode.attribute("ground"))) {
				if (attr.as_bool()) {
					pType->info.damageImmunities |= COMBAT_GROUNDDAMAGE;
				}
			} else if ((attr = immunityNode.attribute("poison"))) {
				if (attr.as_bool()) {
					pType->info.damageImmunities |= COMBAT_POISONDAMAGE;
				}
			} else if ((attr = immunityNode.attribute("paralyze"))) {
				if (attr.as_bool()) {
					pType->info.conditionImmunities |= CONDITION_PARALYZE;
				}
			} else if ((attr = immunityNode.attribute("outfit"))) {
				if (attr.as_bool()) {
					pType->info.conditionImmunities |= CONDITION_OUTFIT;
				}
			} else if ((attr = immunityNode.attribute("bleed"))) {
				if (attr.as_bool()) {
					pType->info.conditionImmunities |= CONDITION_BLEEDING;
				}
			} else if ((attr = immunityNode.attribute("drunk"))) {
				if (attr.as_bool()) {
					pType->info.conditionImmunities |= CONDITION_DRUNK;
				}
			} else if ((attr = immunityNode.attribute("invisible")) || (attr = immunityNode.attribute("invisibility"))) {
				if (attr.as_bool()) {
					pType->info.conditionImmunities |= CONDITION_INVISIBLE;
				}
			} else {
				std::cout << "[Warning - Pokemons::loadPokemon] Unknown immunity. " << file << std::endl;
			}
		}
	}

	if ((node = pokemonNode.child("voices"))) {
		if ((attr = node.attribute("speed")) || (attr = node.attribute("interval"))) {
			pType->info.yellSpeedTicks = pugi::cast<uint32_t>(attr.value());
		} else {
			std::cout << "[Warning - Pokemons::loadPokemon] Missing voices speed. " << file << std::endl;
		}

		if ((attr = node.attribute("chance"))) {
			uint32_t chance = pugi::cast<uint32_t>(attr.value());
			if (chance > 100) {
				chance = 100;
				std::cout << "[Warning - Pokemons::loadPokemon] yell chance value out of bounds. " << file << std::endl;
			}
			pType->info.yellChance = chance;
		} else {
			std::cout << "[Warning - Pokemons::loadPokemon] Missing voices chance. " << file << std::endl;
		}

		for (auto& voiceNode : node.children()) {
			voiceBlock_t vb;
			if ((attr = voiceNode.attribute("sentence"))) {
				vb.text = attr.as_string();
			} else {
				std::cout << "[Warning - Pokemons::loadPokemon] Missing voice sentence. " << file << std::endl;
			}

			if ((attr = voiceNode.attribute("yell"))) {
				vb.yellText = attr.as_bool();
			} else {
				vb.yellText = false;
			}
			pType->info.voiceVector.emplace_back(vb);
		}
	}

	if ((node = pokemonNode.child("loot"))) {
		for (auto& lootNode : node.children()) {
			LootBlock lootBlock;
			if (loadLootItem(lootNode, lootBlock)) {
				pType->info.lootItems.emplace_back(std::move(lootBlock));
			} else {
				std::cout << "[Warning - Pokemons::loadPokemon] Cant load loot. " << file << std::endl;
			}
		}
	}

	if ((node = pokemonNode.child("elements"))) {
		for (auto& elementNode : node.children()) {
			if ((attr = elementNode.attribute("physicalPercent"))) {
				pType->info.elementMap[COMBAT_NORMALDAMAGE] = pugi::cast<int32_t>(attr.value());
				if (pType->info.damageImmunities & COMBAT_NORMALDAMAGE) {
					std::cout << "[Warning - Pokemons::loadPokemon] Same element \"physical\" on immunity and element tags. " << file << std::endl;
				}
			} else if ((attr = elementNode.attribute("icePercent"))) {
				pType->info.elementMap[COMBAT_ICEDAMAGE] = pugi::cast<int32_t>(attr.value());
				if (pType->info.damageImmunities & COMBAT_ICEDAMAGE) {
					std::cout << "[Warning - Pokemons::loadPokemon] Same element \"ice\" on immunity and element tags. " << file << std::endl;
				}
			} else if ((attr = elementNode.attribute("rockPercent"))) {
				pType->info.elementMap[COMBAT_ROCKDAMAGE] = pugi::cast<int32_t>(attr.value());
				if (pType->info.damageImmunities & COMBAT_ROCKDAMAGE) {
					std::cout << "[Warning - Pokemons::loadPokemon] Same element \"rock\" on immunity and element tags. " << file << std::endl;
				}
			} else if ((attr = elementNode.attribute("grassPercent"))) {
				pType->info.elementMap[COMBAT_GRASSDAMAGE] = pugi::cast<int32_t>(attr.value());
				if (pType->info.damageImmunities & COMBAT_GRASSDAMAGE) {
					std::cout << "[Warning - Pokemons::loadPokemon] Same element \"grass\" on immunity and element tags. " << file << std::endl;
				}
			} else if ((attr = elementNode.attribute("firePercent"))) {
				pType->info.elementMap[COMBAT_FIREDAMAGE] = pugi::cast<int32_t>(attr.value());
				if (pType->info.damageImmunities & COMBAT_FIREDAMAGE) {
					std::cout << "[Warning - Pokemons::loadPokemon] Same element \"fire\" on immunity and element tags. " << file << std::endl;
				}
			} else if ((attr = elementNode.attribute("eletricPercent"))) {
				pType->info.elementMap[COMBAT_ELETRICDAMAGE] = pugi::cast<int32_t>(attr.value());
				if (pType->info.damageImmunities & COMBAT_ELETRICDAMAGE) {
					std::cout << "[Warning - Pokemons::loadPokemon] Same element \"eletric\" on immunity and element tags. " << file << std::endl;
				}
			} else if ((attr = elementNode.attribute("psychicPercent"))) {
				pType->info.elementMap[COMBAT_PSYCHICDAMAGE] = pugi::cast<int32_t>(attr.value());
				if (pType->info.damageImmunities & COMBAT_PSYCHICDAMAGE) {
					std::cout << "[Warning - Pokemons::loadPokemon] Same element \"psychic\" on immunity and element tags. " << file << std::endl;
				}
			} else if ((attr = elementNode.attribute("waterPercent"))) {
				pType->info.elementMap[COMBAT_WATERDAMAGE] = pugi::cast<int32_t>(attr.value());
				if (pType->info.damageImmunities & COMBAT_WATERDAMAGE) {
					std::cout << "[Warning - Pokemons::loadPokemon] Same element \"water\" on immunity and element tags. " << file << std::endl;
				}
			} else if ((attr = elementNode.attribute("fairyPercent"))) {
				pType->info.elementMap[COMBAT_FAIRYDAMAGE] = pugi::cast<int32_t>(attr.value());
				if (pType->info.damageImmunities & COMBAT_FAIRYDAMAGE) {
					std::cout << "[Warning - Pokemons::loadPokemon] Same element \"fairy\" on immunity and element tags. " << file << std::endl;
				}
			} else if ((attr = elementNode.attribute("steelPercent"))) {
				pType->info.elementMap[COMBAT_STEELDAMAGE] = pugi::cast<int32_t>(attr.value());
				if (pType->info.damageImmunities & COMBAT_STEELDAMAGE) {
					std::cout << "[Warning - Pokemons::loadPokemon] Same element \"steel\" on immunity and element tags. " << file << std::endl;
				}
			} else if ((attr = elementNode.attribute("flyingPercent"))) {
				pType->info.elementMap[COMBAT_FLYINGDAMAGE] = pugi::cast<int32_t>(attr.value());
				if (pType->info.damageImmunities & COMBAT_FLYINGDAMAGE) {
					std::cout << "[Warning - Pokemons::loadPokemon] Same element \"flying\" on immunity and element tags. " << file << std::endl;
				}
			} else if ((attr = elementNode.attribute("darkPercent"))) {
				pType->info.elementMap[COMBAT_DARKDAMAGE] = pugi::cast<int32_t>(attr.value());
				if (pType->info.damageImmunities & COMBAT_DARKDAMAGE) {
					std::cout << "[Warning - Pokemons::loadPokemon] Same element \"dark\" on immunity and element tags. " << file << std::endl;
				}
			} else if ((attr = elementNode.attribute("ghostPercent"))) {
				pType->info.elementMap[COMBAT_GHOSTDAMAGE] = pugi::cast<int32_t>(attr.value());
				if (pType->info.damageImmunities & COMBAT_GHOSTDAMAGE) {
					std::cout << "[Warning - Pokemons::loadPokemon] Same element \"ghost\" on immunity and element tags. " << file << std::endl;
				}
			} else if ((attr = elementNode.attribute("dragonPercent"))) {
				pType->info.elementMap[COMBAT_DRAGONDAMAGE] = pugi::cast<int32_t>(attr.value());
				if (pType->info.damageImmunities & COMBAT_DRAGONDAMAGE) {
					std::cout << "[Warning - Pokemons::loadPokemon] Same element \"dragon\" on immunity and element tags. " << file << std::endl;
				}
			} else if ((attr = elementNode.attribute("groundPercent"))) {
				pType->info.elementMap[COMBAT_GROUNDDAMAGE] = pugi::cast<int32_t>(attr.value());
				if (pType->info.damageImmunities & COMBAT_GROUNDDAMAGE) {
					std::cout << "[Warning - Pokemons::loadPokemon] Same element \"ground\" on immunity and element tags. " << file << std::endl;
				}
			} else if ((attr = elementNode.attribute("bugPercent"))) {
				pType->info.elementMap[COMBAT_BUGDAMAGE] = pugi::cast<int32_t>(attr.value());
				if (pType->info.damageImmunities & COMBAT_BUGDAMAGE) {
					std::cout << "[Warning - Pokemons::loadPokemon] Same element \"bug\" on immunity and element tags. " << file << std::endl;
				}
			} else if ((attr = elementNode.attribute("poisonPercent"))) {
				pType->info.elementMap[COMBAT_POISONDAMAGE] = pugi::cast<int32_t>(attr.value());
				if (pType->info.damageImmunities & COMBAT_POISONDAMAGE) {
					std::cout << "[Warning - Pokemons::loadPokemon] Same element \"poison\" on immunity and element tags. " << file << std::endl;
				}
			} else {
				std::cout << "[Warning - Pokemons::loadPokemon] Unknown element percent. " << file << std::endl;
			}
		}
	}

	if ((node = pokemonNode.child("summons"))) {
		if ((attr = node.attribute("maxSummons"))) {
			pType->info.maxSummons = std::min<uint32_t>(pugi::cast<uint32_t>(attr.value()), 100);
		} else {
			std::cout << "[Warning - Pokemons::loadPokemon] Missing summons maxSummons. " << file << std::endl;
		}

		for (auto& summonNode : node.children()) {
			int32_t chance = 100;
			int32_t speed = 1000;
			int32_t max = pType->info.maxSummons;
			bool force = false;

			if ((attr = summonNode.attribute("speed")) || (attr = summonNode.attribute("interval"))) {
				speed = std::max<int32_t>(1, pugi::cast<int32_t>(attr.value()));
			}

			if ((attr = summonNode.attribute("chance"))) {
				chance = pugi::cast<int32_t>(attr.value());
				if (chance > 100) {
					chance = 100;
					std::cout << "[Warning - Pokemons::loadPokemon] Summon chance value out of bounds. " << file << std::endl;
				}
			}

			if ((attr = summonNode.attribute("max"))) {
				max = pugi::cast<uint32_t>(attr.value());
			}

			if ((attr = summonNode.attribute("force"))) {
				force = attr.as_bool();
			}

			if ((attr = summonNode.attribute("name"))) {
				summonBlock_t sb;
				sb.name = attr.as_string();
				sb.speed = speed;
				sb.chance = chance;
				sb.max = max;
				sb.force = force;
				pType->info.summons.emplace_back(sb);
			} else {
				std::cout << "[Warning - Pokemons::loadPokemon] Missing summon name. " << file << std::endl;
			}
		}
	}

	if ((node = pokemonNode.child("script"))) {
		for (auto& eventNode : node.children()) {
			if ((attr = eventNode.attribute("name"))) {
				pType->info.scripts.emplace_back(attr.as_string());
			} else {
				std::cout << "[Warning - Pokemons::loadPokemon] Missing name for script event. " << file << std::endl;
			}
		}
	}

	pType->info.summons.shrink_to_fit();
	pType->info.lootItems.shrink_to_fit();
	pType->info.attackSpells.shrink_to_fit();
	pType->info.defenseSpells.shrink_to_fit();
	pType->info.voiceVector.shrink_to_fit();
	pType->info.scripts.shrink_to_fit();
	return pType;
}

bool PokemonType::loadCallback(LuaScriptInterface* scriptInterface)
{
	int32_t id = scriptInterface->getEvent();
	if (id == -1) {
		std::cout << "[Warning - PokemonType::loadCallback] Event not found. " << std::endl;
		return false;
	}

	info.scriptInterface = scriptInterface;
	if (info.eventType == POKEMONS_EVENT_THINK) {
		info.thinkEvent = id;
	} else if (info.eventType == POKEMONS_EVENT_APPEAR) {
		info.creatureAppearEvent = id;
	} else if (info.eventType == POKEMONS_EVENT_DISAPPEAR) {
		info.creatureDisappearEvent = id;
	} else if (info.eventType == POKEMONS_EVENT_MOVE) {
		info.creatureMoveEvent = id;
	} else if (info.eventType == POKEMONS_EVENT_SAY) {
		info.creatureSayEvent = id;
	}
	return true;
}

bool PokemonType::hasMoveId(uint16_t moveId)
{
	if (moves.find(moveId) != moves.end()) {
		return true;
	}
	return false;
}

bool PokemonType::addMove(moveBlock_t& move)
{
	for (auto& [id, otherMove] : moves) {
		if (move.name == otherMove.name) {
			std::cerr << "[Warning PokemonType::addMove] Failed to add duplicated move id on pokemon: " << name << std::endl;
			return false;
		}
	}
	moves.insert(std::make_pair(move.id, move));
	return true;
}

bool PokemonType::addLearnableAbility(const std::string& ability)
{
	for (auto& otherAbility : learnablesHM) {
		if (ability == otherAbility) {
			return false;
		}
	}
	learnablesHM.push_back(ability);
	return true;
}

bool PokemonType::addLearnableMove(const std::string& moveName)
{
	for (auto& otherMoveName : learnablesTM) {
		if (moveName == otherMoveName) {
			return false;
		}
	}
	learnablesTM.push_back(moveName);
	return true;
}

bool PokemonType::canLearnAbility(const std::string& ability)
{
	for (auto& otherAbility : learnablesHM) {
		if (asLowerCaseString(ability) == asLowerCaseString(otherAbility)) {
			return true;
		}
	}
	return false;
}

bool PokemonType::canLearnMove(const std::string& moveName)
{
	for (auto& otherMoveName : learnablesTM) {
		if (asLowerCaseString(moveName) == asLowerCaseString(otherMoveName)) {
			return true;
		}
	}
	return false;
}

PokemonGender_t PokemonType::getRandomGender()
{
	double randomNumber = static_cast<double>(normal_random(0, 100));

	if (info.genderMalePercent == 0 && info.genderFemalePercent == 0) {
		return POKEMON_GENDER_UNDEFINED;
	}
	else if (info.genderMalePercent == info.genderFemalePercent) {
		if (uniform_random(0, 1) == 0) {
			return POKEMON_GENDER_MALE;
		}
		else {
			return POKEMON_GENDER_FEMALE;
		}
	}
	else if (randomNumber <= info.genderMalePercent) {
		return POKEMON_GENDER_MALE;
	}
	else {
		return POKEMON_GENDER_FEMALE;
	}
	return POKEMON_GENDER_UNDEFINED;
}

bool Pokemons::loadLootItem(const pugi::xml_node& node, LootBlock& lootBlock)
{
	pugi::xml_attribute attr;
	if ((attr = node.attribute("id"))) {
		int32_t id = pugi::cast<int32_t>(attr.value());
		const ItemType& it = Item::items.getItemType(id);

		if (it.name.empty()) {
			std::cout << "[Warning - Pokemons::loadPokemon] Unknown loot item id \"" << id << "\". " << std::endl;
			return false;
		}

		lootBlock.id = id;

	} else if ((attr = node.attribute("name"))) {
		auto name = attr.as_string();
		auto ids = Item::items.nameToItems.equal_range(asLowerCaseString(name));

		if (ids.first == Item::items.nameToItems.cend()) {
			std::cout << "[Warning - Pokemons::loadPokemon] Unknown loot item \"" << name << "\". " << std::endl;
			return false;
		}

		uint32_t id = ids.first->second;

		if (std::next(ids.first) != ids.second) {
			std::cout << "[Warning - Pokemons::loadPokemon] Non-unique loot item \"" << name << "\". " << std::endl;
			return false;
		}

		lootBlock.id = id;
	}

	if (lootBlock.id == 0) {
		return false;
	}

	if ((attr = node.attribute("countmax"))) {
		int32_t lootCountMax = pugi::cast<int32_t>(attr.value());
		lootBlock.countmax = std::max<int32_t>(1, lootCountMax);
	} else {
		lootBlock.countmax = 1;
	}

	if ((attr = node.attribute("chance")) || (attr = node.attribute("chance1"))) {
		int32_t lootChance = pugi::cast<int32_t>(attr.value());
		if (lootChance > static_cast<int32_t>(MAX_LOOTCHANCE)) {
			std::cout << "[Warning - Pokemons::loadPokemon] Invalid \"chance\" "<< lootChance <<" used for loot, the max is " << MAX_LOOTCHANCE << ". " << std::endl;
		}
		lootBlock.chance = std::min<int32_t>(MAX_LOOTCHANCE, lootChance);
	} else {
		lootBlock.chance = MAX_LOOTCHANCE;
	}

	if (Item::items[lootBlock.id].isContainer()) {
		loadLootContainer(node, lootBlock);
	}

	//optional
	if ((attr = node.attribute("subtype"))) {
		lootBlock.subType = pugi::cast<int32_t>(attr.value());
	} else {
		uint32_t charges = Item::items[lootBlock.id].charges;
		if (charges != 0) {
			lootBlock.subType = charges;
		}
	}

	if ((attr = node.attribute("actionId"))) {
		lootBlock.actionId = pugi::cast<int32_t>(attr.value());
	}

	if ((attr = node.attribute("text"))) {
		lootBlock.text = attr.as_string();
	}
	return true;
}

void Pokemons::loadLootContainer(const pugi::xml_node& node, LootBlock& lBlock)
{
	// NOTE: <inside> attribute was left for backwards compatibility with pre 1.x TFS versions.
	// Please don't use it, if you don't have to.
	for (auto& subNode : node.child("inside") ? node.child("inside").children() : node.children()) {
		LootBlock lootBlock;
		if (loadLootItem(subNode, lootBlock)) {
			lBlock.childLoot.emplace_back(std::move(lootBlock));
		}
	}
}

PokemonType* Pokemons::getPokemonType(const std::string& name, bool loadFromFile /*= true */)
{
	std::string lowerCaseName = asLowerCaseString(name);

	auto it = pokemons.find(lowerCaseName);
	if (it == pokemons.end()) {
		if (!loadFromFile) {
			return nullptr;
		}

		auto it2 = unloadedPokemons.find(lowerCaseName);
		if (it2 == unloadedPokemons.end()) {
			return nullptr;
		}

		return loadPokemon(it2->second, name);
	}
	return &it->second;
}
