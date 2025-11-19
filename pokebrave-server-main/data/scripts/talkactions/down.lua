local talk = TalkAction("!down")

function talk.onSay(player, words, param)
	if not player:isFlying() then
    return false
  end

  local position = player:getPosition()
  if position.z == 7 or position.z >= 15 then
    return false
  end

  local playerTile = Tile(position)
  if playerTile then
    local playerGround = playerTile:getGround()
    if playerGround then
      if playerGround:getId() ~= INVISIBLE_TILE_ID then
        return false
      end
    end
  end

  position.z = position.z + 1

  local tile = Tile(position)
  if not tile then
    player:teleportTo(position)
    return false
  end

  if tile:queryAdd(player) == RETURNVALUE_NOERROR then
    player:teleportTo(position)
  end

  return false
end

talk:register()
