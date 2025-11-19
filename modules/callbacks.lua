local m_onLoginArgs = { }
function onLogin(player)
  m_onLoginArgs.creature = player
  return Signal.emit("onLogin", m_onLoginArgs)
end

local m_onLogoutArgs = { }
function onLogout(player)
  m_onLogoutArgs.creature = player
  return Signal.emit("onLogout", m_onLogoutArgs)
end

local m_onThinkArgs = { }
function onThink(creature, interval)
  m_onThinkArgs.creature = creature
  m_onThinkArgs.interval = interval

  Signal.emit("onThink", m_onThinkArgs)
  if creature:isPokemon() then
    Signal.emit("onPokemonThink", m_onThinkArgs)
  end
end

local m_onPrepareDeathArgs = { }
function onPrepareDeath(creature, killer)
  m_onPrepareDeathArgs.creature = creature
  m_onPrepareDeathArgs.killer = killer
  Signal.emit("onPrepareDeath", m_onPrepareDeathArgs)
  return true
end

local m_onDeathArgs = { }
function onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
  m_onDeathArgs.creature = creature
  m_onDeathArgs.corpse = corpse
  m_onDeathArgs.killer = killer
  m_onDeathArgs.mostDamageKiller = mostDamageKiller
  m_onDeathArgs.lastHitUnjustified = lastHitUnjustified
  m_onDeathArgs.mostDamageUnjustified = mostDamageUnjustified
  Signal.emit("onDeath", m_onDeathArgs)
  return true
end

local m_onKillArgs = { }
function onKill(creature, target)
  m_onKillArgs.creature = creature
  m_onKillArgs.target = target
  Signal.emit("onKill", m_onKillArgs)
end

local m_onAdvanceArgs = { }
function onAdvance(player, skill, oldLevel, newLevel)
  m_onAdvanceArgs.creature = player
  m_onAdvanceArgs.skill = skill
  m_onAdvanceArgs.oldLevel = oldLevel
  m_onAdvanceArgs.newLevel = newLevel
  Signal.emit("onAdvance", m_onAdvanceArgs)
end

local m_onModalWindowArgs = { }
function onModalWindow(player, modalWindowId, buttonId, choiceId)
  m_onModalWindowArgs.creature = player
  m_onModalWindowArgs.modalWindowId = modalWindowId
  m_onModalWindowArgs.buttonId = buttonId
  m_onModalWindowArgs.choiceId = choiceId
  Signal.emit("onModalWindow", m_onModalWindowArgs)
end

local m_onTextEditArgs = { }
function onTextEdit(player, item, text)
  m_onTextEditArgs.creature = player
  m_onTextEditArgs.item = item
  m_onTextEditArgs.text = text
  return Signal.emit("onTextEdit", m_onTextEditArgs)
end

local m_onHealthChangeArgs = { }
function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
  m_onHealthChangeArgs.creature = creature
  m_onHealthChangeArgs.attacker = attacker
  m_onHealthChangeArgs.primaryDamage = primaryDamage
  m_onHealthChangeArgs.primaryType = primaryType
  m_onHealthChangeArgs.secondaryDamage = secondaryDamage
  m_onHealthChangeArgs.secondaryType = secondaryType
  m_onHealthChangeArgs.origin = origin
  Signal.emit("onHealthChange", m_onHealthChangeArgs)
  return primaryDamage, primaryType, secondaryDamage, secondaryType
end

local m_onExtendedOpcodeArgs = { }
function onExtendedOpcode(player, opcode, buffer)
  m_onExtendedOpcodeArgs.creature = player
  m_onExtendedOpcodeArgs.opcode = opcode
  m_onExtendedOpcodeArgs.buffer = buffer
  return Signal.emit("onExtendedOpcode", m_onExtendedOpcodeArgs)
end

local m_onLookArgs = { }
function onLook(player, thing, position, distance)
  m_onLookArgs.creature = player
  m_onLookArgs.thing = thing
  m_onLookArgs.position = position
  m_onLookArgs.distance = distance
  Signal.emit("onLook", m_onLookArgs)
end

local m_onAppearArgs = { }
function onAppear(player, target)
  m_onAppearArgs.creature = player
  m_onAppearArgs.target = target
  Signal.emit("onAppear", m_onAppearArgs)
end

local m_onDisappearArgs = { }
function onDisappear(player, target)
  m_onDisappearArgs.creature = player
  m_onDisappearArgs.target = target
  Signal.emit("onDisappear", m_onDisappearArgs)
end

local m_onSayArgs = { }
function onSay(creature, speakType, text)
  m_onSayArgs.creature = creature
  m_onSayArgs.speakType = speakType
  m_onSayArgs.text = text
  Signal.emit("onSay", m_onSayArgs, text)
  Signal.emit("onSay", m_onSayArgs)
end

local m_onUseItemArgs = { }
function onUseItem(player, item, fromPosition, target, toPosition)
  m_onUseItemArgs.creature = player
  m_onUseItemArgs.item = item
  m_onUseItemArgs.fromPosition = fromPosition
  m_onUseItemArgs.target = target
  m_onUseItemArgs.toPosition = toPosition
  return Signal.emit("onUseItemId", m_onUseItemArgs, item:getId()) or Signal.emit("onUseItem", m_onUseItemArgs)
end

local m_onWalkArgs = { }
function onWalk(creature, newTile, newPos, oldTile, oldPos, teleport)
  m_onWalkArgs.creature = creature
  m_onWalkArgs.newTile = newTile
  m_onWalkArgs.newPos = newPos
  m_onWalkArgs.oldTile = oldTile
  m_onWalkArgs.oldPos = oldPos
  m_onWalkArgs.teleport = teleport
  Signal.emit("onWalk", m_onWalkArgs)
end

local m_canWalkArgs = { }
function canWalk(creature)
  m_canWalkArgs.creature = creature
  return Signal.emit("canWalk", m_canWalkArgs)
end

local m_onPokemonLevelUpArgs = { }
function onPokemonLevelUp(pokemon, oldLevel, newLevel, experience)
  m_onPokemonLevelUpArgs.pokemon = pokemon
  m_onPokemonLevelUpArgs.oldLevel = oldLevel
  m_onPokemonLevelUpArgs.newLevel = newLevel
  m_onPokemonLevelUpArgs.experience = experience
  Signal.emit("onPokemonLevelUp", m_onPokemonLevelUpArgs)
end

local m_onPokemonFinishedOrder = { }
function onPokemonFinishedOrder(pokemon, position)
  m_onPokemonFinishedOrder.pokemon = pokemon
  m_onPokemonFinishedOrder.position = position
  return Signal.emit("onPokemonFinishedOrder", m_onPokemonFinishedOrder)
end

ModuleManager.loadModules()
ModuleManager.reloadEvent()
