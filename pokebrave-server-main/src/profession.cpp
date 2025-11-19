// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#include "otpch.h"

#include "profession.h"

#include "player.h"
#include "pugicast.h"
#include "tools.h"

bool Professions::loadFromXml()
{
	pugi::xml_document doc;
	pugi::xml_parse_result result = doc.load_file("data/XML/professions.xml");
	if (!result) {
		printXMLError("Error - Professions::loadFromXml", "data/XML/professions.xml", result);
		return false;
	}

	for (auto professionNode : doc.child("professions").children()) {
		pugi::xml_attribute attr = professionNode.attribute("id");
		if (!attr) {
			std::cout << "[Warning - Professions::loadFromXml] Missing profession id" << std::endl;
			continue;
		}

		uint16_t id = pugi::cast<uint16_t>(attr.value());
		auto res = professionsMap.emplace(std::piecewise_construct,
				std::forward_as_tuple(id), std::forward_as_tuple(id));
		Profession& voc = res.first->second;

		professionNode.remove_attribute("id");
		for (auto attrNode : professionNode.attributes()) {
			const char* attrName = attrNode.name();
			if (strcasecmp(attrName, "name") == 0) {
				voc.name = attrNode.as_string();
			} else if (strcasecmp(attrName, "allowpvp") == 0) {
				voc.allowPvp = attrNode.as_bool();
			} else if (strcasecmp(attrName, "clientid") == 0) {
				voc.clientId = pugi::cast<uint16_t>(attrNode.value());
			} else if (strcasecmp(attrName, "description") == 0) {
				voc.description = attrNode.as_string();
			} else if (strcasecmp(attrName, "gaincap") == 0) {
				voc.gainCap = pugi::cast<uint32_t>(attrNode.value()) * 100;
			} else if (strcasecmp(attrName, "gainhp") == 0) {
				voc.gainHP = pugi::cast<uint32_t>(attrNode.value());
			} else if (strcasecmp(attrName, "gainhpticks") == 0) {
				voc.gainHealthTicks = pugi::cast<uint32_t>(attrNode.value());
			} else if (strcasecmp(attrName, "gainhpamount") == 0) {
				voc.gainHealthAmount = pugi::cast<uint32_t>(attrNode.value());
			} else if (strcasecmp(attrName, "attackspeed") == 0) {
				voc.attackSpeed = pugi::cast<uint32_t>(attrNode.value());
			} else if (strcasecmp(attrName, "basespeed") == 0) {
				voc.baseSpeed = pugi::cast<uint32_t>(attrNode.value());
			} else if (strcasecmp(attrName, "fromvoc") == 0) {
				voc.fromProfession = pugi::cast<uint32_t>(attrNode.value());
			} else if (strcasecmp(attrName, "nopongkicktime") == 0) {
				voc.noPongKickTime = pugi::cast<uint32_t>(attrNode.value()) * 1000;
			} else {
				std::cout << "[Notice - Professions::loadFromXml] Unknown attribute: \"" << attrName << "\" for profession: " << voc.id << std::endl;
			}
		}

		for (auto childNode : professionNode.children()) {
			if (strcasecmp(childNode.name(), "skill") == 0) {
				if ((attr = childNode.attribute("id"))) {
					uint16_t skillId = pugi::cast<uint16_t>(attr.value());
					if (skillId <= SKILL_LAST) {
						voc.skillMultipliers[skillId] = pugi::cast<double>(childNode.attribute("multiplier").value());
					} else {
						std::cout << "[Notice - Professions::loadFromXml] No valid skill id: " << skillId << " for profession: " << voc.id << std::endl;
					}
				} else {
					std::cout << "[Notice - Professions::loadFromXml] Missing skill id for profession: " << voc.id << std::endl;
				}
			} else if (strcasecmp(childNode.name(), "formula") == 0) {
				if ((attr = childNode.attribute("meleeDamage"))) {
					voc.meleeDamageMultiplier = pugi::cast<float>(attr.value());
				}

				if ((attr = childNode.attribute("distDamage"))) {
					voc.distDamageMultiplier = pugi::cast<float>(attr.value());
				}

				if ((attr = childNode.attribute("defense"))) {
					voc.defenseMultiplier = pugi::cast<float>(attr.value());
				}

				if ((attr = childNode.attribute("armor"))) {
					voc.armorMultiplier = pugi::cast<float>(attr.value());
				}
			}
		}
	}
	return true;
}

Profession* Professions::getProfession(uint16_t id)
{
	auto it = professionsMap.find(id);
	if (it == professionsMap.end()) {
		std::cout << "[Warning - Professions::getProfession] Profession " << id << " not found." << std::endl;
		return nullptr;
	}
	return &it->second;
}

int32_t Professions::getProfessionId(const std::string& name) const
{
	auto it = std::find_if(professionsMap.begin(), professionsMap.end(), [&name](auto it) {
		return name.size() == it.second.name.size() && std::equal(name.begin(), name.end(), it.second.name.begin(), [](char a, char b) {
			return std::tolower(a) == std::tolower(b);
		});
	});
	return it != professionsMap.end() ? it->first : -1;
}

uint16_t Professions::getPromotedProfession(uint16_t id) const
{
	auto it = std::find_if(professionsMap.begin(), professionsMap.end(), [id](auto it) {
		return it.second.fromProfession == id && it.first != id;
	});
	return it != professionsMap.end() ? it->first : PROFESSION_NONE;
}

static const uint32_t skillBase[SKILL_LAST + 1] = {50};

uint64_t Profession::getReqSkillTries(uint8_t skill, uint16_t level)
{
	if (skill > SKILL_LAST) {
		return 0;
	}
	return skillBase[skill] * std::pow(skillMultipliers[skill], static_cast<int32_t>(level - (MINIMUM_SKILL_LEVEL + 1)));
}
