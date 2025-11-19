local foodCondition = Condition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)

function Player.feed(self, food)
	local condition = self:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
	if condition then
		condition:setTicks(condition:getTicks() + (food * 1000))
	else
		local profession = self:getProfession()
		if not profession then
			return nil
		end

		foodCondition:setTicks(food * 1000)
		foodCondition:setParameter(CONDITION_PARAM_HEALTHGAIN, profession:getHealthGainAmount())
		foodCondition:setParameter(CONDITION_PARAM_HEALTHTICKS, profession:getHealthGainTicks() * 1000)

		self:addCondition(foodCondition)
	end
	return true
end

function Player.getClosestFreePosition(self, position, extended)
	if self:getGroup():getAccess() and self:getAccountType() >= ACCOUNT_TYPE_GOD then
		return position
	end
	return Creature.getClosestFreePosition(self, position, extended)
end

function Player.getDepotItems(self, depotId)
	return self:getDepotChest(depotId, true):getItemHoldingCount()
end

function Player.hasFlag(self, flag)
	return self:getGroup():hasFlag(flag)
end

function Player.getLossPercent(self)
	local blessings = 0
	local lossPercent = {
		[0] = 100,
		[1] = 70,
		[2] = 45,
		[3] = 25,
		[4] = 10,
		[5] = 0
	}

	for i = 1, 5 do
		if self:hasBlessing(i) then
			blessings = blessings + 1
		end
	end
	return lossPercent[blessings]
end

function Player.getPremiumTime(self)
	return math.max(0, self:getPremiumEndsAt() - os.time())
end

function Player.setPremiumTime(self, seconds)
	self:setPremiumEndsAt(os.time() + seconds)
	return true
end

function Player.addPremiumTime(self, seconds)
	self:setPremiumTime(self:getPremiumTime() + seconds)
	return true
end

function Player.removePremiumTime(self, seconds)
	local currentTime = self:getPremiumTime()
	if currentTime < seconds then
		return false
	end

	self:setPremiumTime(currentTime - seconds)
	return true
end

function Player.getPremiumDays(self)
	return math.floor(self:getPremiumTime() / 86400)
end

function Player.addPremiumDays(self, days)
	return self:addPremiumTime(days * 86400)
end

function Player.removePremiumDays(self, days)
	return self:removePremiumTime(days * 86400)
end

function Player.isPremium(self)
	return self:getPremiumTime() > 0 or configManager.getBoolean(configKeys.FREE_PREMIUM) or self:hasFlag(PlayerFlag_IsAlwaysPremium)
end

function Player.sendCancelMessage(self, message)
	if type(message) == "number" then
		message = Game.getReturnMessage(message)
	end
	return self:sendTextMessage(MESSAGE_STATUS_SMALL, message)
end

function Player.isUsingOtClient(self)
	return self:getClient().os >= CLIENTOS_OTCLIENT_LINUX
end

function Player.sendExtendedOpcode(self, opcode, buffer)
	if not self:isUsingOtClient() then
		return false
	end

	local networkMessage = NetworkMessage()
	networkMessage:addByte(0x32)
	networkMessage:addByte(opcode)
	networkMessage:addString(buffer)
	networkMessage:sendToPlayer(self)
	networkMessage:delete()
	return true
end

APPLY_SKILL_MULTIPLIER = true
local addSkillTriesFunc = Player.addSkillTries
function Player.addSkillTries(...)
	APPLY_SKILL_MULTIPLIER = false
	local ret = addSkillTriesFunc(...)
	APPLY_SKILL_MULTIPLIER = true
	return ret
end

-- Always pass the number through the isValidMoney function first before using the transferMoneyTo
function Player.transferMoneyTo(self, target, amount)
	if not target then
		return false
	end

	-- See if you can afford this transfer
	local balance = self:getBankBalance()
	if amount > balance then
		return false
	end

	-- See if player is online
	local targetPlayer = Player(target.guid)
	if targetPlayer then
		targetPlayer:setBankBalance(targetPlayer:getBankBalance() + amount)
	else
		db.query("UPDATE `players` SET `balance` = `balance` + " .. amount .. " WHERE `id` = '" .. target.guid .. "'")
	end

	self:setBankBalance(self:getBankBalance() - amount)
	return true
end

function Player.canCarryMoney(self, amount)
	-- Anyone can carry as much imaginary money as they desire
	if amount == 0 then
		return true
	end

	-- The 3 below loops will populate these local variables
	local totalWeight = 0
	local inventorySlots = 0

	-- Add crystal coins to totalWeight and inventorySlots
	local type_crystal = ItemType(ITEM_CRYSTAL_COIN)
	local crystalCoins = math.floor(amount / 10000)
	if crystalCoins > 0 then
		amount = amount - (crystalCoins * 10000)
		while crystalCoins > 0 do
			local count = math.min(100, crystalCoins)
			totalWeight = totalWeight + type_crystal:getWeight(count)
			crystalCoins = crystalCoins - count
			inventorySlots = inventorySlots + 1
		end
	end

	-- Add platinum coins to totalWeight and inventorySlots
	local type_platinum = ItemType(ITEM_PLATINUM_COIN)
	local platinumCoins = math.floor(amount / 100)
	if platinumCoins > 0 then
		amount = amount - (platinumCoins * 100)
		while platinumCoins > 0 do
			local count = math.min(100, platinumCoins)
			totalWeight = totalWeight + type_platinum:getWeight(count)
			platinumCoins = platinumCoins - count
			inventorySlots = inventorySlots + 1
		end
	end

	-- Add gold coins to totalWeight and inventorySlots
	local type_gold = ItemType(ITEM_GOLD_COIN)
	if amount > 0 then
		while amount > 0 do
			local count = math.min(100, amount)
			totalWeight = totalWeight + type_gold:getWeight(count)
			amount = amount - count
			inventorySlots = inventorySlots + 1
		end
	end

	-- If player don't have enough capacity to carry this money
	if self:getFreeCapacity() < totalWeight then
		return false
	end

	-- If player don't have enough available inventory slots to carry this money
	local backpack = self:getSlotItem(CONST_SLOT_BACKPACK)
	if not backpack or backpack:getEmptySlots(true) < inventorySlots then
		return false
	end
	return true
end

function Player.withdrawMoney(self, amount)
	local balance = self:getBankBalance()
	if amount > balance or not self:addMoney(amount) then
		return false
	end

	self:setBankBalance(balance - amount)
	return true
end

function Player.depositMoney(self, amount)
	if not self:removeMoney(amount) then
		return false
	end

	self:setBankBalance(self:getBankBalance() + amount)
	return true
end

function Player.removeTotalMoney(self, amount)
	local moneyCount = self:getMoney()
	local bankCount = self:getBankBalance()
	if amount <= moneyCount then
		self:removeMoney(amount)
		return true
	elseif amount <= (moneyCount + bankCount) then
		if moneyCount ~= 0 then
			self:removeMoney(moneyCount)
			local remains = amount - moneyCount
			self:setBankBalance(bankCount - remains)
			self:sendTextMessage(MESSAGE_INFO_DESCR, ("Paid %d from inventory and %d gold from bank account. Your account balance is now %d gold."):format(moneyCount, amount - moneyCount, self:getBankBalance()))
			return true
		else
			self:setBankBalance(bankCount - amount)
			self:sendTextMessage(MESSAGE_INFO_DESCR, ("Paid %d gold from bank account. Your account balance is now %d gold."):format(amount, self:getBankBalance()))
			return true
		end
	end
	return false
end

function Player.addLevel(self, amount, round)
	round = round or false
	local level, amount = self:getLevel(), amount or 1
	if amount > 0 then
		return self:addExperience(Game.getExperienceForLevel(level + amount) - (round and self:getExperience() or Game.getExperienceForLevel(level)))
	else
		return self:removeExperience(((round and self:getExperience() or Game.getExperienceForLevel(level)) - Game.getExperienceForLevel(level + amount)))
	end
end

function Player.addSkillLevel(self, skillId, value)
	local currentSkillLevel = self:getSkillLevel(skillId)
	local sum = 0

	if value > 0 then
		while value > 0 do
			sum = sum + self:getProfession():getRequiredSkillTries(skillId, currentSkillLevel + value)
			value = value - 1
		end

		return self:addSkillTries(skillId, sum - self:getSkillTries(skillId))
	else
		value = math.min(currentSkillLevel, math.abs(value))
		while value > 0 do
			sum = sum + self:getProfession():getRequiredSkillTries(skillId, currentSkillLevel - value + 1)
			value = value - 1
		end

		return self:removeSkillTries(skillId, sum + self:getSkillTries(skillId), true)
	end
end

function Player.addSkill(self, skillId, value, round)
	if skillId == SKILL_LEVEL then
		return self:addLevel(value, round or false)
	end
	return self:addSkillLevel(skillId, value)
end

function Player.getTotalMoney(self)
	return self:getMoney() + self:getBankBalance()
end

function Player.addPokemon(self, pokeballId, name, level, gender, nature, ivs)
  local pokeballInfo = Game.getPokeballInfo(pokeballId)
  local item = self:addItem(pokeballInfo.charged, 1)
  local pokeball = Pokeball(item)

  if not pokeball then
    local errorMessage = string.format("Failed to execute function <Player.addPokemon>: The item id %d is not a valid poke ball.", pokeballId)
    print(debug.traceback(errorMessage))
    return false
  end

  local pokemonType = PokemonType(name)
  if not pokemonType then
    local errorMessage = string.format("Failed to execute function <Player.addPokemon>: The PokemonType '%s' does not exist.", name)
    print(debug.traceback(errorMessage))
    return false
  end

  pokeball:setInfoId(pokeballId)
  pokeball:setPokemonName(name)
  pokeball:setPokemonLevel(level)
  pokeball:setPokemonGender(gender)
  pokeball:setPokemonNature(nature)
  pokeball:setPokemonHealth(Functions.getPokemonMaxHealth(name, level, gender, ivs.health, 0))
  pokeball:setPortrait(pokemonType:portrait())
  pokeball:setState(POKEBALL_STATE_ON)
  pokeball:setPokemonIvs(
    ivs.attack, ivs.defense, ivs.health,
    ivs.specialAttack, ivs.specialDefense, ivs.speed
  )

  local container = pokeball:getParentContainer()
  if container then
    self:updateContainerItem(container, pokeball)
  end
  return true
end

function Player.sendPokemonToDepot(self, pokeballId, name, level, gender, nature, ivs)
  local pokeballInfo = Game.getPokeballInfo(pokeballId)
	local depot = self:getInbox()
  local item = depot:addItem(pokeballInfo.charged, 1, INDEX_WHEREEVER, FLAG_NOLIMIT)
  local pokeball = Pokeball(item)

  if not pokeball then
    local errorMessage = string.format("Failed to execute function <Player.addPokemon>: The item id %d is not a valid poke ball.", pokeballId)
    print(debug.traceback(errorMessage))
    return false
  end

  local pokemonType = PokemonType(name)
  if not pokemonType then
    local errorMessage = string.format("Failed to execute function <Player.addPokemon>: The PokemonType '%s' does not exist.", name)
    print(debug.traceback(errorMessage))
    return false
  end

  pokeball:setInfoId(pokeballId)
  pokeball:setPokemonName(name)
  pokeball:setPokemonLevel(level)
  pokeball:setPokemonGender(gender)
  pokeball:setPokemonNature(nature)
  pokeball:setPokemonHealth(Functions.getPokemonMaxHealth(name, level, gender, ivs.health, 0))
  pokeball:setPortrait(pokemonType:portrait())
  pokeball:setState(POKEBALL_STATE_ON)
  pokeball:setPokemonIvs(
    ivs.attack, ivs.defense, ivs.health,
    ivs.specialAttack, ivs.specialDefense, ivs.speed
  )

  return true
end

function Player.sendBlueMessage(self, message, ...)
	local params = { ... }

	for _, param in ipairs(params) do
		message = message .. tostring(param)
	end
	self:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, message)
end

function Player.sendOrangeMessage(self, message, ...)
	local params = { ... }

	for _, param in ipairs(params) do
		message = message .. tostring(param)
	end
	self:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, message)
end

function Player.sendRedMessage(self, message, ...)
	local params = { ... }

	for _, param in ipairs(params) do
		message = message .. tostring(param)
	end
	self:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, message)
end

function Player.updatePokeballs(self)
	for slot=CONST_SLOT_ONE, CONST_SLOT_SIX do
		local item = self:getSlotItem(slot)

		if item then
			local pokeball = Pokeball(item)
			if pokeball then
				self:sendInventoryItem(slot, pokeball)
			end
		end
	end

	return true
end

local abilitys_storages = {
	["ride"] = {storage = 9800},
	["surf"] = {storage = 9802},
}

function Player.activateAbility(self, ability)
	if ability == "fly" then
		return self:setFlying(true) == true
	end

	local config = abilitys_storages[ability]

	if not config then
		return false
	end

	self:setStorageValue(config.storage, 1)
	return true
end

function Player.deactivateAbility(self, ability)
	if ability == "fly" then
		return self:setFlying(false) == false
	end

	local config = abilitys_storages[ability]
	
	if not config then
		return false
	end

	self:setStorageValue(config.storage, -1)
	return true
end

function Player.isOnAbility(self)
	if self:isRiding() then
		return "ride"
	elseif self:isSurfing() then
		return "surf"
	elseif self:isFlying() then
		return "fly"
	end

	return false
end

function Player.setRiding(self, value)
	return self:setStorageValue(9800, value)
end

function Player.isRiding(self)
	return self:getStorageValue(9800) == 1
end

function Player.isSurfing(self)
	return self:getStorageValue(9802) == 1
end

function Player.setSurfing(self, value)
	return self:setStorageValue(9802, value)
end

function Player.updatePokeball(self)
	local item = self:getSlotItem(CONST_SLOT_FEET)

	if item then
		local pokeball = Pokeball(item)
		if pokeball then
			self:sendInventoryItem(CONST_SLOT_FEET, pokeball)
		end
	end

	return true
end
