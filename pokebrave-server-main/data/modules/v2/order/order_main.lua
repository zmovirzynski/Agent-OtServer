local _onUseOrder
local _onPokemonFinishedOrder

function init()
  module.connect('onUseItemId', _onUseOrder, const.orderIdItem)
  module.connect("onPokemonFinishedOrder", _onPokemonFinishedOrder)
end

function terminate()
  module.disconnect('onUseItemId', const.orderIdItem)
  module.disconnect("onPokemonFinishedOrder")
end

function _onUseOrder(params)
  local player = params.creature
  local target = params.target
  local toPosition = params.toPosition

  local ability = player:isOnAbility()
  local tile = Tile(toPosition)

  if ability then 
    if target == player and ability ~= "surf" then
      if player:deactivateAbility(ability) then
        OrderSystem.unmount(player, ability)
        return true
      end
    end

    local border = tile:getTopTopItem()
    if border and ability == "surf" then
      local borderId = border:getId()

      if const.waterBorderIds[borderId] then
        local playerPos = player:getPosition()
        
        if playerPos:getDistance(toPosition) <= const.minDistanceToSurf then
          local newPosition = toPosition:getClosestFreePosition(1, const.waterGroundIds)

           if newPosition and player:deactivateAbility(ability) then
            player:teleportTo(newPosition)
            OrderSystem.unmount(player, ability)
          else
            player:sendCancelMessage(const.messages.notFoundGroundTile)
          end

          return true
        else
          player:sendCancelMessage(const.messages.playerFarAway)
          return true
        end
      end
    end
  end

  local pokemon = player:getPokemon()
  if not pokemon then
    return player:sendCancelMessage(const.messages.notFoundPokemon)
  end

  if tile then
    local border = tile:getTopTopItem()

    if border then
      local borderId = border:getId()

      if const.waterBorderIds[borderId] then
        if pokemon:hasAbility("surf") then
          local playerPos = player:getPosition()
          local pokemonPos = pokemon:getPosition()
          
          if playerPos:getDistance(toPosition) <= const.minDistanceToSurf then
            if pokemonPos:getDistance(playerPos) <= const.minDistanceToSurf then
              local newPosition = toPosition:getClosestFreePosition(1, nil, const.waterGroundIds)
              
              if newPosition then
                player:teleportTo(newPosition)
                OrderSystem.mount(player, "surf")
              else
                player:sendCancelMessage(const.messages.notFoundWaterTile)
              end
            else
              player:sendCancelMessage(const.messages.pokemonFarAway)
            end
          else
            player:sendCancelMessage(const.messages.playerFarAway)
          end

          return
        else
          player:sendCancelMessage(const.messages.noSurfAbility)
        end
      end
    end
  end

  pokemon:setOrderPosition(toPosition)
  return true
end

function _onPokemonFinishedOrder(params)
  local pokemon = params.pokemon
  if not pokemon then
    return true
  end

  local tile = Tile(params.position)
  if not tile then
    return true
  end

  local player = tile:getTopCreature()
  if player == pokemon:getMaster() then
    if pokemon:hasAbility("ride") then
      OrderSystem.mount(player, "ride")
      return true
    elseif pokemon:hasAbility("fly") then
      OrderSystem.mount(player, "fly")
      return true
    end
  end

  local item = tile:getTopTopItem()
  if item then
    if (pokemon:hasAbility("cut") and item:isCuttable()) or (pokemon:hasAbility("smash") and item:isSmashable() or (pokemon:hasAbility("dig") and item:isDiggable())) then
      local destroyId = ItemType(item:getId()):getDestroyId()
      if destroyId == 0 then
        return true
      end

      item:transform(destroyId)
      pokemon:setHoldPosition(false)
      item:decay()
    end
  end
end
