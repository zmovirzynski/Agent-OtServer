local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_GROUNDDAMAGE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat:setParameter(COMBAT_PARAM_POWER, 15)

local area = {
  {0, 1, 0},
  {0, 1, 0},
  {0, 3, 0},
}

combat:setArea(createCombatArea(area))

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant, isHotkey)
	if combat:execute(creature, variant) then
    local direction = creature:getDirection()
    local position = creature:getPosition()

    if direction == DIRECTION_NORTH then
      position.x = position.x
      position.y = position.y - 1
      position:sendMagicEffect(151)
    elseif direction == DIRECTION_EAST then
      position.x = position.x + 3
      position.y = position.y
      position:sendMagicEffect(152)
    elseif direction == DIRECTION_SOUTH then
      position.x = position.x
      position.y = position.y + 3
      position:sendMagicEffect(153)
    elseif direction == DIRECTION_WEST then
      position.x = position.x - 1
      position.y = position.y
      position:sendMagicEffect(150)
    end
  end
  return true
end

spell:name("Sand Attack")
spell:words("sand attack")
spell:id(2)
spell:needDirection(true)
spell:needTarget(false)
spell:register()
