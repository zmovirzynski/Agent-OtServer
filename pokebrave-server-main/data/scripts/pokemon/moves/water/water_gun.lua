local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_WATERDAMAGE)
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
      position:sendMagicEffect(168)
    elseif direction == DIRECTION_EAST then
      position.x = position.x + 5
      position.y = position.y + 1
      position:sendMagicEffect(165)
    elseif direction == DIRECTION_SOUTH then
      position.x = position.x + 1
      position.y = position.y + 5
      position:sendMagicEffect(167)
    elseif direction == DIRECTION_WEST then
      position.x = position.x - 1
      position.y = position.y + 1
      position:sendMagicEffect(166)
    end
  end
  return true
end

spell:name("Water Gun")
spell:words("water gun")
spell:id(2)
spell:needDirection(true)
spell:needTarget(false)
spell:register()
