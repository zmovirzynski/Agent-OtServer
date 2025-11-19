local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_BUGDAMAGE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 16)
combat:setParameter(COMBAT_PARAM_EFFECT, 49)

local paralyzeCondition = Condition(CONDITION_PARALYZE)
paralyzeCondition:setParameter(CONDITION_PARAM_TICKS, 5000)
paralyzeCondition:setFormula(-1, 80, -1, 80)

combat:addCondition(paralyzeCondition)

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant, isHotkey)
	combat:execute(creature, variant)
  return true
end

spell:name("String Shot")
spell:words("string shot")
spell:id(5)
spell:level(12)
spell:range(6)
spell:cooldown(12000)
spell:needTarget(true)
spell:register()
