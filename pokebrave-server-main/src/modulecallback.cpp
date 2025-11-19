#include "otpch.h"
#include "modulecallback.h"
#include "thing.h"

#include <filesystem>

ModuleCallback::ModuleCallback(Scripts* scripts)
{
	this->scripts = scripts;
}

bool ModuleCallback::initialize()
{
	if (initialized) {
		return false;
	}

	std::string scriptFile = (std::filesystem::current_path() / "data" / "modules" / "callbacks.lua").string();
	if (!std::filesystem::exists(scriptFile)) {
		std::cout << "[Warning - ModuleCallback::initialize] file '" << scriptFile << "' not foud." << std::endl;
		return false;
	}

	if (scripts->scriptInterface.loadFile(scriptFile)) {
		std::cout << "> " << scriptFile << " [error]" << std::endl;
		std::cout << "^ " << scripts->scriptInterface.getLastLuaError() << std::endl;
		return false;
	}
	
	initialized = true;
	return true;
}

bool ModuleCallback::connectCallbacks()
{
	LuaScriptInterface* scriptInterface = &scripts->scriptInterface;
	lua_State* L = scriptInterface->getLuaState();

	for (auto& event : events) {
		lua_getglobal(L, event.c_str());

		if (!LuaScriptInterface::isFunction(L, -1)) {
			std::cerr << "[Error - ModuleCallback::connectCallbacks] Not found function with name: " << event << std::endl;
			continue;
		}

		int32_t callback = luaL_ref(L, LUA_REGISTRYINDEX);;
		scriptIds.insert(std::make_pair(event, callback));
	}
	return true;
}

int32_t ModuleCallback::getScriptIdFromCallback(const std::string& callback)
{
	if (scriptIds.find(callback) != scriptIds.end()) {
		return scriptIds[callback];
	}
	return -1;
}

bool ModuleCallback::hasActiveCallback(const std::string& callback)
{
	if (std::find(events.begin(), events.end(), callback) != events.end()) {
		return true;
	}
	return false;
}

bool ModuleCallback::executeOnLogin(Player* player)
{
	//onLogin(player)
	bool defaultRet = true;

	if (!hasActiveCallback("onLogin")) {
		return defaultRet;
	}

	int32_t callback = getScriptIdFromCallback("onLogin");
	if (callback < 0) {
		std::cerr << "[Error - ModuleCallback::executeOnLogin] Not found callback with id: " << callback << std::endl;
		return defaultRet;
	}

	LuaScriptInterface* scriptInterface = &scripts->scriptInterface;
	lua_State* L = scriptInterface->getLuaState();

	lua_rawgeti(L, LUA_REGISTRYINDEX, callback);

	if (!LuaScriptInterface::isFunction(L, -1)) {
		std::cerr << "[Error - ModuleCallback::executeOnLogin] The onLogin callback is not a function." << std::endl;
		lua_pop(L, 1);
		return defaultRet;
	}

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	int nresults = 1;
	if (scriptInterface->protectedCall(L, 1, nresults) != 0) {
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
		return defaultRet;
	}

	bool canLogin = LuaScriptInterface::getBoolean(L, 1);
	lua_pop(L, nresults);
	return canLogin;
}

bool ModuleCallback::executeOnLogout(Player* player)
{
	//onLogout(player)
	bool defaultRet = true;

	if (!hasActiveCallback("onLogout")) {
		return defaultRet;
	}

	int32_t callback = getScriptIdFromCallback("onLogout");
	if (callback < 0) {
		std::cerr << "[Error - ModuleCallback::executeOnLogout] Not found callback with id: " << callback << std::endl;
		return defaultRet;
	}

	LuaScriptInterface* scriptInterface = &scripts->scriptInterface;
	lua_State* L = scriptInterface->getLuaState();

	lua_rawgeti(L, LUA_REGISTRYINDEX, callback);

	if (!LuaScriptInterface::isFunction(L, -1)) {
		std::cerr << "[Error - ModuleCallback::executeOnLogout] The onLogout callback is not a function." << std::endl;
		lua_pop(L, 1);
		return defaultRet;
	}

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	int nresults = 1;
	if (scriptInterface->protectedCall(L, 1, nresults) != 0) {
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
		return defaultRet;
	}

	bool canLogout = LuaScriptInterface::getBoolean(L, 1);
	lua_pop(L, nresults);

	return canLogout;
}

void ModuleCallback::executeOnAppear(Player* player, const Creature* target)
{
	//onAppear(player, target)
	if (!hasActiveCallback("onAppear")) {
		return;
	}

	int32_t callback = getScriptIdFromCallback("onAppear");
	if (callback < 0) {
		std::cerr << "[Error - ModuleCallback::executeOnAppear] Not found callback with id: " << callback << std::endl;
		return;
	}

	LuaScriptInterface* scriptInterface = &scripts->scriptInterface;
	lua_State* L = scriptInterface->getLuaState();

	lua_rawgeti(L, LUA_REGISTRYINDEX, callback);

	if (!LuaScriptInterface::isFunction(L, -1)) {
		std::cerr << "[Error - ModuleCallback::executeOnAppear] The onAppear callback is not a function." << std::endl;
		lua_pop(L, 1);
		return;
	}

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	LuaScriptInterface::pushUserdata<const Creature>(L, target);
	LuaScriptInterface::setMetatable(L, -1, "Creature");

	if (scriptInterface->protectedCall(L, 2, 0) != 0) {
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
		return;
	}
}

void ModuleCallback::executeOnDisappear(Player* player, const Creature* target)
{
	//onDisappear(player, target)
	if (!hasActiveCallback("onDisappear")) {
		return;
	}

	int32_t callback = getScriptIdFromCallback("onDisappear");
	if (callback < 0) {
		std::cerr << "[Error - ModuleCallback::executeOnDisappear] Not found callback with id: " << callback << std::endl;
		return;
	}

	LuaScriptInterface* scriptInterface = &scripts->scriptInterface;
	lua_State* L = scriptInterface->getLuaState();

	lua_rawgeti(L, LUA_REGISTRYINDEX, callback);

	if (!LuaScriptInterface::isFunction(L, -1)) {
		std::cerr << "[Error - ModuleCallback::executeOnDisappear] The onDisappear callback is not a function." << std::endl;
		lua_pop(L, 1);
		return;
	}

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	LuaScriptInterface::pushUserdata<const Creature>(L, target);
	LuaScriptInterface::setMetatable(L, -1, "Creature");

	if (scriptInterface->protectedCall(L, 2, 0) != 0) {
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
		return;
	}
}

void ModuleCallback::executeOnSay(const Creature* creature, const SpeakClasses type, const std::string& text)
{
	//onSay(creature, speakType, text)
	if (!hasActiveCallback("onSay")) {
		return;
	}

	int32_t callback = getScriptIdFromCallback("onSay");
	if (callback < 0) {
		std::cerr << "[Error - ModuleCallback::executeOnSay] Not found callback with id: " << callback << std::endl;
		return;
	}

	LuaScriptInterface* scriptInterface = &scripts->scriptInterface;
	lua_State* L = scriptInterface->getLuaState();

	lua_rawgeti(L, LUA_REGISTRYINDEX, callback);

	if (!LuaScriptInterface::isFunction(L, -1)) {
		std::cerr << "[Error - ModuleCallback::executeOnSay] The onSay callback is not a function." << std::endl;
		lua_pop(L, 1);
		return;
	}

	LuaScriptInterface::pushUserdata<const Creature>(L, creature);
	LuaScriptInterface::setMetatable(L, -1, "Creature");

	lua_pushnumber(L, (int)type);

	LuaScriptInterface::pushString(L, text);
	
	if (scriptInterface->protectedCall(L, 3, 0) != 0) {
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
		return;
	}
}

bool ModuleCallback::executeUseItem(Player* player, Item* item, const Position& fromPosition, Thing* target, const Position& toPosition)
{
	//onUseItem(player, item, fromPosition, target, toPosition)
	bool defaultRet = true;

	if (!hasActiveCallback("onUseItem")) {
		return defaultRet;
	}

	int32_t callback = getScriptIdFromCallback("onUseItem");
	if (callback < 0) {
		std::cerr << "[Error - ModuleCallback::executeOnUseItem] Not found callback with id: " << callback << std::endl;
		return defaultRet;
	}

	LuaScriptInterface* scriptInterface = &scripts->scriptInterface;
	lua_State* L = scriptInterface->getLuaState();

	lua_rawgeti(L, LUA_REGISTRYINDEX, callback);

	if (!LuaScriptInterface::isFunction(L, -1)) {
		std::cerr << "[Error - ModuleCallback::executeOnUseItem] The onUseItem callback is not a function." << std::endl;
		lua_pop(L, 1);
		return defaultRet;
	}

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	LuaScriptInterface::pushUserdata<Item>(L, item);
	LuaScriptInterface::setMetatable(L, -1, "Item");

	LuaScriptInterface::pushPosition(L, fromPosition);

	LuaScriptInterface::pushThing(L, target);
	LuaScriptInterface::pushPosition(L, toPosition);

	int nresults = 1;
	if (scriptInterface->protectedCall(L, 5, nresults) != 0) {
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
		return defaultRet;
	}

	bool canUseItem = LuaScriptInterface::getBoolean(L, 1);
	lua_pop(L, nresults);
	return canUseItem;
}

void ModuleCallback::executeOnThink(Creature* creature, uint32_t interval)
{
	//onThink(creature, interval)
	if (!hasActiveCallback("onThink")) {
		return;
	}

	int32_t callback = getScriptIdFromCallback("onThink");
	if (callback < 0) {
		std::cerr << "[Error - ModuleCallback::executeOnThink] Not found callback with id: " << callback << std::endl;
		return;
	}

	LuaScriptInterface* scriptInterface = &scripts->scriptInterface;
	lua_State* L = scriptInterface->getLuaState();

	lua_rawgeti(L, LUA_REGISTRYINDEX, callback);

	if (!LuaScriptInterface::isFunction(L, -1)) {
		std::cerr << "[Error - ModuleCallback::executeOnThink] The onThink callback is not a function." << std::endl;
		lua_pop(L, 1);
		return;
	}

	LuaScriptInterface::pushUserdata<Creature>(L, creature);
	LuaScriptInterface::setCreatureMetatable(L, -1, creature);
	lua_pushnumber(L, interval);
	
	if (scriptInterface->protectedCall(L, 2, 0) != 0) {
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
		return;
	}
}

bool ModuleCallback::executeOnPrepareDeath(Creature* creature, Creature* killer)
{
	//onPrepareDeath(creature, killer)
	bool defaultRet = true;

	if (!hasActiveCallback("onPrepareDeath")) {
		return defaultRet;
	}

	int32_t callback = getScriptIdFromCallback("onPrepareDeath");
	if (callback < 0) {
		std::cerr << "[Error - ModuleCallback::executeOnPrepareDeath] Not found callback with id: " << callback << std::endl;
		return defaultRet;
	}

	LuaScriptInterface* scriptInterface = &scripts->scriptInterface;
	lua_State* L = scriptInterface->getLuaState();

	lua_rawgeti(L, LUA_REGISTRYINDEX, callback);

	if (!LuaScriptInterface::isFunction(L, -1)) {
		std::cerr << "[Error - ModuleCallback::executeOnPrepareDeath] The onPrepareDeath callback is not a function." << std::endl;
		lua_pop(L, 1);
		return defaultRet;
	}

	LuaScriptInterface::pushUserdata<Creature>(L, creature);
	LuaScriptInterface::setCreatureMetatable(L, -1, creature);

	if (killer) {
		LuaScriptInterface::pushUserdata<Creature>(L, killer);
		LuaScriptInterface::setCreatureMetatable(L, -1, killer);
	} else {
		lua_pushnil(L);
	}

	int nresults = 1;
	if (scriptInterface->protectedCall(L, 2, nresults) != 0) {
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
		return defaultRet;
	}

	bool canPrepareDeath = LuaScriptInterface::getBoolean(L, 1);
	lua_pop(L, nresults);
	return canPrepareDeath;
}

void ModuleCallback::executeOnDeath(Creature* creature, Item* corpse, Creature* killer, Creature* mostDamageKiller, bool lastHitUnjustified, bool mostDamageUnjustified)
{
	//onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	if (!hasActiveCallback("onDeath")) {
		return;
	}

	int32_t callback = getScriptIdFromCallback("onDeath");
	if (callback < 0) {
		std::cerr << "[Error - ModuleCallback::executeOnDeath] Not found callback with id: " << callback << std::endl;
		return;
	}

	LuaScriptInterface* scriptInterface = &scripts->scriptInterface;
	lua_State* L = scriptInterface->getLuaState();

	lua_rawgeti(L, LUA_REGISTRYINDEX, callback);

	if (!LuaScriptInterface::isFunction(L, -1)) {
		std::cerr << "[Error - ModuleCallback::executeOnDeath] The onDeath callback is not a function." << std::endl;
		lua_pop(L, 1);
		return;
	}

	LuaScriptInterface::pushUserdata<Creature>(L, creature);
	LuaScriptInterface::setCreatureMetatable(L, -1, creature);

	LuaScriptInterface::pushUserdata<Item>(L, corpse);
	LuaScriptInterface::setMetatable(L, -1, "Item");

	if (killer) {
		LuaScriptInterface::pushUserdata<Creature>(L, killer);
		LuaScriptInterface::setCreatureMetatable(L, -1, killer);
	} else {
		lua_pushnil(L);
	}

	if (mostDamageKiller) {
		LuaScriptInterface::pushUserdata<Creature>(L, mostDamageKiller);
		LuaScriptInterface::setCreatureMetatable(L, -1, mostDamageKiller);
	} else {
		lua_pushnil(L);
	}

	LuaScriptInterface::pushBoolean(L, lastHitUnjustified);
	LuaScriptInterface::pushBoolean(L, mostDamageUnjustified);

	if (scriptInterface->protectedCall(L, 6, 0) != 0) {
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
		return;
	}
}

void ModuleCallback::executeOnKill(Creature* creature, Creature* target)
{
	//onKill(creature, target)
	if (!hasActiveCallback("onKill")) {
		return;
	}

	int32_t callback = getScriptIdFromCallback("onKill");
	if (callback < 0) {
		std::cerr << "[Error - ModuleCallback::executeOnKill] Not found callback with id: " << callback << std::endl;
		return;
	}

	LuaScriptInterface* scriptInterface = &scripts->scriptInterface;
	lua_State* L = scriptInterface->getLuaState();

	lua_rawgeti(L, LUA_REGISTRYINDEX, callback);

	if (!LuaScriptInterface::isFunction(L, -1)) {
		std::cerr << "[Error - ModuleCallback::executeOnKill] The onKill callback is not a function." << std::endl;
		lua_pop(L, 1);
		return;
	}

	LuaScriptInterface::pushUserdata<Creature>(L, creature);
	LuaScriptInterface::setCreatureMetatable(L, -1, creature);

	LuaScriptInterface::pushUserdata<Creature>(L, target);
	LuaScriptInterface::setCreatureMetatable(L, -1, target);

	if (scriptInterface->protectedCall(L, 2, 0) != 0) {
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
		return;
	}
}

void ModuleCallback::executeOnAdvance(Player* player, skills_t skill, uint32_t oldLevel,
                                       uint32_t newLevel)
{
	//onAdvance(player, skill, oldLevel, newLevel)
	if (!hasActiveCallback("onAdvance")) {
		return;
	}

	int32_t callback = getScriptIdFromCallback("onAdvance");
	if (callback < 0) {
		std::cerr << "[Error - ModuleCallback::executeOnAdvance] Not found callback with id: " << callback << std::endl;
		return;
	}

	LuaScriptInterface* scriptInterface = &scripts->scriptInterface;
	lua_State* L = scriptInterface->getLuaState();

	lua_rawgeti(L, LUA_REGISTRYINDEX, callback);

	if (!LuaScriptInterface::isFunction(L, -1)) {
		std::cerr << "[Error - ModuleCallback::executeOnAdvance] The onAdvance callback is not a function." << std::endl;
		lua_pop(L, 1);
		return;
	}

	LuaScriptInterface::pushUserdata(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	lua_pushnumber(L, static_cast<uint32_t>(skill));
	lua_pushnumber(L, oldLevel);
	lua_pushnumber(L, newLevel);

	if (scriptInterface->protectedCall(L, 4, 0) != 0) {
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
		return;
	}
}

void ModuleCallback::executeOnModalWindow(Player* player, uint32_t modalWindowId, uint8_t buttonId, uint8_t choiceId)
{
	//onModalWindow(player, modalWindowId, buttonId, choiceId)
	if (!hasActiveCallback("onModalWindow")) {
		return;
	}

	int32_t callback = getScriptIdFromCallback("onModalWindow");
	if (callback < 0) {
		std::cerr << "[Error - ModuleCallback::executeOnModalWindow] Not found callback with id: " << callback << std::endl;
		return;
	}

	LuaScriptInterface* scriptInterface = &scripts->scriptInterface;
	lua_State* L = scriptInterface->getLuaState();

	lua_rawgeti(L, LUA_REGISTRYINDEX, callback);

	if (!LuaScriptInterface::isFunction(L, -1)) {
		std::cerr << "[Error - ModuleCallback::executeOnModalWindow] The onModalWindow callback is not a function." << std::endl;
		lua_pop(L, 1);
		return;
	}

	LuaScriptInterface::pushUserdata(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	lua_pushnumber(L, modalWindowId);
	lua_pushnumber(L, buttonId);
	lua_pushnumber(L, choiceId);

	if (scriptInterface->protectedCall(L, 4, 0) != 0) {
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
		return;
	}
}

bool ModuleCallback::executeOnTextEdit(Player* player, Item* item, const std::string& text)
{
	//onTextEdit(player, item, text)
	bool defaultRet = true;

	if (!hasActiveCallback("onTextEdit")) {
		return defaultRet;
	}

	int32_t callback = getScriptIdFromCallback("onTextEdit");
	if (callback < 0) {
		std::cerr << "[Error - ModuleCallback::executeOnTextEdit] Not found callback with id: " << callback << std::endl;
		return defaultRet;
	}

	LuaScriptInterface* scriptInterface = &scripts->scriptInterface;
	lua_State* L = scriptInterface->getLuaState();

	lua_rawgeti(L, LUA_REGISTRYINDEX, callback);

	if (!LuaScriptInterface::isFunction(L, -1)) {
		std::cerr << "[Error - ModuleCallback::executeOnTextEdit] The onTextEdit callback is not a function." << std::endl;
		lua_pop(L, 1);
		return defaultRet;
	}

	LuaScriptInterface::pushUserdata(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	LuaScriptInterface::pushUserdata<Item>(L, item);
	LuaScriptInterface::setMetatable(L, -1, "Item");

	LuaScriptInterface::pushString(L, text);

	int nresults = 1;
	if (scriptInterface->protectedCall(L, 3, nresults) != 0) {
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
		return defaultRet;
	}

	bool canTextEdit = LuaScriptInterface::getBoolean(L, 1);
	lua_pop(L, nresults);
	return canTextEdit;
}

void ModuleCallback::executeOnHealthChange(Creature* creature, Creature* attacker, CombatDamage& damage)
{
	//onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if (!hasActiveCallback("onHealthChange")) {
		return;
	}

	int32_t callback = getScriptIdFromCallback("onHealthChange");
	if (callback < 0) {
		std::cerr << "[Error - ModuleCallback::executeOnHealthChange] Not found callback with id: " << callback << std::endl;
		return;
	}

	LuaScriptInterface* scriptInterface = &scripts->scriptInterface;
	lua_State* L = scriptInterface->getLuaState();
	
	lua_rawgeti(L, LUA_REGISTRYINDEX, callback);

	if (!LuaScriptInterface::isFunction(L, -1)) {
		std::cerr << "[Error - ModuleCallback::executeOnHealthChange] The onHealthChange callback is not a function." << std::endl;
		lua_pop(L, 1);
		return;
	}

	LuaScriptInterface::pushUserdata(L, creature);
	LuaScriptInterface::setCreatureMetatable(L, -1, creature);
	if (attacker) {
		LuaScriptInterface::pushUserdata(L, attacker);
		LuaScriptInterface::setCreatureMetatable(L, -1, attacker);
	} else {
		lua_pushnil(L);
	}

	LuaScriptInterface::pushCombatDamage(L, damage);
	
	int nresults = 4;
	if (scriptInterface->protectedCall(L, 7, nresults) != 0) {
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
		return;
	} 

	damage.primary.value = std::abs(LuaScriptInterface::getNumber<int32_t>(L, -4));
	damage.primary.type = LuaScriptInterface::getNumber<CombatType_t>(L, -3);
	damage.secondary.value = std::abs(LuaScriptInterface::getNumber<int32_t>(L, -2));
	damage.secondary.type = LuaScriptInterface::getNumber<CombatType_t>(L, -1);

	lua_pop(L, nresults);
	if (damage.primary.type != COMBAT_HEALING) {
		damage.primary.value = -damage.primary.value;
		damage.secondary.value = -damage.secondary.value;
	}
}

void ModuleCallback::executeOnExtendedOpcode(Player* player, uint8_t opcode, const std::string& buffer)
{
	//onExtendedOpcode(player, opcode, buffer)
	if (!hasActiveCallback("onExtendedOpcode")) {
		return;
	}

	int32_t callback = getScriptIdFromCallback("onExtendedOpcode");
	if (callback < 0) {
		std::cerr << "[Error - ModuleCallback::executeOnExtendedOpcode] Not found callback with id: " << callback << std::endl;
		return;
	}

	LuaScriptInterface* scriptInterface = &scripts->scriptInterface;
	lua_State* L = scriptInterface->getLuaState();

	lua_rawgeti(L, LUA_REGISTRYINDEX, callback);

	if (!LuaScriptInterface::isFunction(L, -1)) {
		std::cerr << "[Error - ModuleCallback::executeOnExtendedOpcode] The onExtendedOpcode callback is not a function." << std::endl;
		lua_pop(L, 1);
		return;
	}

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	lua_pushnumber(L, opcode);
	LuaScriptInterface::pushString(L, buffer);

	if (scriptInterface->protectedCall(L, 3, 0) != 0) {
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
		return;
	}
}

void ModuleCallback::executeOnLook(Player* player, const Position& position, Thing* thing, uint8_t stackpos, int32_t lookDistance)
{
	//onLook(player, thing, position, distance)
	if (!hasActiveCallback("onLook")) {
		return;
	}

	int32_t callback = getScriptIdFromCallback("onLook");
	if (callback < 0) {
		std::cerr << "[Error - ModuleCallback::executeOnLook] Not found callback with id: " << callback << std::endl;
		return;
	}

	LuaScriptInterface* scriptInterface = &scripts->scriptInterface;
	lua_State* L = scriptInterface->getLuaState();

	lua_rawgeti(L, LUA_REGISTRYINDEX, callback);

	if (!LuaScriptInterface::isFunction(L, -1)) {
		std::cerr << "[Error - ModuleCallback::executeOnLook] The onLook callback is not a function." << std::endl;
		lua_pop(L, 1);
		return;
	}

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	if (Creature* creature = thing->getCreature()) {
		LuaScriptInterface::pushUserdata<Creature>(L, creature);
		LuaScriptInterface::setCreatureMetatable(L, -1, creature);
	} else if (Item* item = thing->getItem()) {
		LuaScriptInterface::pushUserdata<Item>(L, item);
		LuaScriptInterface::setItemMetatable(L, -1, item);
	} else {
		lua_pushnil(L);
	}

	LuaScriptInterface::pushPosition(L, position, stackpos);
	lua_pushnumber(L, lookDistance);

	if (scriptInterface->protectedCall(L, 4, 0) != 0) {
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
		return;
	}
}

void ModuleCallback::executeOnPokemonLevelUp(Pokemon* pokemon, uint32_t oldLevel, uint32_t newLevel, uint64_t experience)
{
	//onPokemonLevelUp(pokemon, oldLevel, newLevel, experience)
	if (!hasActiveCallback("onPokemonLevelUp")) {
		return;
	}

	int32_t callback = getScriptIdFromCallback("onPokemonLevelUp");
	if (callback < 0) {
		std::cerr << "[Error - ModuleCallback::executeOnPokemonLevelUp] Not found callback with id: " << callback << std::endl;
		return;
	}

	LuaScriptInterface* scriptInterface = &scripts->scriptInterface;
	lua_State* L = scriptInterface->getLuaState();

	lua_rawgeti(L, LUA_REGISTRYINDEX, callback);

	if (!LuaScriptInterface::isFunction(L, -1)) {
		std::cerr << "[Error - ModuleCallback::executeOnPokemonLevelUp] The onPokemonLevelUp callback is not a function." << std::endl;
		lua_pop(L, 1);
		return;
	}

	LuaScriptInterface::pushUserdata<Pokemon>(L, pokemon);
	LuaScriptInterface::setMetatable(L, -1, "Pokemon");

	lua_pushnumber(L, oldLevel);
	lua_pushnumber(L, newLevel);
	lua_pushnumber(L, experience);

	if (scriptInterface->protectedCall(L, 4, 0) != 0) {
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
		return;
	}
}

void ModuleCallback::executeOnPokemonFinishedOrder(Pokemon* pokemon, const Position& position)
{
	//onPokemonFinishedOrder(pokemon, position)
	if (!hasActiveCallback("onPokemonFinishedOrder")) {
		return;
	}

	int32_t callback = getScriptIdFromCallback("onPokemonFinishedOrder");
	if (callback < 0) {
		std::cerr << "[Error - ModuleCallback::executeOnPokemonFinishOrder] Not found callback with id: " << callback << std::endl;
		return;
	}

	LuaScriptInterface* scriptInterface = &scripts->scriptInterface;
	lua_State* L = scriptInterface->getLuaState();

	lua_rawgeti(L, LUA_REGISTRYINDEX, callback);

	if (!LuaScriptInterface::isFunction(L, -1)) {
		std::cerr << "[Error - ModuleCallback::executeOnPokemonFinishOrder] The onPokemonFinishedOrder callback is not a function." << std::endl;
		lua_pop(L, 1);
		return;
	}

	LuaScriptInterface::pushUserdata<Pokemon>(L, pokemon);
	LuaScriptInterface::setMetatable(L, -1, "Pokemon");

	LuaScriptInterface::pushPosition(L, position);

	if (scriptInterface->protectedCall(L, 2, 0) != 0) {
		LuaScriptInterface::reportError(nullptr, LuaScriptInterface::popString(L));
		return;
	}
}
