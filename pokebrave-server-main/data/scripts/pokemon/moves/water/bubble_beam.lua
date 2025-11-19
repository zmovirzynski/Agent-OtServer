local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_WATERDAMAGE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 21)
combat:setParameter(COMBAT_PARAM_EFFECT, 143)
combat:setParameter(COMBAT_PARAM_POWER, 10)

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant, isHotkey)
	combat:execute(creature, variant)
  for i = 1, 2, 1 do
    addEvent(function(cid, variant)
      local creature = Creature(cid)

      if not creature then
        return
      end

      combat:execute(creature, variant)
    end, i * 300, creature:getId(), variant)
  end
  return true
end

spell:name("Bubble Beam")
spell:words("bubble beam")
spell:id(3)
spell:level(12)
spell:range(8)
spell:cooldown(7000)
spell:needTarget(true)
spell:register()
