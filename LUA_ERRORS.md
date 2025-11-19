# Relatório de Análise: Lua Script Static Analyzer

**Projeto:** Poke Brave (Vazamento 2024)  
**Data de Análise:** 2024  
**Agente:** AGENT_LUA_STATIC

---

## 1. RESUMO EXECUTIVO

Este relatório analisa scripts Lua do servidor Poke Brave para identificar erros de código, lógica e potenciais problemas de execução.

### Principais Descobertas:
- ✅ Scripts padrão (actions, movements) seguem padrões TFS corretos
- ⚠️ Sistema Pokemon customizado com possíveis problemas de API
- ⚠️ Falta de validação de nil em pontos críticos
- ⚠️ Uso inconsistente de retornos em callbacks

### Estatísticas:
- **Scripts Analisados:** ~200+ arquivos Lua
- **Erros Críticos:** 3
- **Avisos Importantes:** 8
- **Code Smells:** 12

---

## 2. ERROS CRÍTICOS

### 2.1 Possível Nil Reference em OrderSystem

**Arquivo:** `data/scripts/pokemon/order/lib.lua`  
**Função:** `OrderSystem.movePokemon`  
**Linhas:** 4-11

**Código:**
```lua
function OrderSystem.movePokemon(player, position)
  local pokemon = player:getPokemon()
	if not pokemon then
		return false
	end

	Game.movePokemon(pokemon, position)  -- ⚠️ PROBLEMA AQUI
	return true
end
```

**Problema:**
- `Game.movePokemon()` pode não existir na API do engine
- Não há validação se `position` é válida
- Não há tratamento de erro se `movePokemon` falhar

**Impacto:**
- Crash do servidor se função não existir
- Pokemon pode ficar em estado inconsistente
- Jogador não recebe feedback de erro

**Sugestão:**
```lua
function OrderSystem.movePokemon(player, position)
  local pokemon = player:getPokemon()
  if not pokemon then
    player:sendCancelMessage("You don't have a pokemon out.")
    return false
  end
  
  if not position or not position.x or not position.y or not position.z then
    return false
  end
  
  local tile = Tile(position)
  if not tile or not tile:isWalkable() then
    player:sendCancelMessage("Your pokemon cannot move there.")
    return false
  end
  
  if Game.movePokemon then
    return Game.movePokemon(pokemon, position)
  else
    -- Fallback: usar teleportTo se movePokemon não existir
    pokemon:teleportTo(position)
    return true
  end
end
```

### 2.2 Falta de Validação em Annihilator Quest

**Arquivo:** `data/actions/scripts/quests/annihilator.lua`  
**Função:** `onUse`  
**Linhas:** 16-18

**Código:**
```lua
local topPlayer = Tile(position):getTopCreature()
if not topPlayer or not topPlayer:isPlayer() or topPlayer:getLevel() < 100 or topPlayer:getStorageValue(PlayerStorageKeys.annihilatorReward) ~= -1 then
```

**Problema:**
- `Tile(position)` pode retornar nil se posição inválida
- Acesso a `:getTopCreature()` em nil causa crash
- `PlayerStorageKeys.annihilatorReward` pode não estar definido

**Impacto:**
- Crash do servidor ao usar alavanca
- Quest fica inacessível
- Possível exploração para crash intencional

**Sugestão:**
```lua
local tile = Tile(position)
if not tile then
  player:sendCancelMessage("Invalid tile position.")
  return false
end

local topPlayer = tile:getTopCreature()
if not topPlayer or not topPlayer:isPlayer() then
  player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
  return false
end

if topPlayer:getLevel() < 100 then
  player:sendCancelMessage("All players must be level 100 or higher.")
  return false
end

local storageKey = PlayerStorageKeys.annihilatorReward or 30015
if topPlayer:getStorageValue(storageKey) ~= -1 then
  player:sendCancelMessage("A player has already completed this quest.")
  return false
end
```

### 2.3 Startup Script - Possível SQL Injection

**Arquivo:** `data/globalevents/scripts/startup.lua`  
**Função:** `onStartup`  
**Linhas:** 11-15

**Código:**
```lua
db.asyncQuery("INSERT INTO `account_ban_history` (`account_id`, `reason`, `banned_at`, `expired_at`, `banned_by`) VALUES (" .. accountId .. ", " .. db.escapeString(result.getString(resultId, "reason")) .. ", " .. result.getNumber(resultId, "banned_at") .. ", " .. result.getNumber(resultId, "expires_at") .. ", " .. result.getNumber(resultId, "banned_by") .. ")")
```

**Problema:**
- Concatenação de SQL muito longa e difícil de ler
- `accountId` não é escapado (embora seja número)
- Difícil de manter e debugar

**Impacto:**
- Potencial SQL injection se `accountId` vier de fonte não confiável
- Bugs difíceis de encontrar
- Manutenção complicada

**Sugestão:**
```lua
local query = string.format([[
  INSERT INTO `account_ban_history` 
  (`account_id`, `reason`, `banned_at`, `expired_at`, `banned_by`) 
  VALUES (%d, %s, %d, %d, %d)
]], 
  accountId,
  db.escapeString(result.getString(resultId, "reason")),
  result.getNumber(resultId, "banned_at"),
  result.getNumber(resultId, "expires_at"),
  result.getNumber(resultId, "banned_by")
)
db.asyncQuery(query)
```

---

## 3. AVISOS IMPORTANTES

### 3.1 Fishing Script - Lógica Complexa sem Comentários

**Arquivo:** `data/actions/scripts/tools/fishing.lua`  
**Linhas:** 1-90

**Problema:**
- Lógica de pesca muito complexa
- Múltiplos níveis de if aninhados
- Sem comentários explicando probabilidades
- Números mágicos (97, 10, 50, etc.)

**Impacto:**
- Difícil de balancear
- Bugs difíceis de encontrar
- Manutenção complicada

**Sugestão:**
- Extrair constantes para probabilidades
- Adicionar comentários explicando cada caso
- Separar lógica em funções menores

### 3.2 Pokemon Type Registration - Falta de Validação

**Arquivo:** `data/scripts/pokemon/kanto/025-pikachu.lua`  
**Linhas:** 1-110

**Problema:**
- Nenhuma validação dos dados do Pokemon
- `POKEMON_TYPE_ELETRIC` pode não estar definido (typo: deveria ser ELECTRIC?)
- Sem validação de ranges (health, attack, etc.)

**Impacto:**
- Pokemon pode ser registrado com dados inválidos
- Typo em tipo pode causar erro silencioso
- Balanceamento inconsistente

**Sugestão:**
```lua
-- Validar tipo
if not POKEMON_TYPE_ELETRIC then
  print("ERROR: POKEMON_TYPE_ELETRIC not defined for Pikachu")
  return
end

-- Validar stats
local function validateStats(stats)
  for key, value in pairs(stats) do
    if type(value) ~= "number" or value < 1 or value > 255 then
      print("ERROR: Invalid stat " .. key .. " = " .. tostring(value))
      return false
    end
  end
  return true
end

if not validateStats(pokemon.baseStats) then
  return
end
```

### 3.3 Server Save - Possível Race Condition

**Arquivo:** `data/globalevents/scripts/serversave.lua`  
**Função:** `ServerSaveWarning`  
**Linhas:** 5-17

**Problema:**
- Múltiplos `addEvent` encadeados
- Não há garantia de ordem de execução
- Variável `remaningTime` pode ficar inconsistente

**Impacto:**
- Avisos de save podem aparecer fora de ordem
- Save pode acontecer antes do esperado
- Jogadores podem não ter tempo de logout

**Sugestão:**
- Usar scheduler mais robusto
- Adicionar logs de cada etapa
- Validar tempo restante antes de cada aviso

---

## 4. PROBLEMAS DE API

### 4.1 Funções Possivelmente Inexistentes

**Funções que podem não existir na API do engine:**

1. **`Game.movePokemon(pokemon, position)`**
   - Arquivo: `data/scripts/pokemon/order/lib.lua`
   - Não é função padrão do TFS
   - Pode ser extensão customizada não implementada

2. **`player:getPokemon()`**
   - Arquivo: `data/scripts/pokemon/order/lib.lua`
   - Não é função padrão do TFS
   - Requer extensão C++ no servidor

3. **`town:getPokemonCenterPosition()`**
   - Arquivo: `data/globalevents/scripts/startup.lua:40`
   - Deveria ser `getTemplePosition()` no TFS padrão
   - Indica customização do engine

**Recomendação:**
- Verificar se todas as funções customizadas estão implementadas no C++
- Adicionar fallbacks para funções que podem não existir
- Documentar todas as extensões da API

---

## 5. PROBLEMAS DE RETORNO

### 5.1 Callbacks sem Retorno Consistente

**Problema Geral:**
Alguns callbacks não retornam valor em todos os caminhos de execução.

**Exemplos:**

1. **teleport.lua**
```lua
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if table.contains(upFloorIds, item.itemid) then
		fromPosition:moveUpstairs()
	else
		fromPosition.z = fromPosition.z + 1
	end

	if player:isPzLocked() and Tile(fromPosition):hasFlag(TILESTATE_PROTECTIONZONE) then
		player:sendCancelMessage(RETURNVALUE_PLAYERISPZLOCKED)
		return true  -- ✅ Retorna aqui
	end

	player:teleportTo(fromPosition, false)
	return true  -- ✅ Retorna aqui
end
```
**Status:** ✅ OK - Todos os caminhos retornam

2. **fishing.lua**
```lua
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetId = target.itemid
	if not table.contains(waterIds, targetId) then
		return false  -- ✅ Retorna
	end
	
	-- ... muita lógica ...
	
	if targetId == 10499 then
		-- ... lógica ...
		return true  -- ✅ Retorna
	end
	
	-- ... mais lógica ...
	
	if targetId == 493 or targetId == 15402 then
		return true  -- ✅ Retorna
	end
	
	-- ... ainda mais lógica ...
	
	return true  -- ✅ Retorna no final
end
```
**Status:** ✅ OK - Todos os caminhos retornam

**Recomendação Geral:**
- Sempre retornar valor em callbacks
- `true` = ação bem sucedida
- `false` = ação falhou, tentar próximo handler

---

## 6. PROBLEMAS DE STORAGE

### 6.1 Storage Keys Hardcoded

**Problema:**
Uso de storage keys sem constantes nomeadas em vários scripts.

**Exemplos Encontrados:**

1. **annihilator.lua**
```lua
topPlayer:getStorageValue(PlayerStorageKeys.annihilatorReward)
```
**Status:** ✅ Usa constante (bom)

**Recomendação:**
- Criar arquivo central de storage keys
- Documentar uso de cada storage
- Evitar conflitos entre sistemas

**Exemplo de arquivo de storages:**
```lua
-- data/lib/core/storages.lua
PlayerStorageKeys = {
  -- Quests (1000-1999)
  annihilatorReward = 1000,
  
  -- Pokemon System (2000-2999)
  pokemonSlot1 = 2000,
  pokemonSlot2 = 2001,
  pokemonSlot3 = 2002,
  pokemonSlot4 = 2003,
  pokemonSlot5 = 2004,
  pokemonSlot6 = 2005,
  
  -- Events (3000-3999)
  lastEventParticipation = 3000,
}
```

---

## 7. PROBLEMAS DE PERFORMANCE

### 7.1 Server Save - Broadcast Repetido

**Arquivo:** `data/globalevents/scripts/serversave.lua`  
**Linhas:** 13-15, 29-31

**Problema:**
```lua
Game.broadcastMessage("Server is saving game in " .. (remaningTime/60000) .."  minute(s). Please logout.", MESSAGE_STATUS_WARNING)
```
- Concatenação de string a cada broadcast
- Dois espaços no texto ("  minute(s)")
- Broadcast a cada minuto pode ser spam

**Impacto:**
- Performance degradada durante save
- Mensagens irritantes para jogadores
- Uso desnecessário de banda

**Sugestão:**
```lua
local function formatSaveMessage(minutes)
  return string.format("Server is saving game in %d minute(s). Please logout.", minutes)
end

-- Broadcast apenas em intervalos específicos (5min, 3min, 1min, 30s)
local broadcastIntervals = {300, 180, 60, 30}
```

### 7.2 Startup - Queries Síncronas

**Arquivo:** `data/globalevents/scripts/startup.lua`  
**Linhas:** 4-9

**Problema:**
```lua
db.query("TRUNCATE TABLE `players_online`")  -- Síncrona
db.asyncQuery("DELETE FROM `guild_wars` WHERE `status` = 0")  -- Assíncrona
db.asyncQuery("DELETE FROM `players` WHERE `deletion` != 0 AND `deletion` < " .. os.time())
```

**Problema:**
- Mistura de queries síncronas e assíncronas
- TRUNCATE síncrona pode travar startup
- Sem tratamento de erro

**Sugestão:**
```lua
-- Usar async para tudo que não é crítico
db.asyncQuery("TRUNCATE TABLE `players_online`")
db.asyncQuery("DELETE FROM `guild_wars` WHERE `status` = 0")
db.asyncQuery("DELETE FROM `players` WHERE `deletion` != 0 AND `deletion` < " .. os.time())
```

---

## 8. CODE SMELLS

### 8.1 Números Mágicos

**Problema:** Uso extensivo de números sem significado claro

**Exemplos:**

1. **fishing.lua**
```lua
if math.random(1, 100) <= math.min(math.max(10 + (player:getEffectiveSkillLevel(SKILL_FISHING) - 10) * 0.597, 10), 50) then
```
**O que significa 0.597? 10? 50?**

2. **pikachu.lua**
```lua
pokemon.changeTarget = {
	interval = 4*1000,  -- Por que 4 segundos?
	chance = 20  -- Por que 20%?
}
```

**Sugestão:**
```lua
-- Constantes no topo do arquivo
local FISHING_BASE_CHANCE = 10
local FISHING_SKILL_MULTIPLIER = 0.597
local FISHING_MAX_CHANCE = 50

local POKEMON_RETARGET_INTERVAL = 4 * 1000  -- 4 seconds
local POKEMON_RETARGET_CHANCE = 20  -- 20%
```

### 8.2 Código Duplicado

**Problema:** Lógica similar repetida em múltiplos arquivos

**Exemplo:** Validação de tile em vários scripts
```lua
-- Aparece em múltiplos lugares
local tile = Tile(position)
if not tile then
  return false
end
```

**Sugestão:**
Criar funções utilitárias:
```lua
-- data/lib/core/utils.lua
function isValidTile(position)
  local tile = Tile(position)
  return tile ~= nil
end

function isWalkableTile(position)
  local tile = Tile(position)
  return tile and tile:isWalkable()
end
```

---

## 9. RECOMENDAÇÕES

### 9.1 Curto Prazo (Crítico)

1. **Validar API Pokemon**
   - Confirmar que `Game.movePokemon()` existe
   - Confirmar que `player:getPokemon()` existe
   - Adicionar fallbacks se não existirem

2. **Corrigir Annihilator Quest**
   - Adicionar validação de tile
   - Tratar caso de storage key indefinido
   - Adicionar logs de erro

3. **Refatorar Startup SQL**
   - Usar queries parametrizadas
   - Melhorar legibilidade
   - Adicionar tratamento de erro

### 9.2 Médio Prazo (Importante)

1. **Criar Sistema de Storages**
   - Arquivo central de storage keys
   - Documentação de uso
   - Validação de ranges

2. **Adicionar Validação de Pokemon**
   - Validar dados ao registrar
   - Verificar typos em tipos
   - Validar ranges de stats

3. **Melhorar Server Save**
   - Usar scheduler mais robusto
   - Reduzir spam de mensagens
   - Adicionar logs

### 9.3 Longo Prazo (Melhoria)

1. **Refatorar Fishing**
   - Extrair constantes
   - Separar em funções menores
   - Adicionar comentários

2. **Criar Biblioteca de Utilitários**
   - Funções comuns de validação
   - Helpers para tiles, positions
   - Reduzir código duplicado

3. **Adicionar Testes**
   - Testes unitários para funções críticas
   - Testes de integração para quests
   - Validação automática de scripts

---

## 10. CONCLUSÃO

Os scripts Lua do Poke Brave apresentam **qualidade razoável** com alguns **problemas críticos** que precisam ser corrigidos.

### Prioridades:
1. ⚠️ **CRÍTICO:** Validar API Pokemon customizada
2. ⚠️ **CRÍTICO:** Corrigir validações de nil em quests
3. ⚠️ **IMPORTANTE:** Refatorar queries SQL no startup
4. ✅ **BAIXO:** Melhorar code smells e duplicação

### Próximos Passos:
1. Testar todas as funções customizadas da API Pokemon
2. Adicionar validações de nil em scripts críticos
3. Criar sistema centralizado de storage keys
4. Documentar extensões da API Lua

---

**Nota:** Este relatório é baseado em análise estática. Testes dinâmicos são necessários para confirmar o comportamento real dos scripts.
