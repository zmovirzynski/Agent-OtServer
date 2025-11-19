GobackSystem = {
  exhaustion = { },
  waitChangePokemon = { }
}

function GobackSystem.go(player, pokeball, ignoreEffect, ignoreAbility)
  if not player then
    return false
  end

  if GobackSystem.playerIsOnCooldown(player) then
    return false
  end

  if player:isOnAbility() and not ignoreAbility then
    return false
  end

  local pokemon = player:getPokemon()
  local playerPosition = player:getPosition()

  if pokemon then
    return false
  end

  if not pokeball then
    return false
  end

  if pokeball:getPokemonHealth() <= 0 then
    player:sendCancelMessage(const.messages.faintedPokemon)
    playerPosition:sendMagicEffect(const.failEffect)
    return false
  end

  local ivs = pokeball:getPokemonIvs()
  local evs = pokeball:getPokemonEvs()

  local spawnPosition = player:getPosition()
  local pokemonName = pokeball:getPokemonName()

  local pokemonType = PokemonType(pokemonName)
  if not pokemonType then
    return false
  end

  local pokemonRequiredLevel = pokemonType:requiredLevel()
  if player:getLevel() < pokemonRequiredLevel then
    player:sendCancelMessage(string.format(const.messages.noLevel, pokemonRequiredLevel))
    playerPosition:sendMagicEffect(const.failEffect)
    return false
  end

  local pokemon = Game.createPokemon(pokemonName, spawnPosition, player, false, true)
  if not pokemon then
    return false
  end

  local pokeballInfo = pokeball:getInfo()
  local playerPosition = player:getPosition()
  local pokemonPosition = pokemon:getPosition()

  if not ignoreEffect then
    doSendDistanceShoot(playerPosition, pokemonPosition, pokeballInfo.shotEffect)
    pokemonPosition:sendMagicEffect(pokeballInfo.callEffect)

    module.scheduleEvent(function(args)
      local playerId = args.playerId
      local spawnPosition = args.spawnPosition
      local player = Player(playerId)

      if not player then
        return false
      end

      doSendDistanceShoot(spawnPosition, playerPosition, pokeballInfo.shotEffect)
    end, 300, { playerId = player:getId(), spawnPosition = pokemonPosition })
  end

  pokemon:setIvs(
    ivs.attack, ivs.defense, ivs.health,
    ivs.specialAttack, ivs.specialDefense, ivs.speed
  )
  pokemon:setEvs(
    evs.attack, evs.defense, evs.health,
    evs.specialAttack, evs.specialDefense, evs.speed
  )

  pokemon:setLevel(pokeball:getPokemonLevel())
  pokemon:setGender(pokeball:getPokemonGender())
  pokemon:setNature(pokeball:getPokemonNature())
  pokemon:setExperience(pokeball:getPokemonExperience())
  pokemon:setMaxHealth(pokemonType:maxHealth())
  pokemon:updateStatus()
  pokemon:setHealth(math.min(pokeball:getPokemonHealth(), pokemon:getMaxHealth()))

  player:setPokemon(pokemon)
  player:setPokeball(pokeball)

  pokeball:setPokemon(pokemon)
  pokeball:setState(POKEBALL_STATE_OFF)
  pokeball:refresh()

  player:updatePokeball()
  GobackSystem.setPlayerCooldown(player)
  
  local message = const.goPokeMessages[math.random(#const.goPokeMessages)]
  message = message:gsub("|POKEMON|", pokemon:getName())
  player:say(message, TALKTYPE_POKEMON_SAY)
  return true
end

function GobackSystem.back(player, fainted, logout, ignoreEffect, ignoreState)
  if not player then
    return
  end

  local pokemon = player:getPokemon()
  if not pokemon then
    return
  end

  local pokeball = player:getPokeball()
  if not pokeball then
    return
  end

  local pokeballInfo = pokeball:getInfo()
  local playerPosition = player:getPosition()
  local pokemonPosition = pokemon:getPosition()

  if not ignoreEffect then
    doSendDistanceShoot(playerPosition, pokemonPosition, pokeballInfo.shotEffect)
    pokemonPosition:sendMagicEffect(pokeballInfo.callEffect)
  end

  if not logout then
    module.scheduleEvent(function(args)
      local playerId = args.playerId
      local pokemonPos = args.pokemonPos
      local player = Player(playerId)

      if not player then
        return false
      end

      doSendDistanceShoot(pokemonPos, playerPosition, pokeballInfo.shotEffect)
    end, 300, { playerId = player:getId(), pokemonPos = pokemonPosition })
  end

  local message = const.backPokeMessages[math.random(#const.backPokeMessages)]
  message = message:gsub("|POKEMON|", pokemon:getName())
  player:say(message, TALKTYPE_POKEMON_SAY)

  pokeball:setPokemonHealth(pokemon:getHealth())
  pokeball:setPokemonExperience(pokemon:getExperience())
  pokeball:updatePokemonAbilities()
  pokemon:remove()
  pokeball:setPokemon(nil)
  player:setPokemon(nil)

  if fainted then
    pokeball:setState(POKEBALL_STATE_FAINTED)
  else
    if not ignoreState then
      pokeball:setState(POKEBALL_STATE_ON)
    end
  end

  if not ignoreState then
    player:updatePokeball()
  end
  return true
end

function GobackSystem.playerIsOnCooldown(player)
  local playerId = player:getId()
  local playerExhaustion = GobackSystem.exhaustion[playerId]

  if not playerExhaustion then
    return false
  end

  local currentTime = os.mtime()
  if playerExhaustion > currentTime then
    return true
  end

  return false
end

function GobackSystem.setPlayerCooldown(player)
  local playerId = player:getId()
  local currentTime = os.mtime()
  local cooldown = const.cooldown

  GobackSystem.exhaustion[playerId] = currentTime + cooldown
end

function GobackSystem.getPlayerCooldown(player)
  local playerId = player:getId()
  local playerExhaustion = GobackSystem.exhaustion[playerId]
  local currentTime = os.mtime()

  if not playerExhaustion then
    return 0
  end

  return playerExhaustion - currentTime
end

function GobackSystem.changePokemon(player, pokeball)
  local playerId = player:getId()
  local waitingChangePokemon = GobackSystem.waitChangePokemon[playerId]

  if waitingChangePokemon then
    return false
  end

  local cooldown = GobackSystem.getPlayerCooldown(player)
  if cooldown > 0 then
    GobackSystem.waitChangePokemon[playerId] = true
    module.scheduleEvent(function(args)
      local playerId = args.playerId
      local player = Player(playerId)

      if not player then
        return
      end

      GobackSystem.back(player)
      GobackSystem.setPlayerCooldown(player)

      module.scheduleEvent(function(args)
        local playerId = args.playerId
        local player = Player(playerId)

        if not player then
          return
        end

        GobackSystem.go(player, pokeball, pokeball:getHolderId())
        GobackSystem.waitChangePokemon[playerId] = nil
      end, const.cooldown, { playerId = playerId })
    end, cooldown, { playerId = playerId })
  else
    GobackSystem.back(player)
    module.scheduleEvent(function(args)
      local playerId = args.playerId
      local player = Player(playerId)

      if not player then
        return
      end

      GobackSystem.go(player, pokeball, pokeball:getHolderId())
      GobackSystem.waitChangePokemon[playerId] = nil
    end, const.cooldown, { playerId = playerId })
  end
end

module.export("go", GobackSystem.go)
module.export("back", GobackSystem.back)
