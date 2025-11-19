local function getSkillId(skillName)
	if skillName == "fishing" then
		return SKILL_FISHING
	elseif skillName == "level" then
		return SKILL_LEVEL
	end

	return nil
end

function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end

	local split = param:splitTrimmed(",")
	if not split[2] then
		player:sendCancelMessage("Insufficient parameters.")
		return false
	end

	local target = Player(split[1])
	if not target then
		player:sendCancelMessage("A player with that name is not online.")
		return false
	end

	local count = 1
	if split[3] then
		count = tonumber(split[3])
	end

	local skillId = getSkillId(split[2])
	if not skillId then
		player:sendCancelMessage("Unknown skill.")
		return false
	end

	target:addSkill(skillId, count)
	return false
end
