local _onPokemonThink
local _getPokemonAttackCooldown
local _resetPokemonAttackCooldown
local _pokemonHasAttackCooldown

function init()
  module.connect("onPokemonThink", _onPokemonThink)
end

function terminate()
  module.disconnect("onPokemonThink")
end

function _onPokemonThink(params)
  local pokemon = params.creature

  if pokemon:getMaster() then
    return
  end

  local pokemonName = pokemon:getName():lower()
  local pokemonConst = const.pokemons[pokemonName]

  if not pokemonConst then
    return
  end

  local moves = pokemonConst.moves

  for _, move in ipairs(moves) do
    local attackName = move.name
    local interval = move.interval
    local chance = move.chance

    if not _pokemonHasAttackCooldown(pokemon, attackName) then
      _resetPokemonAttackCooldown(pokemon, attackName)
    end

    local attackCooldown = _getPokemonAttackCooldown(pokemon, attackName)
    local executeMove = true

    if attackCooldown < interval then
      executeMove = false
    end

    if executeMove then
      if chance >= math.random(1, 100) then
        pokemon:castSpell(attackName)
      end

      _resetPokemonAttackCooldown(pokemon, attackName)
    end
  end
  return true
end

function _getPokemonAttackCooldown(pokemon, attackName)
  if not pokemon then
    return nil
  end

  local attackTagName = string.format("attack_%s", attackName)
  local lastTime = pokemon:getTag(attackTagName)
  local elapsedTime = os.mtime() - lastTime
  return elapsedTime
end

function _resetPokemonAttackCooldown(pokemon, attackName)
  if not pokemon then
    return false
  end

  local attackTagName = string.format("attack_%s", attackName)
  pokemon:setTag(attackTagName, os.mtime())
end

function _pokemonHasAttackCooldown(pokemon, attackName)
  if not pokemon then
    return false
  end

  local attackTagName = string.format("attack_%s", attackName)
  return pokemon:hasTag(attackTagName)
end
