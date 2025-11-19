local _onDeath
local _onPokemonLevelUp

function init()
  module.connect("onDeath", _onDeath)
  module.connect("onPokemonLevelUp", _onPokemonLevelUp)
end

function terminate()
  module.disconnect("onDeath")
  module.disconnect("onPokemonLevelUp")
end

function _onDeath(params)
  local creature = params.creature
  local corpse = params.corpse

  if not creature:isPokemon() then
    return true
  end

  local master = creature:getMaster()
  if not master or not master:isPlayer() then
    return true
  end

  g_modules.goback.back(master, true)
  corpse:remove()
  return true
end

function _onPokemonLevelUp(params)
  local pokemon = params.pokemon
  local oldLevel = params.oldLevel
  local newLevel = params.newLevel
  local experience = params.experience

  local master = pokemon:getMaster()
  if master:isPlayer() then
    print(string.format("Trainer: %s - oldLevel: %d - newLevel: %d - experience: %d", master:getName(), oldLevel, newLevel, experience))
  end
end
