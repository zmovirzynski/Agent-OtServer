local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FLYINGDAMAGE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat:setParameter(COMBAT_PARAM_POWER, 15)

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant, isHotkey)
  local target = creature:getTarget()

  if target then
    local targetPos = target:getPosition()
    targetPos:sendMagicEffect(154)
  end

	combat:execute(creature, variant)

  addEvent(function(cid, variant)
    local creature = Creature(cid)

    if not creature then
      return
    end

    combat:execute(creature, variant)
  end, 100, creature:getId(), variant)
  return true
end

spell:name("Drill Peck")
spell:words("drill peck")
spell:id(1)
spell:level(1)
spell:range(1)
spell:cooldown(4000)
spell:needTarget(true)
spell:register()
