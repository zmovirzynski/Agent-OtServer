local _onUsePokeball

function init()
  for _, pokeballId in ipairs(const.pokeballs) do
    module.connect("onUseItemId", _onUsePokeball, pokeballId)
  end
end

function terminate()
  for _, pokeballId in ipairs(const.pokeballs) do
    module.disconnect("onUseItemId", pokeballId)
  end
end

function _onUsePokeball(params)
  local player = params.creature
  local item = params.item

  local slot = player:getSlotItem(CONST_SLOT_FEET)
  if not slot then
    return true
  end

  local pokeball = Pokeball(item)
  if not pokeball then
    return true
  end

  if pokeball ~= slot then
    player:sendCancelMessage("You must put your pokeball in the correct place.")
    return true
  end

  local pokemon = player:getPokemon()

  if pokemon then
    GobackSystem.back(player)
  else
    GobackSystem.go(player, pokeball)
  end

	return true
end
