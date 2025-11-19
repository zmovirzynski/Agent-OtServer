OrderSystem = { }

function OrderSystem.movePokemon(player, position)
  local pokemon = player:getPokemon()
	if not pokemon then
		return false
	end

	Game.movePokemon(pokemon, position)
	return true
end
