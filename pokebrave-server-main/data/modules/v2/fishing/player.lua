function Player.isWearingFishermanOutfit(self)
  local outfit = self:getOutfit()
  return const.fishingOutfits[outfit.lookType] ~= nil
end

function Player.setFishingOutfit(self)
  if not self:isWearingFishermanOutfit() then
    return
  end

  local outfit = self:getOutfit()
  outfit.lookType = const.fishingOutfits[outfit.lookType]

  local condition = Condition(CONDITION_OUTFIT)
	condition:setOutfit(outfit)
	condition:setTicks(-1)
	self:addCondition(condition)
end

function Player.removeFishingOutfit(self)
  self:removeCondition(CONDITION_OUTFIT)
end

function Player.isFishing(self)
  return FishingSystem.players[self:getGuid()] ~= nil
end
