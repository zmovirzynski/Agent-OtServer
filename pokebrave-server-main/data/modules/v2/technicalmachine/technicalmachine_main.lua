local _onUseTechnicalMachine

function init()
  for itemId in pairs(const.technicalMachines) do
    module.connect("onUseItemId", _onUseTechnicalMachine, itemId)
  end
end

function terminate()
  for itemId in pairs(const.technicalMachines) do
    module.disconnect("onUseItemId", itemId)
  end
end

function _onUseTechnicalMachine(params)
  local player = params.creature
  local item = params.item
  local messages = const.messages
  local pokemon = params.target

  if not pokemon or pokemon ~= player:getPokemon() then
    local playerPos = player:getPosition()
    playerPos:sendMagicEffect(const.failEffect)
    return true
  end

  local itemId = item:getId()
  local technicalMachine = const.technicalMachines[itemId]
  local moveName = technicalMachine.move
  local pokemonPos = pokemon:getPosition()
  local pokemonType = PokemonType(pokemon:getName())

  if pokemon:hasMoveByName(moveName) then
    player:sendCancelMessage(messages.hasMove)
    pokemonPos:sendMagicEffect(const.failEffect)
    return true
  end

  if not pokemonType:canLearnMove(moveName) then
    player:sendCancelMessage(messages.cannotLearnMove)
    pokemonPos:sendMagicEffect(const.failEffect)
    return true
  end

  TechnicalMachineSystem.sendWindow(player, technicalMachine, pokemon:getId())

  return true
end
