local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
  OrderSystem.movePokemon(player, toPosition)
	return true
end

action:id(2674)
action:allowFarUse(true)
action:register()
