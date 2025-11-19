local _onLogin

function init()
  module.connect("onLogin", _onLogin)
end

function terminate()
  module.disconnect("onLogin")
end

function _onLogin(params)
  local player = params.creature
  local storage = const.storage
  local items = const.items

  if player:getStorageValue(storage) ~= -1 then
    return true
  end

  for _, itemSchema in ipairs(items) do
    player:addItem(itemSchema.itemId, itemSchema.count)
  end

  player:setStorageValue(storage, 1)
  return true
end
