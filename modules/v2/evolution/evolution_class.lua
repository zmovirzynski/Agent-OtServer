EvolutionSystem = { }

function EvolutionSystem.validateInformation(player, target)
  local messages = const.messages

  if not target:isPokemon() then
    player:sendCancelMessage(messages.targetIsNotPokemon)
    return false
  end

  if player:getPokemon() ~= target then
    player:sendCancelMessage(messages.notOwner)
    return false
  end

  return true
end

function EvolutionSystem.evolve(pokemon, stoneId)
  if not pokemon:isPokemon() then
    return false
  end

  if pokemon:evolve(stoneId) then
    local pokemonPosition = pokemon:getPosition()
    pokemonPosition:sendMagicEffect(const.evolveEffect)
    return true
  end
  return false
end
