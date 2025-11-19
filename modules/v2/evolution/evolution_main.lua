local _onUseStone

function init()
  for _, stoneId in ipairs(const.stones) do
    module.connect("onUseItemId", _onUseStone, stoneId)
  end
end

function terminate()
  for _, stoneId in ipairs(const.stones) do
    module.disconnect("onUseItemId", stoneId)
  end
end

function _onUseStone(params)
  local player = params.creature
  local item = params.item
  local target = params.target

  if not EvolutionSystem.validateInformation(player, target) then
    return true
  end

  if not EvolutionSystem.evolve(target, item:getId()) then
    local playerPos = player:getPosition()
    playerPos:sendMagicEffect(const.failEffect)
    return true
  end

  Game.updatePlayerPokeball(player)
  return true
end
