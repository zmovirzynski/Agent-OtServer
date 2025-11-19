// Copyright 2022 The Forgotten Server Authors. All rights reserved.
// Use of this source code is governed by the GPL-2.0 License that can be found in the LICENSE file.

#ifndef FS_PROFESSION_H_ADCAA356C0DB44CEBA994A0D678EC92D
#define FS_PROFESSION_H_ADCAA356C0DB44CEBA994A0D678EC92D

#include "enums.h"
#include "item.h"

class Profession
{
	public:
		explicit Profession(uint16_t id) : id(id) {}

		const std::string& getVocName() const {
			return name;
		}
		const std::string& getVocDescription() const {
			return description;
		}
		uint64_t getReqSkillTries(uint8_t skill, uint16_t level);

		uint16_t getId() const {
			return id;
		}

		uint8_t getClientId() const {
			return clientId;
		}

		uint32_t getHPGain() const {
			return gainHP;
		}
		uint32_t getCapGain() const {
			return gainCap;
		}

		uint32_t getHealthGainTicks() const {
			return gainHealthTicks;
		}
		uint32_t getHealthGainAmount() const {
			return gainHealthAmount;
		}

		uint32_t getAttackSpeed() const {
			return attackSpeed;
		}
		uint32_t getBaseSpeed() const {
			return baseSpeed;
		}

		uint32_t getFromProfession() const {
			return fromProfession;
		}

		uint32_t getNoPongKickTime() const {
			return noPongKickTime;
		}

		bool allowsPvp() const {
			return allowPvp;
		}

		float meleeDamageMultiplier = 1.0f;
		float distDamageMultiplier = 1.0f;
		float defenseMultiplier = 1.0f;
		float armorMultiplier = 1.0f;

	private:
		friend class Professions;

		std::string name = "none";
		std::string description;

		double skillMultipliers[SKILL_LAST + 1] = {1.0};

		uint32_t gainHealthTicks = 6;
		uint32_t gainHealthAmount = 1;
		uint32_t gainCap = 500;
		uint32_t gainHP = 5;
		uint32_t fromProfession = PROFESSION_NONE;
		uint32_t attackSpeed = 1500;
		uint32_t baseSpeed = 220;
		uint32_t noPongKickTime = 60000;

		uint16_t id;

		uint8_t clientId = 0;

		bool allowPvp = true;
};

class Professions
{
	public:
		bool loadFromXml();

		Profession* getProfession(uint16_t id);
		int32_t getProfessionId(const std::string& name) const;
		uint16_t getPromotedProfession(uint16_t professionId) const;

	private:
		std::map<uint16_t, Profession> professionsMap;
};

#endif
