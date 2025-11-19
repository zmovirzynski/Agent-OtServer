TechnicalMachineSystem = {}

function TechnicalMachineSystem.sendWindow(player, technicalmachines, pid)
	local pokemon = player:getPokemon()
	if not pokemon then
		return true
	end

	local pokemonType = PokemonType(pokemon:getName())
	if not pokemonType then
		return true
	end

	local moves = player:getPokeball():getMoves()
	if not moves then
		return true
	end

  local data = {
    protocol = "open",
    moves = moves,
		technicalmachines = technicalmachines,
		pid=pid,
  }

  player:sendExtendedOpcode(const.opcode, json.encode(data))
end
