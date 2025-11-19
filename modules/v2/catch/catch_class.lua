CatchSystem = { }

function CatchSystem.validateInformation(player, toPosition)
  local messages = const.messages

  local tile = Tile(toPosition)
  if not tile or not tile:getTopDownItem() or not ItemType(tile:getTopDownItem():getId()):isCorpse() then
    return messages.invalidPokemonCorpse
  end

  local corpse = tile:getTopDownItem()
  local owner = corpse:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER)
  if owner ~= 0 and owner ~= player:getId() then
    return messages.notOwner
  end

  local name = corpse:getCorpseName()
  if not name then
    return messages.unableToCatchPokemon
  end

  local pokemonType = PokemonType(name)
  if not pokemonType then
    return messages.unableToLoadPokemon
  end

  if pokemonType:catchRate() == 0 then
    return messages.cannotCatchPokemon
  end
  return nil
end

function CatchSystem.tryCatch(player, pokeballId, toPosition)
  local pokeballInfo = Game.getPokeballInfo(pokeballId)
  local tile = Tile(toPosition)
  local corpse = tile:getTopDownItem()
  local pokemonType = PokemonType(corpse:getCorpseName())
  local playerPosition = player:getPosition()

  doSendDistanceShoot(playerPosition, toPosition, pokeballInfo.shotEffect)

  local catchRate = pokemonType:catchRate()
  local catchChance = math.min(
    math.floor(catchRate * pokeballInfo.multiplier, const.catchRangeMax)
  )

  if math.random(0, const.catchRangeMax) <= catchChance then
    toPosition:sendMagicEffect(pokeballInfo.catchEffect)
    return true
  else
    toPosition:sendMagicEffect(pokeballInfo.failEffect)
  end
  return false
end

function CatchSystem.addPokemonToPlayer(player, pokeballId, name, level, gender, nature, ivs)
  local messages = const.messages

  pokeballInfo = Game.getPokeballInfo(pokeballId)
  local playerId = player:getId()

  module.scheduleEvent(function(args)
    local playerId = args.playerId
    local pokeballId = args.pokeballId
    local name = args.name
    local level = args.level
    local gender = args.gender
    local nature = args.nature
    local ivs = args.ivs

    local player = Player(playerId)

    if not player then
      return true
    end

    local pokemon = player:getPokemon()
    if pokemon then
      local pokePosition = pokemon:getPosition()
      pokePosition:sendMagicEffect(const.alertEffect)
    end

    if player:getPokemonCapacity() > 0 then
      player:addPokemon(pokeballId, name, level, gender, nature, ivs)
    else
      player:sendCancelMessage(messages.alreadyHoldSixPokemon)
      player:sendPokemonToDepot(pokeballId, name, level, gender, nature, ivs)
    end
  end, pokeballInfo.effectDelay,
    { playerId = playerId, pokeballId = pokeballId, name = name,
      level = level, gender = gender, nature = nature, ivs = ivs })
end
