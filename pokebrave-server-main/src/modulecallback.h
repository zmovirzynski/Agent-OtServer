#ifndef FS_MODULECALLBACK_H
#define FS_MODULECALLBACK_H

#include "luascript.h"
#include "script.h"
#include "const.h"
#include "creature.h"

class Thing;

class ModuleCallback
{
public:
	ModuleCallback(Scripts* scripts);

	bool initialize();
	bool connectCallbacks();

	int32_t getScriptIdFromCallback(const std::string& callback);
	bool hasActiveCallback(const std::string& callback);

	bool executeOnLogin(Player* player);
	bool executeOnLogout(Player* player);
	void executeOnAppear(Player* player, const Creature* target);
	void executeOnDisappear(Player* player, const Creature* target);
	void executeOnSay(const Creature* creature, const SpeakClasses type, const std::string& text);
	void executeOnThink(Creature* creature, uint32_t interval);
	bool executeOnPrepareDeath(Creature* creature, Creature* killer);
	void executeOnDeath(Creature* creature, Item* corpse, Creature* killer, Creature* mostDamageKiller, bool lastHitUnjustified, bool mostDamageUnjustified);
	void executeOnKill(Creature* creature, Creature* target);
	void executeOnAdvance(Player* player, skills_t, uint32_t, uint32_t);
	void executeOnModalWindow(Player* player, uint32_t modalWindowId, uint8_t buttonId, uint8_t choiceId);
	bool executeOnTextEdit(Player* player, Item* item, const std::string& text);
	void executeOnHealthChange(Creature* creature, Creature* attacker, CombatDamage& damage);
	void executeOnExtendedOpcode(Player* player, uint8_t opcode, const std::string& buffer);
	void executeOnLook(Player* player, const Position& position, Thing* thing, uint8_t stackpos, int32_t lookDistance);
	bool executeUseItem(Player* player, Item* item, const Position& fromPosition,
			Thing* target, const Position& toPosition);
	void executeOnPokemonLevelUp(Pokemon* pokemon, uint32_t oldLevel, uint32_t newLevel, uint64_t experience);
	void executeOnPokemonFinishedOrder(Pokemon* pokemon, const Position& position);

private:
	std::map<std::string, int32_t> scriptIds;
	Scripts* scripts;

	bool initialized = false;

	std::vector<std::string> events
	{
		"onLogin", "onLogout", "onAppear", "onDisappear",
		"onSay", "onUseItem", "onThink", "onPrepareDeath",
		"onHealthChange", "onExtendedOpcode", "onDeath",
		"onKill", "onAdvance", "onModalWindow", "onTextEdit",
		"onLook", "onPokemonLevelUp", "onPokemonFinishedOrder",
	};
};

#endif // !FS_MODULECALLBACK_H
