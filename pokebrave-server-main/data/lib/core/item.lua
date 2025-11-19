function Item.getType(self)
	return ItemType(self:getId())
end

function Item.isContainer(self)
	return false
end

function Item.isCreature(self)
	return false
end

function Item.isPokemon(self)
	return false
end

function Item.isNpc(self)
	return false
end

function Item.isPlayer(self)
	return false
end

function Item.isTeleport(self)
	return false
end

function Item.isTile(self)
	return false
end

-- Helper class to make string formatting prettier

StringStream = {}

setmetatable(StringStream, {
	__call = function(self)
		local obj = {}
		return setmetatable(obj, {__index = StringStream})
	end
})

function StringStream.append(self, str, ...)
	self[#self+1] = string.format(str, ...)
end

function StringStream.concat(self, sep)
	return table.concat(self, sep)
end

local aux = {
	['Defense'] = {key = ITEM_ATTRIBUTE_DEFENSE},
	['ExtraDefense'] = {key = ITEM_ATTRIBUTE_EXTRADEFENSE},
	['Attack'] = {key = ITEM_ATTRIBUTE_ATTACK},
	['AttackSpeed'] = {key = ITEM_ATTRIBUTE_ATTACK_SPEED},
	['HitChance'] = {key = ITEM_ATTRIBUTE_HITCHANCE},
	['ShootRange'] = {key = ITEM_ATTRIBUTE_SHOOTRANGE},
	['Armor'] = {key = ITEM_ATTRIBUTE_ARMOR},
	['Duration'] = {key = ITEM_ATTRIBUTE_DURATION, cmp = function(v) return v > 0 end},
	['Text'] = {key = ITEM_ATTRIBUTE_TEXT, cmp = function(v) return v ~= '' end},
	['Date'] = {key = ITEM_ATTRIBUTE_DATE},
	['Writer'] = {key = ITEM_ATTRIBUTE_WRITER, cmp = function(v) return v ~= '' end}
}

function setAuxFunctions()
	for name, def in pairs(aux) do
		Item['get'.. name] = function(self)
			local attr = self:getAttribute(def.key)
			if def.cmp and def.cmp(attr) then
				return attr
			elseif not def.cmp and attr and attr ~= 0 then
				return attr
			end
			local default = ItemType['get'.. name]
			return default and default(self:getType()) or nil
		end
	end
end

setAuxFunctions()

do
	local function internalItemGetNameDescription(it, item, subType, addArticle)
		local subType = subType or (item and item:getSubType() or -1)
		local ss = StringStream()
		local obj = item or it
		local name = obj:getName()
		if name ~= '' then
			if it:isStackable() and subType >  1 then
				if it:hasShowCount() then
					ss:append('%d ', subType)
				end
				ss:append('%s', obj:getPluralName())
			else
				if addArticle and obj:getArticle() ~= '' then
					ss:append('%s ', obj:getArticle())
				end
				ss:append('%s', obj:getName())
			end
		else
			ss:append('an item of type %d', obj:getId())
		end
		return ss:concat()
	end

	function Item.getNameDescription(self, subType, addArticle)
		return internalItemGetNameDescription(self:getType(), self, subType, addArticle)
	end

	function ItemType.getNameDescription(self, subType, addArticle)
		return internalItemGetNameDescription(self, nil, subType, addArticle)
	end
end

do
	local function internalItemGetDescription(it, lookDistance, item, subType, addArticle)
		local abilities = it:getAbilities()
		local ss = StringStream()
		local subType = subType or (item and item:getSubType() or -1)
		local text = nil
		local begin = true
		local obj = item or it

		if item then
			ss:append(item:getNameDescription(subType, addArticle or true))
		else
			ss:append(it:getNameDescription(subType, addArticle or true))
		end

		if obj:getArmor() ~= 0 or it:hasShowAttributes() then
			if obj:getArmor() ~= 0 then
				ss:append(' (Arm:%d', obj:getArmor())
				begin = false
			end
			begin = addGenerics(item, it, abilities, ss, begin)
			if not begin then
				ss:append(')')
			end
		elseif it:isContainer() or item and item:isContainer() then
			local volume = 0

			if not item or not item:hasAttribute(ITEM_ATTRIBUTE_UNIQUEID) then
				if it:isContainer() then
					volume = it:getCapacity()
				else
					volume = item:getCapacity()
				end
			end

			if volume ~= 0 then
				ss:append(' (Vol:%d)', volume)
			end
		else
			local found = true

			if abilities.speed > 0 then
				ss:append(' (speed %s%d)', showpos(abilities.speed), math.abs(abilities.speed / 2))
			elseif bit.band(abilities.conditionSuppressions, CONDITION_DRUNK) == 1 then
				ss:append(' (hard drinking)')
			elseif abilities.invisible then
				ss:append(' (invisibility)')
			elseif abilities.regeneration then
				ss:append(' (faster regeneration)')
			else
				found = false
			end

			if not found then
				if it:getType() == ITEM_TYPE_KEY then
					local aid = item and item:getActionId() or 0
					ss:append(' (Key:%s)', ('0'):rep(4 - #tostring(aid)) .. aid)
				elseif it:getGroup() == ITEM_GROUP_FLUID then
					if subType > 0 then
						local name = getSubTypeName(subType)
						ss:append(' of %s', name ~= '' and name or 'unknown')
					else
						ss:append('. It is empty')
					end
				elseif it:getGroup() == ITEM_GROUP_SPLASH then
					local name = getSubTypeName(subType)
					ss:append(' of ')
					if subType > 0 and name ~= '' then
						ss:append(name)
					else
						ss:append('unknown')
					end
				elseif it:hasAllowDistRead() and (it:getId() < 7369 or it:getId() > 7371) then
					ss:append('.\n')
					if lookDistance <= 4 then
						if item then
							if not text then
								text = item:getText()
							end
							if text then
								local writer = item:getWriter()
								if writer then
									local date = item:getDate()
									ss:append('%s wrote', writer)
									if date then
										ss:append(' on %s', os.date('%d %b %Y'))
									end
									ss:append(': ')
								else
									ss:append('You read: ')
								end
								ss:append(text)
							else
								ss:append('Nothing is written on it')
							end
						else
							ss:append('Nothing is written on it')
						end
					else
						ss:append('You are too far away to read it.')
					end
				elseif it:getLevelDoor() ~= 0 and item then
					local aid = item:getActionId()
					if aid >= it:getLevelDoor() then
						ss:append(' for level %d', aid - it:getLevelDoor())
					end
				end
			end
		end

		if it:hasShowCharges() then
			ss:append(' that has %d charge%s left', subType, subType ~= -1 and 's' or '')
		end

		-- show duration
		if it:hasShowDuration() then
			if item and item:hasAttribute(ITEM_ATTRIBUTE_DURATION) then
				local duration = item:getDuration() / 1000
				if duration > 0 then
					ss:append(' that will expire in ')

					if duration >= 86400 then
						local days = math.floor(duration / 86400)
						local hours = math.floor((duration % 86400) / 3600)
						ss:append('%d day%s', days, days ~= 1 and 's' or '')
						if hours > 0 then
							ss:append(' and %d hour%s', hours, hours ~= 1 and 's' or '')
						end
					elseif duration >= 3600 then
						local hours = math.floor(duration / 3600)
						local minutes = math.floor((duration % 3600) / 60)
						ss:append('%d hour%s', hours, hours ~= 1 and 's' or '')
						if minutes > 0 then
							ss:append(' and %d minute%s', minutes, minutes ~= 1 and 's' or '')
						end
					elseif duration >= 60 then
						local minutes = math.floor(duration / 60)
						local seconds = duration % 60
						ss:append('%d minute%s', minutes, minutes ~= 1 and 's' or '')
						if seconds > 0 then
							ss:append(' and %d second%s', seconds, seconds ~= 1 and 's' or '')
						end
					else
						ss:append('%d second%s', duration, duration ~= 1 and 's' or '')
					end
				end
			else
				ss:append(' that is brand-new')
			end
		end

		if not it:hasAllowDistRead() or (it:getId() >= 7369 and it:getId() <= 7371) then
			ss:append('.')
		else
			if not text and item then
				text = item:getText()
			end
			if not text or text == '' then
				ss:append('.')
			end
		end

		local wieldInfo = it:getWieldInfo()
		if wieldInfo ~= 0 then
			ss:append('\nIt can only be wielded properly by ')

			if bit.band(wieldInfo, WIELDINFO_PREMIUM) ~= 0 then
				ss:append('premium ')
			end

			local vocStr = it:getProfessionString()
			if vocStr ~= '' then
				ss:append(vocStr)
			else
				ss:append('players')
			end

			if bit.band(wieldInfo, WIELDINFO_LEVEL) ~= 0 then
				ss:append(' of level %d or higher', it:getMinReqLevel())
			end

			ss:append('.')
		end

		if lookDistance <= 1 then
			local weight = obj:getWeight()
			local count = item and item:getCount() or 1
			if weight ~= 0 and it:isPickupable() then
				ss:append('\n')
				if it:isStackable() and count > 1 and it:hasShowCount() then
					ss:append('They weigh ')
				else
					ss:append('It weighs ')
				end
				ss:append('%.2f oz.', weight / 100)
			end
		end

		local desc = it:getDescription()
		if item then
			local specialDesc = item:getSpecialDescription()
			if specialDesc ~= '' then
				ss:append('\n%s', specialDesc)
			elseif lookDistance <= 1 and desc ~= '' then
				ss:append('\n%s', desc)
			end
		elseif lookDistance <= 1 and desc ~= '' then
			ss:append('\n%s', it:getDescription())
		end

		if it:hasAllowDistRead() or (it:getId() >= 7369 and it:getId() <= 7371) then
			if not text and item then
				text = item:getText()
			end

			if text and text ~= '' then
				ss:append('\n%s', text)
			end
		end

		return ss:concat()
	end

	if not oldItemDesc then
		oldItemDesc = Item.getDescription
	end

	if configManager.getBoolean(configKeys.LUA_ITEM_DESC) then
		function Item.getDescription(self, lookDistance, subType)
			return internalItemGetDescription(self:getType(), lookDistance, self, subType)
		end

		function ItemType.getItemDescription(self, lookDistance, subType)
			return internalItemGetDescription(self, lookDistance, nil, subType)
		end
	else
		Item.getDescription = oldItemDesc
	end
end
