local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 10)
combat:setParameter(COMBAT_PARAM_EFFECT, 108)
combat:setArea(createCombatArea(AREA_CIRCLE2X2))

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant, isHotkey)
	combat:execute(creature, variant)
  return true
end

spell:name("Fire Ball")
spell:words("fire ball")
spell:id(3)
spell:level(12)
spell:range(2)
spell:cooldown(7000)
spell:needTarget(true)
spell:register()
