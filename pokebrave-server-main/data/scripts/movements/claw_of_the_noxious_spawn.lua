local clawOfTheNoxiousSpawn = MoveEvent()

function clawOfTheNoxiousSpawn.onEquip(player, item, slot, isCheck)
	if isCheck == false then
		if not Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) then
			doTargetCombat(0, player, COMBAT_NORMALDAMAGE, -150, -200, CONST_ME_DRAWBLOOD)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ouch! The serpent claw stabbed you.")
			return true
		end
	end
	return true
end

clawOfTheNoxiousSpawn:type("equip")
clawOfTheNoxiousSpawn:slot("head")
clawOfTheNoxiousSpawn:id(10310)
clawOfTheNoxiousSpawn:register()
