local _onUseHiddenMachine

function init()
  for hiddenMachineId in pairs(const.hiddenMachines) do
    module.connect("onUseItemId", _onUseHiddenMachine, hiddenMachineId)
  end
end

function terminate()
  for hiddenMachineId in pairs(const.hiddenMachines) do
    module.disconnect("onUseItemId", hiddenMachineId)
  end
end

function _onUseHiddenMachine(params)
  local player = params.creature
  local item = params.item
  local target = params.target
  local messages = const.messages

  if not target:isPokemon() then
    return true
  end

  local pokemon = player:getPokemon()
  if not pokemon or pokemon ~= target then
    return true
  end

  local pokemonType = PokemonType(pokemon:getName())
  if not pokemonType then
    return true
  end

  local itemId = item:getId()
  local hiddenMachines = const.hiddenMachines
  local ability = hiddenMachines[itemId].ability
  local pokemonPos = pokemon:getPosition()

  if pokemon:hasAbility(ability) then
    player:sendCancelMessage(messages.hasAbility)
    pokemonPos:sendMagicEffect(const.failEffect)
    return true
  end

  if not pokemonType:canLearnAbility(ability) then
    player:sendCancelMessage(messages.cannotLearnAbility)
    pokemonPos:sendMagicEffect(const.failEffect)
    return true
  end

  if pokemon:learnAbility(ability) then
    pokemonPos:sendMagicEffect(const.learnEffect)
  end
  return true
end
