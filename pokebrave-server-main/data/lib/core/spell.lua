function onGetAttackValues(pokemon, power)
  local level = pokemon:getLevel()
  local attack = pokemon:getStatusAttack()

  local min = (2 * level / 5 + 2) + (power * (attack * 0.2))
	local max = (2 * level / 5 + 2) + (power * (attack * 0.5))
	return -min, -max
end

function onGetSpecialAttackValues(pokemon, power)
  local level = pokemon:getLevel()
  local attack = pokemon:getStatusSpecialAttack()

  local min = (2 * level / 5 + 2) + (power * (attack * 0.2))
	local max = (2 * level / 5 + 2) + (power * (attack * 0.5))
  return -min, -max
end
