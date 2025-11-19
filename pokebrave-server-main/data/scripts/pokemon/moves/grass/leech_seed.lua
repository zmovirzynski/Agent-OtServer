local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_GRASSDAMAGE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat:setParameter(COMBAT_PARAM_EFFECT, 54)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 9)
combat:setParameter(COMBAT_PARAM_POWER, 40)

local condition = Condition(CONDITION_POISON)
condition:setParameter(CONDITION_PARAM_PERIODICDAMAGE, -20)
condition:setParameter(CONDITION_PARAM_TICKS, 5 * 1000)
condition:setParameter(CONDITION_PARAM_TICKINTERVAL, 1000)

local regenerationCondition = Condition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
regenerationCondition:setTicks(5 * 1000)
regenerationCondition:setParameter(CONDITION_PARAM_HEALTHGAIN, 20)
regenerationCondition:setParameter(CONDITION_PARAM_HEALTHTICKS, 1000)

function onTargetCreature(creature, target)
  local targetPokemonType = PokemonType(target:getName())
  if not targetPokemonType then
    return
  end

  if targetPokemonType:firstType() == POKEMON_TYPE_GRASS then
    return
  end

  target:addCondition(condition)
  creature:addCondition(regenerationCondition)
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, onTargetCreature)

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant, isHotkey)
	combat:execute(creature, variant)
  return true
end

spell:name("Leech Seed")
spell:words("leech seed")
spell:id(2)
spell:level(9)
spell:range(6)
spell:cooldown(12000)
spell:needTarget(true)
spell:register()
