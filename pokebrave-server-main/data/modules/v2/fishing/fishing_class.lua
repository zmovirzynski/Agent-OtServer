FishingSystem = {
  players = { } -- guid : item
}

function FishingSystem.onUseRod(params)
  local player = params.creature
  local target = params.target
  local targetId = target:getId()

  local fishItem = FishingSystem.players[player:getGuid()]
  if fishItem then
    if targetId == fishItem:getId() then
      if player:hasTag("fishOnTheHook") then
        FishingSystem.spawnFish(player)
      else
        player:removeFishingOutfit()
        FishingSystem.removePlayerFishItem(player)
      end
    end
  end

  if not const.waterIds[targetId] then
    return true
  end

  if player:isFishing() then
    return
  end

  if not player:isWearingFishermanOutfit() then
    player:sendRedMessage("You need a fisherman's outfit to go fish.")
    return false
  end

  FishingSystem.doFish(player, target:getPosition())
end

function FishingSystem.onUseBait(params)
  local player = params.creature
  local bait = params.item
  local baitId = bait:getId()

  local baitStorageValue = player:getStorageValue(const.baitStorage)
  if baitStorageValue ~= -1 then
    player:setStorageValue(const.baitStorage, -1)
    player:sendBlueMessage("You remove the bait from the fishing rod.")

    if baitStorageValue == baitId then
      return
    end
  end

  local rod = player:getSlotItem(CONST_SLOT_LEFT)
  if not rod then
    return
  end

  local rodId = rod:getId()

  local foundRodId = false
  for _, otherRodId in ipairs(const.rods) do
    if otherRodId == rodId then
      foundRodId = true
      break
    end
  end

  if not foundRodId then
    return
  end

  if not const.allowBaitsOnRod[baitId][rodId] then
    return
  end

  local needFishingLevel = const.allowBaitsOnRod[baitId].fishingLevel
  if player:getSkillLevel(SKILL_FISHING) < needFishingLevel then
    player:sendRedMessage("You need fishing level ", needFishingLevel, " to use this bait.")
    return
  end

  player:setStorageValue(const.baitStorage, baitId)
  player:sendBlueMessage("You have added this bait to the fishing rod!")
end

function FishingSystem.doFish(player, waterPos)
  local item = Game.createItem(const.fishItem, 1, waterPos)
  if not item then
    return
  end

  FishingSystem.players[player:getGuid()] = item

  player:setFishingOutfit()
  player:setMovementBlocked(true)
  if player:getSkillLevel(SKILL_FISHING) <= 100 then
    player:addSkillTries(SKILL_FISHING, 1)
  end

  FishingSystem.fishCycle(player)
end

function FishingSystem.fishCycle(player)
  local delayToFish = math.random(1, const.maxDelayToFish) * 1000
  module.scheduleEvent(function(args)
    local playerId = args.playerId
    local player = Player(playerId)

    if not player then
      return
    end

    local item = FishingSystem.players[player:getGuid()]
    if not item then
      return
    end

    item:transform(const.fishOnTheHookItem)
    FishingSystem.fishOnTheHook(player)
  end, delayToFish, { playerId = player:getId() })
end

function FishingSystem.fishOnTheHook(player)
  player:addTimedTag("fishOnTheHook", const.fishingTimeout)
  module.scheduleEvent(function(args)
    local playerId = args.playerId
    local player = Player(playerId)

    if not player then
      return
    end

    player:removeFishingOutfit()
    player:setMovementBlocked(false)
    FishingSystem.removePlayerFishItem(player)
  end, const.fishingTimeout, { playerId = player:getId() })
end

function FishingSystem.spawnFish(player)
  player:removeTag("fishOnTheHook")
  player:removeFishingOutfit()
  player:setMovementBlocked(false)

  FishingSystem.removePlayerFishItem(player)

  local baitId = player:getStorageValue(const.baitStorage)
  if baitId == -1 then
    baitId = "default"
  end

  local data = const.fishings[baitId]

  local spawnQuantity = math.random(1, 5)
  for _ = 1, spawnQuantity do
    local pokemonData = data[math.random(#data)]
    Game.createPokemon(pokemonData.name, player:getClosestFreePosition(player:getPosition()))
  end

  if isNumber(baitId) then
    player:removeItem(baitId, 1)
  end
end

function FishingSystem.removePlayerFishItem(player)
  local playerGuid = player:getGuid()
  local item = FishingSystem.players[playerGuid]

  if item then
    item:remove()
    FishingSystem.players[playerGuid] = nil
  end
end
