registerPokemonType = {}
setmetatable(registerPokemonType,
{
	__call =
	function(self, ptype, mask)
		for _,parse in pairs(self) do
			parse(ptype, mask)
		end
	end
})

PokemonType.register = function(self, mask)
	return registerPokemonType(self, mask)
end

registerPokemonType.name = function(ptype, mask)
	if mask.name then
		ptype:name(mask.name)
	end
end
registerPokemonType.description = function(ptype, mask)
	if mask.description then
		ptype:nameDescription(mask.description)
	end
end
registerPokemonType.experience = function(ptype, mask)
	if mask.experience then
		ptype:experience(mask.experience)
	end
end
registerPokemonType.skull = function(ptype, mask)
	if mask.skull then
		ptype:skull(mask.skull)
	end
end
registerPokemonType.outfit = function(ptype, mask)
	if mask.outfit then
		ptype:outfit(mask.outfit)
	end
end
registerPokemonType.gender = function(ptype, mask)
	if mask.gender then
		local malePercent = mask.gender.malePercent or 0
		local femalePercent = mask.gender.femalePercent or 0

		ptype:genderMalePercent(malePercent)
		ptype:genderFemalePercent(femalePercent)
	end
end
registerPokemonType.spawnLevel = function(ptype, mask)
	if mask.spawnLevel then
		local min = mask.spawnLevel.min or 1
		local max = mask.spawnLevel.max or 100

		ptype:minSpawnLevel(min)
		ptype:maxSpawnLevel(max)
	end
end
registerPokemonType.evolutions = function(ptype, mask)
	if type(mask.evolutions) == "table" then
		for _, evolution in pairs(mask.evolutions) do
			ptype:addEvolution(evolution.name, evolution.stone, evolution.level)
		end
	end
end
registerPokemonType.portrait = function(ptype, mask)
	if mask.portrait then
		ptype:portrait(mask.portrait)
	end
end
registerPokemonType.maxHealth = function(ptype, mask)
	if mask.maxHealth then
		ptype:maxHealth(mask.maxHealth)
		ptype:health(math.min(ptype:health(), mask.maxHealth))
	end
end
registerPokemonType.health = function(ptype, mask)
	if mask.health then
		ptype:health(mask.health)
		ptype:maxHealth(math.max(mask.health, ptype:maxHealth()))
	end
end
registerPokemonType.runHealth = function(ptype, mask)
	if mask.runHealth then
		ptype:runHealth(mask.runHealth)
	end
end
registerPokemonType.maxSummons = function(ptype, mask)
	if mask.maxSummons then
		ptype:maxSummons(mask.maxSummons)
	end
end
registerPokemonType.types = function(ptype, mask)
	if mask.types.first then
		ptype:firstType(mask.types.first)
	end
	if mask.types.second then
		ptype:secondType(mask.types.second)
	end
end
registerPokemonType.speed = function(ptype, mask)
	if mask.speed then
		ptype:baseSpeed(mask.speed)
	end
end
registerPokemonType.corpse = function(ptype, mask)
	if mask.corpse then
		ptype:corpseId(mask.corpse)
	end
end
registerPokemonType.baseStats = function(ptype, mask)
	if mask.baseStats then
		if mask.baseStats.health ~= nil then
			ptype:baseHealth(mask.baseStats.health)
		end
		if mask.baseStats.attack ~= nil then
			ptype:baseAttack(mask.baseStats.attack)
		end
		if mask.baseStats.defense ~= nil then
			ptype:baseDefense(mask.baseStats.defense)
		end
		if mask.baseStats.specialAttack ~= nil then
			ptype:baseSpecialAttack(mask.baseStats.specialAttack)
		end
		if mask.baseStats.specialDefense ~= nil then
			ptype:baseSpecialDefense(mask.baseStats.specialDefense)
		end
		if mask.baseStats.speed ~= nil then
			ptype:baseSpeed(mask.baseStats.speed)
		end
	end
end
registerPokemonType.flags = function(ptype, mask)
	if mask.flags then
		if mask.flags.catchRate ~= nil then
			ptype:catchRate(mask.flags.catchRate)
		end
		if mask.flags.requiredLevel ~= nil then
			ptype:requiredLevel(mask.flags.requiredLevel)
		end
		if mask.flags.attackable ~= nil then
			ptype:isAttackable(mask.flags.attackable)
		end
		if mask.flags.healthHidden ~= nil then
			ptype:isHealthHidden(mask.flags.healthHidden)
		end
		if mask.flags.boss ~= nil then
			ptype:isBoss(mask.flags.boss)
		end
		if mask.flags.challengeable ~= nil then
			ptype:isChallengeable(mask.flags.challengeable)
		end
		if mask.flags.convinceable ~= nil then
			ptype:isConvinceable(mask.flags.convinceable)
		end
		if mask.flags.summonable ~= nil then
			ptype:isSummonable(mask.flags.summonable)
		end
		if mask.flags.ignoreSpawnBlock ~= nil then
			ptype:isIgnoringSpawnBlock(mask.flags.ignoreSpawnBlock)
		end
		if mask.flags.illusionable ~= nil then
			ptype:isIllusionable(mask.flags.illusionable)
		end
		if mask.flags.hostile ~= nil then
			ptype:isHostile(mask.flags.hostile)
		end
		if mask.flags.pushable ~= nil then
			ptype:isPushable(mask.flags.pushable)
		end
		if mask.flags.canPushItems ~= nil then
			ptype:canPushItems(mask.flags.canPushItems)
		end
		if mask.flags.canPushCreatures ~= nil then
			ptype:canPushCreatures(mask.flags.canPushCreatures)
		end
		-- if a pokemon can push creatures,
		-- it should not be pushable
		if mask.flags.canPushCreatures then
			ptype:isPushable(false)
		end
		if mask.flags.targetDistance then
			ptype:targetDistance(mask.flags.targetDistance)
		end
		if mask.flags.staticAttackChance then
			ptype:staticAttackChance(mask.flags.staticAttackChance)
		end
		if mask.flags.canWalkOnEnergy ~= nil then
			ptype:canWalkOnEnergy(mask.flags.canWalkOnEnergy)
		end
		if mask.flags.canWalkOnFire ~= nil then
			ptype:canWalkOnFire(mask.flags.canWalkOnFire)
		end
		if mask.flags.canWalkOnPoison ~= nil then
			ptype:canWalkOnPoison(mask.flags.canWalkOnPoison)
		end
	end
end
registerPokemonType.pokedexInformation = function(mtype, mask)
  if mask.pokedexInformation then
    if mask.pokedexInformation.nationalNumber ~= nil then
      mtype:nationalNumber(mask.pokedexInformation.nationalNumber)
    end

    if mask.pokedexInformation.description ~= nil then
      mtype:description(mask.pokedexInformation.description)
    end

    if mask.pokedexInformation.height ~= nil then
      mtype:height(mask.pokedexInformation.height)
    end

    if mask.pokedexInformation.weight ~= nil then
      mtype:weight(mask.pokedexInformation.weight)
    end
  end
end
registerPokemonType.light = function(ptype, mask)
	if mask.light then
		ptype:light(mask.light.color or 0, mask.light.level or 0)
	end
end
registerPokemonType.changeTarget = function(ptype, mask)
	if mask.changeTarget then
		if mask.changeTarget.chance then
			ptype:changeTargetChance(mask.changeTarget.chance)
		end
		if mask.changeTarget.interval then
			ptype:changeTargetSpeed(mask.changeTarget.interval)
		end
	end
end
registerPokemonType.voices = function(ptype, mask)
	if type(mask.voices) == "table" then
		local interval, chance
		if mask.voices.interval then
			interval = mask.voices.interval
		end
		if mask.voices.chance then
			chance = mask.voices.chance
		end
		for k, v in pairs(mask.voices) do
			if type(v) == "table" then
				ptype:addVoice(v.text, interval, chance, v.yell)
			end
		end
	end
end
registerPokemonType.summons = function(ptype, mask)
	if type(mask.summons) == "table" then
		for k, v in pairs(mask.summons) do
			ptype:addSummon(v.name, v.interval, v.chance, v.max or -1)
		end
	end
end
registerPokemonType.events = function(ptype, mask)
	if type(mask.events) == "table" then
		for k, v in pairs(mask.events) do
			ptype:registerEvent(v)
		end
	end
end
registerPokemonType.loot = function(ptype, mask)
	if type(mask.loot) == "table" then
		local lootError = false
		for _, loot in pairs(mask.loot) do
			local parent = Loot()
			if not parent:setId(loot.id) then
				lootError = true
			end
			if loot.chance then
				parent:setChance(loot.chance)
			end
			if loot.maxCount then
				parent:setMaxCount(loot.maxCount)
			end
			if loot.aid or loot.actionId then
				parent:setActionId(loot.aid or loot.actionId)
			end
			if loot.subType or loot.charges then
				parent:setSubType(loot.subType or loot.charges)
			end
			if loot.text or loot.description then
				parent:setDescription(loot.text or loot.description)
			end
			if loot.child then
				for _, children in pairs(loot.child) do
					local child = Loot()
					if not child:setId(children.id) then
						lootError = true
					end
					if children.chance then
						child:setChance(children.chance)
					end
					if children.maxCount then
						child:setMaxCount(children.maxCount)
					end
					if children.aid or children.actionId then
						child:setActionId(children.aid or children.actionId)
					end
					if children.subType or children.charges then
						child:setSubType(children.subType or children.charges)
					end
					if children.text or children.description then
						child:setDescription(children.text or children.description)
					end
					parent:addChildLoot(child)
				end
			end
			ptype:addLoot(parent)
		end
		if lootError then
			print("[Warning - end] Pokemon: \"".. ptype:name() .. "\" loot could not correctly be load.")
		end
	end
end
registerPokemonType.elements = function(ptype, mask)
	if type(mask.elements) == "table" then
		for _, element in pairs(mask.elements) do
			if element.type and element.percent then
				ptype:addElement(element.type, element.percent)
			end
		end
	end
end
registerPokemonType.immunities = function(ptype, mask)
	if type(mask.immunities) == "table" then
		for _, immunity in pairs(mask.immunities) do
			if immunity.type and immunity.combat then
				ptype:combatImmunities(immunity.type)
			end
			if immunity.type and immunity.condition then
				ptype:conditionImmunities(immunity.type)
			end
		end
	end
end
registerPokemonType.moves = function(ptype, mask)
	if type(mask.moves) == "table" then
		for _, move in ipairs(mask.moves) do
			ptype:addMove(move.id, move.level, move.name)
		end
	end
end
registerPokemonType.learnableTMs = function(ptype, mask)
	if type(mask.learnableTMs) == "table" then
		for _, tm in ipairs(mask.learnableTMs) do
			ptype:addLearnableMove(tm.move)
		end
	end
end
registerPokemonType.learnableHMs = function(ptype, mask)
	if type(mask.learnableHMs) == "table" then
		for _, hm in ipairs(mask.learnableHMs) do
			ptype:addLearnableAbility(hm.ability)
		end
	end
end
registerPokemonType.attacks = function(ptype, mask)
	if type(mask.attacks) == "table" then
		for _, attack in pairs(mask.attacks) do
			local spell = PokemonSpell()
			if attack.name then
				if attack.name == "melee" then
					spell:setType("melee")
					if attack.attack and attack.skill then
						spell:setAttackValue(attack.attack, attack.skill)
					end
					if attack.minDamage and attack.maxDamage then
						spell:setCombatValue(attack.minDamage, attack.maxDamage)
					end
					if attack.interval then
						spell:setInterval(attack.interval)
					end
					if attack.effect then
						spell:setCombatEffect(attack.effect)
					end
					if attack.condition then
						if attack.condition.type then
							spell:setConditionType(attack.condition.type)
						end
						local startDamage = 0
						if attack.condition.startDamage then
							startDamage = attack.condition.startDamage
						end
						if attack.condition.minDamage and attack.condition.maxDamage then
							spell:setConditionDamage(attack.condition.minDamage, attack.condition.maxDamage, startDamage)
						end
						if attack.condition.duration then
							spell:setConditionDuration(attack.condition.duration)
						end
						if attack.condition.interval then
							spell:setConditionTickInterval(attack.condition.interval)
						end
					end
				else
					spell:setType(attack.name)
					if attack.type then
						if attack.name == "combat" then
							spell:setCombatType(attack.type)
						else
							spell:setConditionType(attack.type)
						end
					end
					if attack.interval then
						spell:setInterval(attack.interval)
					end
					if attack.chance then
						spell:setChance(attack.chance)
					end
					if attack.range then
						spell:setRange(attack.range)
					end
					if attack.duration then
						spell:setConditionDuration(attack.duration)
					end
					if attack.speed then
						if type(attack.speed) ~= "table" then
							spell:setConditionSpeedChange(attack.speed)
						elseif type(attack.speed) == "table" then
							if attack.speed.min and attack.speed.max then
								spell:setConditionSpeedChange(attack.speed.min, attack.speed.max)
							end
						end
					end
					if attack.target then
						spell:setNeedTarget(attack.target)
					end
					if attack.length then
						spell:setCombatLength(attack.length)
					end
					if attack.spread then
						spell:setCombatSpread(attack.spread)
					end
					if attack.radius then
						spell:setCombatRadius(attack.radius)
					end
					if attack.minDamage and attack.maxDamage then
						if attack.name == "combat" then
							spell:setCombatValue(attack.minDamage, attack.maxDamage)
						else
							local startDamage = 0
							if attack.startDamage then
								startDamage = attack.startDamage
							end
							spell:setConditionDamage(attack.minDamage, attack.maxDamage, startDamage)
						end
					end
					if attack.effect then
						spell:setCombatEffect(attack.effect)
					end
					if attack.shootEffect then
						spell:setCombatShootEffect(attack.shootEffect)
					end
					if attack.name == "drunk" then
						spell:setConditionType(CONDITION_DRUNK)
						if attack.drunkenness then
							spell:setConditionDrunkenness(attack.drunkenness)
						end
					end
				end
			elseif attack.script then
				spell:setScriptName(attack.script)
				if attack.interval then
					spell:setInterval(attack.interval)
				end
				if attack.chance then
					spell:setChance(attack.chance)
				end
				if attack.minDamage and attack.maxDamage then
					spell:setCombatValue(attack.minDamage, attack.maxDamage)
				end
				if attack.target then
					spell:setNeedTarget(attack.target)
				end
				if attack.direction then
					spell:setNeedDirection(attack.direction)
				end
			end
			ptype:addAttack(spell)
		end
	end
end
registerPokemonType.defenses = function(ptype, mask)
	if type(mask.defenses) == "table" then
		if mask.defenses.defense then
			ptype:defense(mask.defenses.defense)
		end
		if mask.defenses.armor then
			ptype:armor(mask.defenses.armor)
		end
		for _, defense in pairs(mask.defenses) do
			if type(defense) == "table" then
				local spell = PokemonSpell()
				if defense.name then
					if defense.name == "melee" then
						spell:setType("melee")
						if defense.attack and defense.skill then
							spell:setAttackValue(defense.attack, defense.skill)
						end
						if defense.minDamage and defense.maxDamage then
							spell:setCombatValue(defense.minDamage, defense.maxDamage)
						end
						if defense.interval then
							spell:setInterval(defense.interval)
						end
						if defense.effect then
							spell:setCombatEffect(defense.effect)
						end
						if defense.condition then
							if defense.condition.type then
								spell:setConditionType(defense.condition.type)
							end
							local startDamage = 0
							if defense.condition.startDamage then
								startDamage = defense.condition.startDamage
							end
							if defense.condition.minDamage and defense.condition.maxDamage then
								spell:setConditionDamage(defense.condition.minDamage, defense.condition.maxDamage, startDamage)
							end
							if defense.condition.duration then
								spell:setConditionDuration(defense.condition.duration)
							end
							if defense.condition.interval then
								spell:setConditionTickInterval(defense.condition.interval)
							end
						end
					else
						spell:setType(defense.name)
						if defense.type then
							if defense.name == "combat" then
								spell:setCombatType(defense.type)
							else
								spell:setConditionType(defense.type)
							end
						end
						if defense.interval then
							spell:setInterval(defense.interval)
						end
						if defense.chance then
							spell:setChance(defense.chance)
						end
						if defense.range then
							spell:setRange(defense.range)
						end
						if defense.duration then
							spell:setConditionDuration(defense.duration)
						end
						if defense.speed then
							if type(defense.speed) ~= "table" then
								spell:setConditionSpeedChange(defense.speed)
							elseif type(defense.speed) == "table" then
								if defense.speed.min and defense.speed.max then
									spell:setConditionSpeedChange(defense.speed.min, defense.speed.max)
								end
							end
						end
						if defense.target then
							spell:setNeedTarget(defense.target)
						end
						if defense.length then
							spell:setCombatLength(defense.length)
						end
						if defense.spread then
							spell:setCombatSpread(defense.spread)
						end
						if defense.radius then
							spell:setCombatRadius(defense.radius)
						end
						if defense.minDamage and defense.maxDamage then
							if defense.name == "combat" then
								spell:setCombatValue(defense.minDamage, defense.maxDamage)
							else
								local startDamage = 0
								if defense.startDamage then
									startDamage = defense.startDamage
								end
								spell:setConditionDamage(defense.minDamage, defense.maxDamage, startDamage)
							end
						end
						if defense.effect then
							spell:setCombatEffect(defense.effect)
						end
						if defense.shootEffect then
							spell:setCombatShootEffect(defense.shootEffect)
						end
					end
				elseif defense.script then
					spell:setScriptName(defense.script)
					if defense.interval then
						spell:setInterval(defense.interval)
					end
					if defense.chance then
						spell:setChance(defense.chance)
					end
					if defense.minDamage and defense.maxDamage then
						spell:setCombatValue(defense.minDamage, defense.maxDamage)
					end
					if defense.target then
						spell:setNeedTarget(defense.target)
					end
					if defense.direction then
						spell:setNeedDirection(defense.direction)
					end
				end
				ptype:addDefense(spell)
			end
		end
	end
end
