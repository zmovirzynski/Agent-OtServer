-- combat 1
local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FLYINGDAMAGE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat:setParameter(COMBAT_PARAM_EFFECT, 175)
combat:setParameter(COMBAT_PARAM_POWER, 15)

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

local area = {
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {1, 1, 1, 2, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
}

combat:setArea(createCombatArea(area))

-- combat 2
local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_FLYINGDAMAGE)
combat2:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat2:setParameter(COMBAT_PARAM_EFFECT, 175)
combat2:setParameter(COMBAT_PARAM_POWER, 15)

combat2:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

local area2 = {
  {1, 0, 0, 0, 0, 0, 0},
  {1, 1, 0, 0, 0, 0, 0},
  {1, 1, 1, 0, 0, 0, 0},
  {0, 0, 0, 2, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
}

combat2:setArea(createCombatArea(area2))

-- combat 3
local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_FLYINGDAMAGE)
combat3:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat3:setParameter(COMBAT_PARAM_EFFECT, 175)
combat3:setParameter(COMBAT_PARAM_POWER, 15)

combat3:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

  local area3 = {
    {0, 1, 1, 0, 0, 0, 0},
    {0, 0, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 2, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0},
  }

combat3:setArea(createCombatArea(area3))

-- combat 4
local combat4 = Combat()
combat4:setParameter(COMBAT_PARAM_TYPE, COMBAT_FLYINGDAMAGE)
combat4:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat4:setParameter(COMBAT_PARAM_EFFECT, 175)
combat4:setParameter(COMBAT_PARAM_POWER, 15)

combat4:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

local area4 = {
  {0, 0, 0, 1, 0, 0, 0},
  {0, 0, 0, 1, 0, 0, 0},
  {0, 0, 0, 1, 0, 0, 0},
  {0, 0, 0, 2, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
}

combat4:setArea(createCombatArea(area4))

-- combat 5
local combat5 = Combat()
combat5:setParameter(COMBAT_PARAM_TYPE, COMBAT_FLYINGDAMAGE)
combat5:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat5:setParameter(COMBAT_PARAM_EFFECT, 175)
combat5:setParameter(COMBAT_PARAM_POWER, 15)

combat5:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

local area5 = {
  {0, 0, 0, 0, 1, 1, 1},
  {0, 0, 0, 0, 1, 1, 0},
  {0, 0, 0, 0, 1, 0, 0},
  {0, 0, 0, 2, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
}

combat5:setArea(createCombatArea(area5))

-- combat 6
local combat6 = Combat()
combat6:setParameter(COMBAT_PARAM_TYPE, COMBAT_FLYINGDAMAGE)
combat6:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat6:setParameter(COMBAT_PARAM_EFFECT, 175)
combat6:setParameter(COMBAT_PARAM_POWER, 15)

combat6:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

local area6 = {
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 1},
  {0, 0, 0, 0, 0, 1, 1},
  {0, 0, 0, 2, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
}

combat6:setArea(createCombatArea(area6))

-- combat 7
local combat7 = Combat()
combat7:setParameter(COMBAT_PARAM_TYPE, COMBAT_FLYINGDAMAGE)
combat7:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat7:setParameter(COMBAT_PARAM_EFFECT, 175)
combat7:setParameter(COMBAT_PARAM_POWER, 15)

combat7:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

local area7 = {
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 2, 1, 1, 1},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
}

combat7:setArea(createCombatArea(area7))

-- combat 8
local combat8 = Combat()
combat8:setParameter(COMBAT_PARAM_TYPE, COMBAT_FLYINGDAMAGE)
combat8:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat8:setParameter(COMBAT_PARAM_EFFECT, 175)
combat8:setParameter(COMBAT_PARAM_POWER, 15)

combat8:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

local area8 = {
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 2, 0, 0, 0},
  {0, 0, 0, 0, 1, 1, 1},
  {0, 0, 0, 0, 0, 1, 1},
  {0, 0, 0, 0, 0, 0, 1},
}

combat8:setArea(createCombatArea(area8))

-- combat 9
local combat9 = Combat()
combat9:setParameter(COMBAT_PARAM_TYPE, COMBAT_FLYINGDAMAGE)
combat9:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat9:setParameter(COMBAT_PARAM_EFFECT, 175)
combat9:setParameter(COMBAT_PARAM_POWER, 15)

combat9:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

local area9 = {
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 2, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 1, 0, 0},
  {0, 0, 0, 0, 1, 1, 0},
}

combat9:setArea(createCombatArea(area9))

-- combat 10
local combat10 = Combat()
combat10:setParameter(COMBAT_PARAM_TYPE, COMBAT_FLYINGDAMAGE)
combat10:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat10:setParameter(COMBAT_PARAM_EFFECT, 175)
combat10:setParameter(COMBAT_PARAM_POWER, 15)

combat10:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

local area10 = {
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 2, 0, 0, 0},
  {0, 0, 0, 1, 0, 0, 0},
  {0, 0, 0, 1, 0, 0, 0},
  {0, 0, 0, 1, 0, 0, 0},
}

combat10:setArea(createCombatArea(area10))

-- combat 11
local combat11 = Combat()
combat11:setParameter(COMBAT_PARAM_TYPE, COMBAT_FLYINGDAMAGE)
combat11:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat11:setParameter(COMBAT_PARAM_EFFECT, 175)
combat11:setParameter(COMBAT_PARAM_POWER, 15)

combat11:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

local area11 = {
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 2, 0, 0, 0},
  {0, 0, 1, 0, 0, 0, 0},
  {0, 1, 1, 0, 0, 0, 0},
  {1, 1, 1, 0, 0, 0, 0},
}

combat11:setArea(createCombatArea(area11))

-- combat 12
local combat12 = Combat()
combat12:setParameter(COMBAT_PARAM_TYPE, COMBAT_FLYINGDAMAGE)
combat12:setParameter(COMBAT_PARAM_AGGRESSIVE, true)
combat12:setParameter(COMBAT_PARAM_EFFECT, 175)
combat12:setParameter(COMBAT_PARAM_POWER, 15)

combat12:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, onGetAttackValues)

local area12 = {
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 2, 0, 0, 0},
  {1, 1, 0, 0, 0, 0, 0},
  {1, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0},
}

combat12:setArea(createCombatArea(area12))

local combats = {
  combat2, combat3, combat4, combat5, combat6, combat7, combat8, combat9, combat10, combat11, combat12,
}

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant)
  combat:execute(creature, variant)

  for index, otherCombat in ipairs(combats) do
    addEvent(function (cid, variant)
      local creature = Creature(cid)

      if not creature then
        return
      end

      otherCombat:execute(creature, variant)
    end, index * 150, creature:getId(), variant)
  end
  return true
end

spell:name("Whirlwind")
spell:words("whirlwind")
spell:register()
