local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_NORMALDAMAGE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 17)
combat:setParameter(COMBAT_PARAM_EFFECT, 107)

local drunkCondition = Condition(CONDITION_DRUNK)
drunkCondition:setParameter(CONDITION_PARAM_TICKS, 5000)
drunkCondition:setFormula(-1, 80, -1, 80)

combat:addCondition(drunkCondition)

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant, isHotkey)
	combat:execute(creature, variant)
  return true
end

spell:name("Super Sonic")
spell:words("super sonic")
spell:id(5)
spell:level(12)
spell:range(6)
spell:cooldown(5000)
spell:needTarget(true)
spell:register()
