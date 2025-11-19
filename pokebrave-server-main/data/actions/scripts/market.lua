function onUse(player, item, fromPosition, target, toPosition, isHotkey)
  player:sendMarketBuyItems(Market.category.all, 1, Market.order.timeasc)
  return true
end
