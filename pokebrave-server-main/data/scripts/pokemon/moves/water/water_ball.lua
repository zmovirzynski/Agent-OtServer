local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_WATERDAMAGE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 21)
combat:setParameter(COMBAT_PARAM_EFFECT, 163)
combat:setArea(createCombatArea(AREA_CIRCLE2X2))
combat:setParameter(COMBAT_PARAM_POWER, 15)

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant, isHotkey)
	combat:execute(creature, variant)
  return true
end

spell:name("Water Ball")
spell:words("water ball")
spell:id(3)
spell:level(12)
spell:range(2)
spell:cooldown(7000)
spell:needTarget(true)
spell:register()
