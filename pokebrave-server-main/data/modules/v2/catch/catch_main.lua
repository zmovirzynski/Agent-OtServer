local _onUseEmptyPokeball

function init()
  for _, emptyPokeballId in ipairs(const.emptyPokeballs) do
    module.connect("onUseItemId", _onUseEmptyPokeball, emptyPokeballId)
  end
end

function terminate()
  for _, emptyPokeballId in ipairs(const.emptyPokeballs) do
    module.disconnect("onUseItemId", emptyPokeballId)
  end
end

function _onUseEmptyPokeball(params)
  local player = params.creature
  local item = params.item
  local toPosition = params.toPosition

  local message = CatchSystem.validateInformation(player, toPosition)
  if message then
    player:sendCancelMessage(message)
    return true
  end

  item:remove(1)

  local itemId = item:getId()
  local tile = Tile(toPosition)
  local corpse = tile:getTopDownItem()

  if CatchSystem.tryCatch(player, item:getId(), toPosition) then
    local name = corpse:getCorpseName()
    local level = corpse:getAttribute(ITEM_ATTRIBUTE_POKEMONCORPSELEVEL)
    local gender = corpse:getAttribute(ITEM_ATTRIBUTE_POKEMONCORPSEGENDER)
    local nature = corpse:getAttribute(ITEM_ATTRIBUTE_POKEMONCORPSENATURE)
    local ivs = corpse:getPokemonCorpseIvs()

    CatchSystem.addPokemonToPlayer(player, itemId, name, level, gender, nature, ivs)
  end

  corpse:remove()
  return true
end
