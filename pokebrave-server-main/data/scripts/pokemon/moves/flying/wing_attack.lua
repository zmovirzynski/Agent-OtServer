local power = 15

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FLYINGDAMAGE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)

local area = {
  {1, 1, 1},
  {1, 1, 1},
  {1, 1, 1},
  {1, 1, 1},
  {1, 3, 1}
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
      position:sendMagicEffect(145)
    elseif direction == DIRECTION_EAST then
      position.x = position.x + 2
      position.y = position.y + 1
      position:sendMagicEffect(146)
    elseif direction == DIRECTION_SOUTH then
      position.x = position.x + 1
      position.y = position.y + 2
      position:sendMagicEffect(148)
    elseif direction == DIRECTION_WEST then
      position.x = position.x - 1
      position.y = position.y + 1
      position:sendMagicEffect(147)
    end
  end
  return true
end

spell:name("Wing Attack")
spell:words("wing attack")
spell:id(2)
spell:needDirection(true)
spell:needTarget(false)
spell:register()
