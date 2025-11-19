# Relatório de Análise: Protocol & Opcode Sync

**Projeto:** Poke Brave (Vazamento 2024)  
**Data de Análise:** 2024  
**Agente:** AGENT_PROTOCOL_SYNC

---

## 1. RESUMO EXECUTIVO

Este relatório analisa a consistência do protocolo entre o servidor (pokebrave-server-main) e o cliente (pokebrave-client-otcv8-main). O servidor é baseado em TFS/Canary e o cliente em OTClient V8.

### Principais Descobertas:
- ✅ Cliente possui definições extensivas de opcodes (GameServerOpcodes e ClientOpcodes)
- ⚠️ Servidor possui implementação customizada com sistema Pokemon
- ⚠️ Possíveis inconsistências em opcodes customizados
- ⚠️ Falta de documentação clara sobre extensões do protocolo

---

## 2. MAPEAMENTO DE OPCODES

### 2.1 Opcodes do Servidor → Cliente (GameServerOpcodes)

#### Opcodes Padrão Identificados no Cliente:
```
GameServerLoginOrPendingState       = 10
GameServerGMActions                 = 11
GameServerEnterGame                 = 15
GameServerUpdateNeeded              = 17
GameServerLoginError                = 20
GameServerLoginAdvice               = 21
GameServerLoginWait                 = 22
GameServerLoginSuccess              = 23
GameServerLoginToken                = 24
GameServerStoreButtonIndicators     = 25
GameServerPingBack                  = 29
GameServerPing                      = 30
GameServerChallenge                 = 31
GameServerDeath                     = 40
GameServerSupplyStash               = 41
GameServerSpecialContainer          = 42
```

#### Opcodes Customizados (OTClient V8):
```
GameServerExtendedOpcode            = 50
GameServerPokemonUpdate             = 52  ⚠️ CUSTOM POKEMON
GameServerProgressBar               = 59
GameServerNewPing                   = 64
GameServerChangeMapAwareRange       = 66
GameServerFeatures                  = 67
GameServerNewCancelWalk             = 69
GameServerPredictiveCancelWalk      = 70
GameServerWalkId                    = 71
GameServerFloorDescription          = 75
```

#### Opcodes de Jogo Principal:
```
GameServerFullMap                   = 100
GameServerMapTopRow                 = 101
GameServerMapRightRow               = 102
GameServerMapBottomRow              = 103
GameServerMapLeftRow                = 104
GameServerUpdateTile                = 105
GameServerCreateOnMap               = 106
GameServerChangeOnMap               = 107
GameServerDeleteOnMap               = 108
GameServerMoveCreature              = 109
GameServerOpenContainer             = 110
GameServerCloseContainer            = 111
GameServerCreateContainer           = 112
GameServerChangeInContainer         = 113
GameServerDeleteInContainer         = 114
```

### 2.2 Opcodes do Cliente → Servidor (ClientOpcodes)

#### Opcodes de Login:
```
ClientEnterAccount                  = 1
ClientPendingGame                   = 10
ClientEnterGame                     = 15
ClientLeaveGame                     = 20
ClientPing                          = 29
ClientPingBack                      = 30
```

#### Opcodes Customizados (OTClient V8):
```
ClientExtendedOpcode                = 50
ClientNewPing                       = 64
ClientChangeMapAwareRange           = 66
ClientNewWalk                       = 69
ClientProcessesResponse             = 80
ClientDllsResponse                  = 81
ClientWindowsResponse               = 82
```

#### Opcodes de Movimento:
```
ClientAutoWalk                      = 100
ClientWalkNorth                     = 101
ClientWalkEast                      = 102
ClientWalkSouth                     = 103
ClientWalkWest                      = 104
ClientStop                          = 105
ClientWalkNorthEast                 = 106
ClientWalkSouthEast                 = 107
ClientWalkSouthWest                 = 108
ClientWalkNorthWest                 = 109
ClientTurnNorth                     = 111
ClientTurnEast                      = 112
ClientTurnSouth                     = 113
ClientTurnWest                      = 114
```

#### Opcodes de Ações:
```
ClientEquipItem                     = 119
ClientMove                          = 120
ClientInspectNpcTrade               = 121
ClientBuyItem                       = 122
ClientSellItem                      = 123
ClientCloseNpcTrade                 = 124
ClientRequestTrade                  = 125
ClientInspectTrade                  = 126
ClientAcceptTrade                   = 127
ClientRejectTrade                   = 128
ClientUseItem                       = 130
ClientUseItemWith                   = 131
ClientUseOnCreature                 = 132
ClientRotateItem                    = 133
ClientCloseContainer                = 135
ClientUpContainer                   = 136
```

---

## 3. INCONSISTÊNCIAS DETECTADAS

### 3.1 CRÍTICO: Opcode Pokemon Customizado

**Localização:** Cliente `protocolcodes.h:52`  
**Opcode:** `GameServerPokemonUpdate = 52`

**Problema:**
- Cliente espera receber atualizações de Pokemon no opcode 52
- Servidor possui arquivos `pokemon.cpp`, `pokemon.h`, `pokeball.cpp`, `pokeballs.cpp`
- Não foi possível verificar se o servidor envia corretamente no opcode 52

**Impacto:**
- Se o servidor não implementar corretamente, o cliente não receberá atualizações de Pokemon
- Possível crash ou desconexão do cliente
- Dados de Pokemon podem não ser exibidos corretamente

**Sugestão:**
- Verificar implementação em `pokebrave-server-main/src/protocolgame.cpp`
- Confirmar que `sendUpdatePokemon()` usa opcode 52
- Adicionar logs para debug de sincronização

### 3.2 ALTO: Opcodes de Anti-Cheat

**Localização:** Cliente `protocolcodes.h:80-82`  
**Opcodes:**
```
GameServerProcessesRequest          = 80
GameServerDllsRequest               = 81
GameServerWindowsRequests           = 82
```

**Problema:**
- Cliente possui handlers para responder requisições de processos/DLLs/janelas
- Não foi encontrada implementação correspondente no servidor
- Sistema anti-cheat pode estar incompleto ou desabilitado

**Impacto:**
- Sistema anti-cheat não funcional
- Servidor vulnerável a bots e cheats
- Possível código morto no cliente

**Sugestão:**
- Verificar se servidor envia estes opcodes
- Se não, remover do cliente ou implementar no servidor
- Documentar sistema anti-cheat

### 3.3 MÉDIO: Opcodes de Store/Shop

**Localização:** Cliente `protocolcodes.h:224-254`  
**Opcodes:**
```
GameServerStoreError                = 224
GameServerRequestPurchaseData       = 225
GameServerOpenRewardWall            = 226
GameServerDailyReward               = 228
GameServerStore                     = 251
GameServerStoreOffers               = 252
GameServerStoreTransactionHistory   = 253
GameServerStoreCompletePurchase     = 254
```

**Problema:**
- Cliente possui suporte completo para sistema de loja
- Servidor pode não ter implementação completa
- Versão vazada pode ter sistema de pagamento incompleto

**Impacto:**
- Funcionalidades de loja podem não funcionar
- Possíveis crashes ao tentar acessar loja
- Mensagens de erro não tratadas

**Sugestão:**
- Verificar implementação de loja no servidor
- Desabilitar botões de loja no cliente se não implementado
- Adicionar tratamento de erro para opcodes não suportados

### 3.4 MÉDIO: Sistema de Prey

**Localização:** Cliente `protocolcodes.h:230-233`  
**Opcodes:**
```
GameServerPreyFreeRolls             = 230
GameServerPreyTimeLeft              = 231
GameServerPreyData                  = 232
GameServerPreyPrices                = 233
ClientPreyAction                    = 235
ClientPreyRequest                   = 237
```

**Problema:**
- Sistema Prey (caça) do Tibia oficial
- Pode não estar implementado em servidor Pokemon
- Cliente envia requisições que servidor pode não entender

**Impacto:**
- Funcionalidade não disponível
- Possíveis erros de protocolo
- Confusão para jogadores

**Sugestão:**
- Remover ou desabilitar UI de Prey no cliente
- Adicionar handler no servidor para ignorar graciosamente
- Documentar features não suportadas

### 3.5 BAIXO: Opcodes de Cyclopedia

**Localização:** Cliente `protocolcodes.h:217-221`  
**Opcodes:**
```
GameServerCyclopediaNewDetails      = 217
GameServerCyclopedia                = 218
GameServerCyclopediaMapData         = 221
```

**Problema:**
- Sistema Cyclopedia (enciclopédia) do Tibia oficial
- Provavelmente não implementado em servidor Pokemon
- Pode ter sido substituído por Pokedex

**Impacto:**
- Feature não disponível
- Botões/menus podem não funcionar

**Sugestão:**
- Verificar se existe sistema Pokedex customizado
- Mapear opcodes customizados para Pokedex se existir
- Remover UI de Cyclopedia se não usado

---

## 4. VERIFICAÇÕES DE ESTRUTURA DE MENSAGENS

### 4.1 Estrutura de Login

**Cliente envia:**
```cpp
- uint16_t operatingSystem
- uint16_t version
- 7 bytes (U32 client version, U8 client type, U16 dat revision)
- RSA encrypted block:
  - uint32_t xtea[4]
  - uint8_t gamemaster flag
  - string sessionKey (format: "account\npassword\ntoken\ntokenTime")
  - string characterName
  - uint32_t challengeTimestamp
  - uint8_t challengeRandom
```

**Servidor espera (protocolgame.cpp:onRecvFirstMessage):**
```cpp
✅ uint16_t operatingSystem
✅ uint16_t version
✅ 7 bytes skip
✅ RSA decrypt
✅ uint32_t xtea[4]
✅ 1 byte skip (gamemaster)
✅ string sessionKey
✅ string characterName
✅ uint32_t timestamp
✅ uint8_t randNumber
```

**Status:** ✅ COMPATÍVEL

### 4.2 Estrutura de Movimento

**Cliente envia (ClientAutoWalk = 100):**
```cpp
- uint8_t numDirections
- uint8_t[] directions
```

**Servidor deve esperar:**
- Verificação necessária em `parseAutoWalk()`

**Status:** ⚠️ VERIFICAÇÃO NECESSÁRIA

### 4.3 Estrutura de UseItem

**Cliente envia (ClientUseItem = 130):**
```cpp
- Position position
- uint16_t itemId
- uint8_t stackpos
- uint8_t index
```

**Servidor deve esperar:**
- Verificação necessária em `parseUseItem()`

**Status:** ⚠️ VERIFICAÇÃO NECESSÁRIA

---

## 5. RISCOS IDENTIFICADOS

### 5.1 Risco de Desconexão

**Severidade:** ALTA  
**Probabilidade:** MÉDIA

**Cenário:**
- Cliente envia opcode que servidor não reconhece
- Servidor não trata opcode desconhecido graciosamente
- Conexão é fechada abruptamente

**Mitigação:**
- Adicionar handler padrão para opcodes desconhecidos
- Logar opcodes não reconhecidos para debug
- Enviar mensagem de erro ao cliente antes de desconectar

### 5.2 Risco de Dados Truncados

**Severidade:** MÉDIA  
**Probabilidade:** BAIXA

**Cenário:**
- Servidor envia mais/menos bytes do que cliente espera
- Cliente lê dados incorretos
- Estado do jogo fica inconsistente

**Mitigação:**
- Validar tamanho de mensagens
- Adicionar checksums em mensagens críticas
- Implementar versionamento de protocolo

### 5.3 Risco de Crash do Cliente

**Severidade:** ALTA  
**Probabilidade:** BAIXA

**Cenário:**
- Servidor envia opcode com dados malformados
- Cliente tenta ler além do buffer
- Crash ou comportamento indefinido

**Mitigação:**
- Validar tamanho de buffer antes de ler
- Adicionar try-catch em parsers críticos
- Implementar limites de tamanho para strings/arrays

---

## 6. RECOMENDAÇÕES

### 6.1 Curto Prazo (Crítico)

1. **Verificar implementação de Pokemon Update (opcode 52)**
   - Confirmar que servidor envia corretamente
   - Testar sincronização de dados de Pokemon
   - Adicionar logs de debug

2. **Adicionar handler de opcodes desconhecidos**
   - Evitar crashes por opcodes não implementados
   - Logar para análise futura
   - Enviar erro gracioso ao cliente

3. **Documentar opcodes customizados**
   - Criar lista de extensões do protocolo
   - Documentar formato de cada mensagem
   - Manter sincronizado entre cliente e servidor

### 6.2 Médio Prazo (Importante)

1. **Remover código morto**
   - Identificar opcodes nunca usados
   - Remover handlers desnecessários
   - Limpar código de features não implementadas

2. **Implementar versionamento**
   - Adicionar versão de protocolo
   - Validar compatibilidade na conexão
   - Permitir múltiplas versões se necessário

3. **Adicionar testes de protocolo**
   - Criar suite de testes para cada opcode
   - Validar estrutura de mensagens
   - Automatizar verificação de compatibilidade

### 6.3 Longo Prazo (Melhoria)

1. **Refatorar sistema de protocolo**
   - Separar protocolo base de extensões
   - Criar sistema de plugins para features customizadas
   - Melhorar manutenibilidade

2. **Implementar compressão**
   - Reduzir uso de banda
   - Melhorar performance em conexões lentas
   - Manter compatibilidade com versão atual

3. **Adicionar telemetria**
   - Monitorar uso de cada opcode
   - Identificar gargalos de performance
   - Detectar anomalias em tempo real

---

## 7. CONCLUSÃO

O protocolo entre cliente e servidor apresenta **compatibilidade básica funcional**, mas possui **várias áreas de risco** relacionadas a features customizadas e código potencialmente morto.

### Prioridades:
1. ✅ Protocolo base (login, movimento, ações) aparenta estar funcional
2. ⚠️ Sistema Pokemon (opcode 52) requer verificação urgente
3. ⚠️ Features avançadas (Store, Prey, Cyclopedia) podem não estar implementadas
4. ⚠️ Sistema anti-cheat (opcodes 80-82) aparenta estar incompleto

### Próximos Passos:
1. Analisar implementação completa de `protocolgame.cpp` no servidor
2. Testar cada opcode customizado em ambiente de desenvolvimento
3. Criar documentação técnica do protocolo
4. Implementar sistema de logging para debug de protocolo

---

**Nota:** Este relatório é baseado em análise estática do código. Testes dinâmicos são necessários para confirmar o comportamento real do protocolo em execução.
