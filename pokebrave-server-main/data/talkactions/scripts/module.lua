function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end

	local split = param:splitTrimmed(",")

	if not split[1] then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "[Module - Help]\n - /module reload\n - /module restart")
		return
	end

	local command = split[1]:lower()

	if command == "reload" then
		ModuleManager.reloadAll()
		Game.broadcastMessage("[Module] all packages reloaded.")
	elseif command == "restart" then
		ModuleManager.restart()
		Game.broadcastMessage("[Module] restarted.")
	end
	return false
end