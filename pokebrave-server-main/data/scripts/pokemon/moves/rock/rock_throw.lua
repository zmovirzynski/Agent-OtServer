local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ROCKDAMAGE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 23)
combat:setParameter(COMBAT_PARAM_EFFECT, 174)
combat:setParameter(COMBAT_PARAM_POWER, 15)

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant, isHotkey)
	combat:execute(creature, variant)
  return true
end

spell:name("Rock Throw")
spell:words("rock throw")
spell:id(1)
spell:level(1)
spell:range(8)
spell:cooldown(7000)
spell:needTarget(true)
spell:register()
