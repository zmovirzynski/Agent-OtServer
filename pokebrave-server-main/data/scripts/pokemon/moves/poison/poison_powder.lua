local ignorePokemonTypes = {
  [POKEMON_TYPE_POISON] = true,
  [POKEMON_TYPE_STEEL] = true,
}

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_POISONDAMAGE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat:setParameter(COMBAT_PARAM_EFFECT, 57)
combat:setArea(createCombatArea(AREA_CIRCLE2X2))

function onTargetCreature(creature, target)
  local targetPokemonType = PokemonType(target:getName())
  local pokemonFirstType = targetPokemonType:firstType()
  local pokemonSecondType = targetPokemonType:secondType()
  if ignorePokemonTypes[pokemonFirstType] or ignorePokemonTypes[pokemonSecondType] then
    return
  end

  local level = creature:getLevel()
  local attack = creature:getStatusAttack()

  local power = 2
  local min = (2 * level / 5 + 2) + (power * (attack * 0.2))
  local max = (2 * level / 5 + 2) + (power * (attack * 1.8))
  local damage = math.random(min, max)

  local poisonCondition = Condition(CONDITION_POISON)
  poisonCondition:setParameter(CONDITION_PARAM_TICKS, 1 * 1000)
  poisonCondition:setParameter(CONDITION_PARAM_TICKINTERVAL, 1000)
  poisonCondition:addDamage(4, 1000, -damage)
  target:addCondition(poisonCondition)
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, onTargetCreature)

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant, isHotkey)
	combat:execute(creature, variant)
  return true
end

spell:name("Poison Powder")
spell:words("poison powder")
spell:id(2)
spell:cooldown(7000)
spell:needTarget(false)
spell:register()
