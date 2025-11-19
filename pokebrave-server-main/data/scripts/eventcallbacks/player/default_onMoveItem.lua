local ec = EventCallback

ec.onMoveItem = function(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	local itemType = ItemType(item:getId())
	if itemType:isPokeball() then
		if item:getState() == POKEBALL_STATE_OFF then
			return RETURNVALUE_NOTPOSSIBLE
		end

		if toPosition.x == CONTAINER_POSITION and self:getPokemonCapacity() then
			return RETURNVALUE_MAXPOKEMONINBAG
		end
	end

	if item:getAttribute("wrapid") ~= 0 then
		local tile = Tile(toPosition)
		if (fromPosition.x ~= CONTAINER_POSITION and toPosition.x ~= CONTAINER_POSITION) or tile and not tile:getHouse() then
			if tile and not tile:getHouse() then
				return RETURNVALUE_NOTPOSSIBLE
			end
		end
	end

	if toPosition.x ~= CONTAINER_POSITION then
		return RETURNVALUE_NOERROR
	end

	if item:getTopParent() == self and bit.band(toPosition.y, 0x40) == 0 then
		local _, moveItem = ItemType(item:getId())

		if moveItem then
			local parent = item:getParent()
			if parent:isContainer() and parent:getSize() == parent:getCapacity() then
				return RETURNVALUE_CONTAINERNOTENOUGHROOM
			else
				return moveItem:moveTo(parent) and RETURNVALUE_NOERROR or RETURNVALUE_NOTPOSSIBLE
			end
		end
	end

	return RETURNVALUE_NOERROR
end

ec:register()
