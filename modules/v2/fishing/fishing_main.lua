local _onLogout

function init()
  for _, rodId in ipairs(const.rods) do
    module.connect("onUseItemId", FishingSystem.onUseRod, rodId)
  end

  for _, baitId in ipairs(const.baits) do
    module.connect("onUseItemId", FishingSystem.onUseBait, baitId)
  end

  module.connect("onLogout", _onLogout)
end

function terminate()
  for _, rodId in ipairs(const.rods) do
    module.disconnect("onUseItemId", rodId)
  end

  for _, baitId in ipairs(const.baits) do
    module.disconnect("onUseItemId", baitId)
  end

  module.disconnect("onLogout")
end

function _onLogout(params)
  local player = params.creature
  local playerGuid = player:getGuid()

  local item = FishingSystem.players[playerGuid]
  if item then
    item:remove()
    FishingSystem.players[playerGuid] = nil
  end
  return true
end
