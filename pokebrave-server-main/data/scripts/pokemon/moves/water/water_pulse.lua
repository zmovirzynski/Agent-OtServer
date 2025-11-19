local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_WATERDAMAGE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat:setParameter(COMBAT_PARAM_EFFECT, 169)
combat:setParameter(COMBAT_PARAM_POWER, 15)

local area = {
  {0, 0, 1, 1, 1, 0, 0},
  {0, 1, 1, 1, 1, 1, 0},
  {1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 2, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1},
  {0, 1, 1, 1, 1, 1, 0},
  {0, 0, 1, 1, 1, 0, 0},
}

combat:setArea(createCombatArea(area))

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

function onTargetCreature(creature, target)
  target:jump(10, 500)

end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, onTargetCreature)

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant, isHotkey)
	combat:execute(creature, variant)
  return true
end

spell:name("Water Pulse")
spell:words("water pulse")
spell:id(1)
spell:level(1)
spell:range(1)
spell:cooldown(2000)
spell:needTarget(false)
spell:register()
