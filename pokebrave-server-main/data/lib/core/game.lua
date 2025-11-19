function Game.broadcastMessage(message, messageType)
	if not messageType then
		messageType = MESSAGE_STATUS_WARNING
	end

	for _, player in ipairs(Game.getPlayers()) do
		player:sendTextMessage(messageType, message)
	end
end

function Game.convertIpToString(ip)
	local band = bit.band
	local rshift = bit.rshift
	return string.format("%d.%d.%d.%d",
		band(ip, 0xFF),
		band(rshift(ip, 8), 0xFF),
		band(rshift(ip, 16), 0xFF),
		rshift(ip, 24)
	)
end

function Game.getReverseDirection(direction)
	if direction == WEST then
		return EAST
	elseif direction == EAST then
		return WEST
	elseif direction == NORTH then
		return SOUTH
	elseif direction == SOUTH then
		return NORTH
	elseif direction == NORTHWEST then
		return SOUTHEAST
	elseif direction == NORTHEAST then
		return SOUTHWEST
	elseif direction == SOUTHWEST then
		return NORTHEAST
	elseif direction == SOUTHEAST then
		return NORTHWEST
	end
	return NORTH
end

if not globalStorageTable then
	globalStorageTable = {}
end

function Game.getStorageValue(key)
	return globalStorageTable[key]
end

function Game.setStorageValue(key, value)
	globalStorageTable[key] = value
end

function Game.generateIvs()
  local ivs = {
    attack = math.random(1, MAX_POKEMON_IV_VALUE),
    defense = math.random(1, MAX_POKEMON_IV_VALUE),
    health = math.random(1, MAX_POKEMON_IV_VALUE),
    specialAttack = math.random(1, MAX_POKEMON_IV_VALUE),
    specialDefense = math.random(1, MAX_POKEMON_IV_VALUE),
    speed = math.random(1, MAX_POKEMON_IV_VALUE)
  }
  return ivs
end

function Game.updatePlayerPokeball(player)
  local pokeball = player:getPokeball()

  if not pokeball then
    return false
  end

  local container = pokeball:getParentContainer()

  if container then
    player:updateContainerItem(container, pokeball)
    return true
  end
  return false
end
