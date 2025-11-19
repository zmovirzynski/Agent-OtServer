OrderSystem = {}

function OrderSystem.mount(player, ability)
  if not player then
    return
  end

  local pokemon = player:getPokemon()
  if not pokemon then
    return
  end

  local pokemonType = PokemonType(pokemon:getName())
  g_modules.goback.back(player, false, true, true, true)

  local abilityOutfit = player:getOutfit()
  abilityOutfit.lookType = pokemonType:outfit().lookType

  local condition = Condition(CONDITION_OUTFIT)
	condition:setOutfit(abilityOutfit)
	condition:setTicks(-1)
	player:addCondition(condition)

  player:activateAbility(ability)
end

function OrderSystem.unmount(player, ability)
  if not player then
    return
  end

  local pokeball = player:getPokeball()
  if not pokeball then
    return
  end

  player:removeCondition(CONDITION_OUTFIT)
  g_modules.goback.go(player, pokeball, true)
end

module.export("mount", OrderSystem.mount)
