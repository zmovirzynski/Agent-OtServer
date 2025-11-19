local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_POISONDAMAGE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 13)
combat:setParameter(COMBAT_PARAM_POWER, 15)

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

function onTargetCreature(creature, target)
  local level = creature:getLevel()
  local attack = creature:getStatusAttack()

  local power = 2
  local min = (2 * level / 5 + 2) + (power * (attack * 0.2))
	local max = (2 * level / 5 + 2) + (power * (attack * 1.8))
  local damage = math.random(min, max)

  if math.random(100) <= 100 then
    local poisonCondition = Condition(CONDITION_POISON)
    poisonCondition:setParameter(CONDITION_PARAM_TICKS, 1 * 1000)
    poisonCondition:setParameter(CONDITION_PARAM_TICKINTERVAL, 1000)
    poisonCondition:addDamage(4, 1000, -damage)
    target:addCondition(poisonCondition)
  end
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, onTargetCreature)

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant, isHotkey)
	combat:execute(creature, variant)
  return true
end

spell:name("Poison Sting")
spell:words("poison sting")
spell:id(6)
spell:level(12)
spell:range(6)
spell:cooldown(10000)
spell:needTarget(true)
spell:register()
