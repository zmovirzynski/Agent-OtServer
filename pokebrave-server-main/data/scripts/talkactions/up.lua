local talk = TalkAction("!up")

function talk.onSay(player, words, param)
  if not player:isFlying() then
    return false
  end

  local position = player:getPosition()
  if position.z == 1 then
    return false
  end

  position.z = position.z - 1

  local tile = Tile(position)
  if not tile then
    player:teleportTo(position)
    return false
  end

  if tile:queryAdd(player) == RETURNVALUE_NOERROR then
    local ground = tile:getGround()
    if ground:getId() ~= INVISIBLE_TILE_ID then
      return false
    end
    player:teleportTo(position)
  end
  return false
end

talk:register()
