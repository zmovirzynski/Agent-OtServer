local _onUsePokedex

function init()
  module.connect("onUseItemId", _onUsePokedex, const.pokedexId)
end

function terminate()
  module.disconnect("onUseItemId", const.pokedexId)
end

function _onUsePokedex(params)
  local player = params.creature
  if not player then
    return true
  end

  local target = params.target
  if not target then
    return true
  end

  local pokemonType = PokemonType(target:getName())
  if not pokemonType then
    return true
  end

  PokedexSystem.register(player, pokemonType)

	return true
end
