local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat:setParameter(COMBAT_PARAM_POWER, 15)

local area = {
  {1, 1, 1},
  {1, 1, 1},
  {1, 1, 1},
  {1, 1, 1},
  {1, 3, 1},
}

combat:setArea(createCombatArea(area))

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant, isHotkey)
	if combat:execute(creature, variant) then
    local direction = creature:getDirection()
    local position = creature:getPosition()

    if direction == DIRECTION_NORTH then
      position.x = position.x + 1
      position.y = position.y - 1
      position:sendMagicEffect(60)
    elseif direction == DIRECTION_EAST then
      position.x = position.x + 3
      position.y = position.y + 1
      position:sendMagicEffect(63)
    elseif direction == DIRECTION_SOUTH then
      position.x = position.x + 1
      position.y = position.y + 3
      position:sendMagicEffect(61)
    elseif direction == DIRECTION_WEST then
      position.x = position.x - 1
      position.y = position.y + 1
      position:sendMagicEffect(62)
    end
  end
  return true
end

spell:name("Flamethrower")
spell:words("flamethrower")
spell:id(2)
spell:needDirection(true)
spell:needTarget(false)
spell:register()
