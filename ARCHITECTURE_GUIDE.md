# Guia de Arquitetura: OTServer / Poke Brave

**Projeto:** Poke Brave (Baseado em TFS/Canary)  
**Data:** 2024  
**Agente:** AGENT_ARCHITECTURE_DOC  
**Público:** Desenvolvedores iniciantes e estudantes

---

## 1. INTRODUÇÃO

Este guia explica como funciona um servidor OTServer (Open Tibia Server) internamente, usando o Poke Brave como exemplo. O objetivo é ajudar iniciantes a entenderem a arquitetura e começarem a contribuir.

### 1.1. O que é um OTServer?

Um OTServer é um servidor de jogo MMORPG 2D que simula o funcionamento de jogos como Tibia. Ele gerencia:
- Conexões de múltiplos jogadores
- Mundo do jogo (mapa, criaturas, items)
- Combate e interações
- Persistência de dados (database)
- Scripts customizáveis (Lua)

### 1.2. Tecnologias Principais

- **C++17**: Core do servidor (performance crítica)
- **Lua 5.1+**: Scripts de gameplay (flexibilidade)
- **MySQL/MariaDB**: Persistência de dados
- **Boost.Asio**: Network e async I/O
- **pugixml**: Parsing de XML
- **CMake**: Build system

---

## 2. VISÃO GERAL DA ARQUITETURA

```
┌─────────────────────────────────────────────────────────────┐
│                        CLIENTE                               │
│                    (OTClient / OTCv8)                        │
└────────────────────┬────────────────────────────────────────┘
                     │ TCP/IP (Protocolo Binário)
                     ▼
┌─────────────────────────────────────────────────────────────┐
│                    NETWORK LAYER                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │ProtocolLogin │  │ProtocolGame  │  │ProtocolStatus│      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│         │                  │                  │              │
│         └──────────────────┴──────────────────┘              │
│                           │                                  │
└───────────────────────────┼──────────────────────────────────┘
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                      GAME LAYER                              │
│  ┌────────────────────────────────────────────────────────┐ │
│  │                    Game (Core)                         │ │
│  │  - Gerencia mundo, criaturas, items                   │ │
│  │  - Processa ações dos jogadores                       │ │
│  │  - Executa game loop (ticks)                          │ │
│  └────────────────────────────────────────────────────────┘ │
│                            │                                 │
│         ┌──────────────────┼──────────────────┐             │
│         ▼                  ▼                  ▼             │
│  ┌──────────┐      ┌──────────┐      ┌──────────┐          │
│  │   Map    │      │Creatures │      │  Items   │          │
│  │  Tiles   │      │ Players  │      │Container │          │
│  │  Spawns  │      │ Pokemons │      │ Weapons  │          │
│  └──────────┘      └──────────┘      └──────────┘          │
└───────────────────────────┼──────────────────────────────────┘
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                     SCRIPT LAYER                             │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │ Actions  │  │  Spells  │  │Movements │  │TalkActions│   │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘   │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐                  │
│  │  Events  │  │GlobalEvts│  │  Modules │                  │
│  └──────────┘  └──────────┘  └──────────┘                  │
└───────────────────────────┼──────────────────────────────────┘
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                      DATA LAYER                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Database   │  │     XML      │  │   Config     │      │
│  │   (MySQL)    │  │  (Items,     │  │  (config.lua)│      │
│  │              │  │   Monsters)  │  │              │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
```

---

## 3. ESTRUTURA DE DIRETÓRIOS

### 3.1. Raiz do Servidor (`pokebrave-server-main/`)

```
pokebrave-server-main/
├── src/                    # Código-fonte C++ (core do servidor)
├── data/                   # Scripts Lua e dados de jogo
├── cmake/                  # Arquivos de build CMake
├── vc17/                   # Projeto Visual Studio 2022
├── config.lua.dist         # Configuração do servidor (template)
├── schema.sql              # Schema do banco de dados
├── CMakeLists.txt          # Build configuration
└── LICENSE                 # Licença GPL-2.0
```

### 3.2. Código Fonte (`src/`)

Organizado por responsabilidade:

#### **Core do Jogo**
- `game.cpp/h` - Classe principal, gerencia todo o mundo
- `map.cpp/h` - Mapa do jogo, tiles, pathfinding
- `tile.cpp/h` - Tile individual do mapa
- `position.cpp/h` - Sistema de coordenadas (x, y, z)

#### **Entidades**
- `creature.cpp/h` - Classe base para todas as criaturas
- `player.cpp/h` - Jogador (herda de Creature)
- `pokemon.cpp/h` - Pokémon (herda de Creature)
- `npc.cpp/h` - NPC (herda de Creature)

#### **Items e Containers**
- `item.cpp/h` - Item individual
- `items.cpp/h` - Gerenciador de tipos de items
- `container.cpp/h` - Container (bag, box, etc.)
- `cylinder.cpp/h` - Interface para objetos que contêm things

#### **Network**
- `server.cpp/h` - Servidor TCP/IP
- `connection.cpp/h` - Conexão individual
- `protocol*.cpp/h` - Protocolos (login, game, status)
- `networkmessage.cpp/h` - Serialização de mensagens

#### **Database**
- `database.cpp/h` - Interface com MySQL
- `databasetasks.cpp/h` - Tasks assíncronas de DB
- `io*.cpp/h` - Input/Output (login, map, market, etc.)

#### **Scripts**
- `luascript.cpp/h` - Bridge C++ ↔ Lua
- `actions.cpp/h` - Sistema de actions (usar items)
- `spells.cpp/h` - Sistema de spells/magias
- `movement.cpp/h` - Movimento em tiles especiais
- `talkaction.cpp/h` - Comandos de chat
- `events.cpp/h` - Event hooks
- `globalevent.cpp/h` - Eventos globais (timers)

#### **Sistemas**
- `scheduler.cpp/h` - Agendador de tasks (Boost.Asio)
- `tasks.cpp/h` - Sistema de tasks assíncronas
- `dispatcher.cpp/h` - Dispatcher de eventos
- `combat.cpp/h` - Sistema de combate
- `condition.cpp/h` - Condições (poison, burn, etc.)
- `spawn.cpp/h` - Sistema de spawn de criaturas

#### **Utilitários**
- `configmanager.cpp/h` - Carrega config.lua
- `tools.cpp/h` - Funções utilitárias
- `const.h` - Constantes globais
- `enums.h` - Enumerações
- `definitions.h` - Definições de tipos

#### **Específico do Poke Brave**
- `pokeball.cpp/h` - Sistema de pokebola
- `pokeballs.cpp/h` - Gerenciador de pokebolas
- `pokemons.cpp/h` - Gerenciador de pokémons
- `modulecallback.cpp/h` - Callbacks para módulos Lua


### 3.3. Dados do Jogo (`data/`)

```
data/
├── actions/               # Scripts de uso de items
│   ├── scripts/          # Arquivos .lua
│   └── actions.xml       # Registro de actions
├── movements/            # Scripts de movimento em tiles
│   ├── scripts/
│   └── movements.xml
├── spells/               # Scripts de magias/ataques
│   ├── scripts/
│   └── spells.xml
├── talkactions/          # Comandos de chat
│   ├── scripts/
│   └── talkactions.xml
├── globalevents/         # Eventos globais (timers)
│   ├── scripts/
│   └── globalevents.xml
├── events/               # Event hooks (onLogin, onDeath, etc.)
│   ├── scripts/
│   └── events.xml
├── modules/              # Módulos Lua customizados
│   └── v2/              # Versão 2 dos módulos
│       ├── artificialintelligence/  # IA de pokémons
│       ├── catch/                   # Sistema de captura
│       ├── evolution/               # Sistema de evolução
│       ├── fishing/                 # Sistema de pesca
│       ├── pokedex/                 # Sistema de pokedex
│       └── ...
├── lib/                  # Bibliotecas Lua compartilhadas
│   ├── core/            # Core libraries
│   └── compat/          # Compatibilidade
├── npc/                  # Scripts de NPCs
│   └── lib/             # Bibliotecas de NPC
├── items/                # Definição de items
│   └── items.xml
├── XML/                  # Configurações XML
│   ├── groups.xml       # Grupos de permissões
│   ├── mounts.xml       # Montarias
│   ├── outfits.xml      # Roupas/sprites
│   ├── pokeballs.xml    # Tipos de pokebola
│   ├── professions.xml  # Classes/profissões
│   ├── quests.xml       # Quests
│   └── stages.xml       # Stages de experiência
├── world/                # Arquivos do mapa
│   ├── map.otbm         # Mapa binário
│   ├── map-house.xml    # Casas
│   └── map-spawn.xml    # Spawns
└── global.lua            # Script global (carregado primeiro)
```

---

## 4. FLUXO DE EXECUÇÃO

### 4.1. Inicialização do Servidor

```
┌─────────────────────────────────────────────────────────────┐
│ 1. main() em otserv.cpp                                     │
│    - Parse argumentos de linha de comando                   │
│    - Setup bad allocation handler                           │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 2. Inicializa Threads Principais                            │
│    - g_dispatcher.start()    (processa tasks)               │
│    - g_scheduler.start()     (timers/eventos)               │
│    - g_jobsScheduler.start() (jobs paralelos)               │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 3. mainLoader() - Carrega Recursos                          │
│    ├─ Carrega config.lua                                    │
│    ├─ Conecta ao banco de dados                             │
│    ├─ Executa migrations (schema.sql)                       │
│    ├─ Carrega RSA keys                                      │
│    ├─ Carrega items.xml                                     │
│    ├─ Carrega mapa (map.otbm)                               │
│    ├─ Carrega spawns                                        │
│    ├─ Carrega scripts Lua                                   │
│    ├─ Carrega pokémons, pokebolas, etc.                     │
│    └─ Inicializa sistemas (quests, raids, etc.)             │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 4. Inicia Serviços de Rede                                  │
│    ├─ Login Server (porta 7171)                             │
│    ├─ Game Server (porta 7172)                              │
│    └─ Status Server (porta 7171)                            │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 5. Game Loop Inicia                                          │
│    - checkCreatures() a cada 50ms                           │
│    - checkDecay() a cada 250ms                              │
│    - checkLight() a cada 10s                                │
│    - GlobalEvents executam em seus intervalos               │
└─────────────────────────────────────────────────────────────┘
```

### 4.2. Conexão de um Jogador

```
┌─────────────────────────────────────────────────────────────┐
│ CLIENTE: Abre conexão TCP para porta 7171                   │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 1. ProtocolLogin::onRecvFirstMessage()                      │
│    - Descriptografa com RSA                                 │
│    - Valida versão do cliente                               │
│    - Extrai account name e password                         │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 2. Valida Credenciais                                        │
│    - Query no banco: SELECT * FROM accounts                 │
│    - Verifica password hash (SHA1)                          │
│    - Verifica ban                                           │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 3. Envia Lista de Personagens                               │
│    - Query: SELECT * FROM players WHERE account_id = ?      │
│    - Envia lista de characters para cliente                 │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ CLIENTE: Seleciona personagem e conecta na porta 7172       │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 4. ProtocolGame::onRecvFirstMessage()                       │
│    - Valida token de sessão                                 │
│    - Carrega dados do player do banco                       │
│    - IOLoginData::loadPlayer()                              │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 5. Game::playerLogin()                                       │
│    - Adiciona player ao mapa                                │
│    - Adiciona player à lista de players online              │
│    - Executa evento onLogin (Lua)                           │
│    - Envia dados iniciais ao cliente:                       │
│      • Mapa ao redor do player                              │
│      • Inventário                                           │
│      • Skills                                               │
│      • Condições (poison, etc.)                             │
│      • VIP list                                             │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 6. Player está no jogo!                                      │
│    - Recebe updates do game loop                            │
│    - Pode enviar comandos (movimento, uso de items, etc.)   │
└─────────────────────────────────────────────────────────────┘
```

### 4.3. Movimento de Jogador

```
┌─────────────────────────────────────────────────────────────┐
│ CLIENTE: Envia pacote de movimento (ex: andar para norte)   │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 1. ProtocolGame::parsePacket()                              │
│    - Identifica opcode de movimento                         │
│    - Extrai direção do pacote                               │
│    - Chama parseMove()                                      │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 2. ProtocolGame::parseMove()                                │
│    - Valida se player pode se mover (não está paralizado)   │
│    - Adiciona task ao dispatcher                            │
│    - g_dispatcher.addTask(playerMove)                       │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 3. Game::playerMove()                                        │
│    - Valida cooldown de movimento                           │
│    - Calcula posição de destino                             │
│    - Verifica se tile de destino existe                     │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 4. Game::internalMoveCreature()                             │
│    - Verifica se pode entrar no tile (não bloqueado)        │
│    - Verifica escadas (subir/descer)                        │
│    - Verifica tiles especiais (teleport, etc.)              │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 5. Map::moveCreature()                                       │
│    - Remove creature do tile antigo                         │
│    - Adiciona creature no tile novo                         │
│    - Atualiza índices espaciais                             │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 6. Notifica Spectators                                       │
│    - Map::getSpectators() - busca players próximos          │
│    - Para cada spectator:                                   │
│      • sendCreatureMove() - envia movimento                 │
│      • Atualiza mapa se necessário                          │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 7. Executa Scripts Lua                                       │
│    - MoveEvents::onCreatureMove()                           │
│    - Tile pode ter script especial (damage, teleport, etc.) │
│    - Executa callback Lua se existir                        │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 8. Player moveu com sucesso!                                │
│    - Todos os spectators veem o movimento                   │
│    - Scripts foram executados                               │
└─────────────────────────────────────────────────────────────┘
```

### 4.4. Uso de Item (Action)

```
┌─────────────────────────────────────────────────────────────┐
│ CLIENTE: Clica em item (ex: poção de cura)                  │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 1. ProtocolGame::parseUseItem()                             │
│    - Extrai posição do item                                 │
│    - Extrai ID do item                                      │
│    - Adiciona task ao dispatcher                            │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 2. Game::playerUseItem()                                     │
│    - Valida se player pode usar item                        │
│    - Busca item na posição especificada                     │
│    - Verifica distância (alcance)                           │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 3. Actions::useItem()                                        │
│    - Busca action registrada para o item                    │
│    - Se não tem action, usa comportamento padrão            │
│    - Se tem action, executa script Lua                      │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 4. Executa Script Lua                                        │
│    - Carrega função onUse() do script                       │
│    - Passa parâmetros: player, item, fromPos, target, etc.  │
│    - Script executa lógica customizada                      │
│    - Exemplo: player:addHealth(100)                         │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 5. Aplica Efeitos                                            │
│    - Remove item se consumível (charges--)                  │
│    - Aplica efeitos visuais (magic effect)                  │
│    - Envia mensagens ao player                              │
│    - Notifica spectators                                    │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 6. Item usado com sucesso!                                   │
└─────────────────────────────────────────────────────────────┘
```


### 4.5. Combate (Ataque de Pokémon)

```
┌─────────────────────────────────────────────────────────────┐
│ 1. Creature::onThink() - Executado a cada 500ms             │
│    - Verifica se tem target                                 │
│    - Verifica se pode atacar (cooldown, distância)          │
│    - Chama onAttacking()                                    │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 2. Creature::onAttacking()                                   │
│    - Seleciona spell/ataque a usar                          │
│    - Para pokémons: usa IA (artificialintelligence.lua)     │
│    - Verifica cooldown do ataque                            │
│    - Verifica chance de executar                            │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 3. Pokemon::castSpell()                                      │
│    - Busca spell no sistema de spells                       │
│    - Valida mana/energia                                    │
│    - Executa spell                                          │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 4. Spell::executeCastSpell()                                │
│    - Executa script Lua da spell                            │
│    - Script define área de efeito                           │
│    - Script define dano e tipo                              │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 5. Combat::doCombat()                                        │
│    - Calcula área afetada                                   │
│    - Para cada tile na área:                                │
│      • Busca criaturas no tile                              │
│      • Calcula dano para cada criatura                      │
│      • Aplica resistências/fraquezas                        │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 6. Game::combatChangeHealth()                               │
│    - Aplica dano à criatura                                 │
│    - Verifica se morreu                                     │
│    - Envia efeitos visuais                                  │
│    - Envia mensagens de dano                                │
│    - Notifica spectators                                    │
└────────────────┬────────────────────────────────────────────┘
                 ▼
┌─────────────────────────────────────────────────────────────┐
│ 7. Se criatura morreu: Creature::onDeath()                  │
│    - Executa evento onDeath (Lua)                           │
│    - Cria corpse                                            │
│    - Dá experiência ao atacante                             │
│    - Remove criatura do jogo                                │
└─────────────────────────────────────────────────────────────┘
```

---

## 5. CAMADAS DA ARQUITETURA

### 5.1. Network Layer (Camada de Rede)

**Responsabilidade**: Gerenciar conexões TCP/IP e protocolo binário

**Componentes Principais**:

```cpp
// Server - Aceita conexões
class Server {
    void run();  // Loop principal de I/O
    void accept();  // Aceita novas conexões
};

// Connection - Conexão individual
class Connection {
    void read();   // Lê dados do socket
    void write();  // Escreve dados no socket
    void close();  // Fecha conexão
};

// Protocol - Processa mensagens
class Protocol {
    virtual void parsePacket() = 0;  // Parse mensagem
    void send(NetworkMessage& msg);  // Envia mensagem
};

// ProtocolGame - Protocolo do jogo
class ProtocolGame : public Protocol {
    void parseMove();
    void parseUseItem();
    void parseSay();
    // ... dezenas de parseXXX()
};
```

**Fluxo de Dados**:
```
Socket → Connection → Protocol → Game
       ←             ←          ←
```

**Características**:
- Usa Boost.Asio para I/O assíncrono
- Protocolo binário customizado
- Criptografia XTEA
- Compressão de pacotes grandes
- Rate limiting (anti-flood)

### 5.2. Game Layer (Camada de Jogo)

**Responsabilidade**: Lógica central do jogo

**Componentes Principais**:

```cpp
// Game - Classe central
class Game {
    // Mundo
    Map map;
    std::map<uint32_t, Player*> players;
    std::map<uint32_t, Pokemon*> pokemons;
    std::map<uint32_t, Npc*> npcs;
    
    // Ações
    void playerMove(Player* player, Direction dir);
    void playerUseItem(Player* player, Item* item);
    void playerSay(Player* player, std::string text);
    
    // Game Loop
    void checkCreatures(size_t index);
    void checkDecay();
    void checkLight();
};

// Map - Mapa do jogo
class Map {
    std::unordered_map<Position, Tile*> tiles;
    
    Tile* getTile(const Position& pos);
    void moveCreature(Creature& creature, Tile& toTile);
    void getSpectators(SpectatorVec& list, Position pos);
};

// Creature - Criatura base
class Creature : public Thing {
    virtual void onThink(uint32_t interval);
    virtual void onAttacking(uint32_t interval);
    virtual void onDeath();
    
    int32_t health;
    int32_t maxHealth;
    Position position;
};
```

**Hierarquia de Classes**:
```
Thing (interface base)
  ├─ Creature
  │   ├─ Player
  │   ├─ Pokemon
  │   └─ Npc
  └─ Item
      ├─ Container
      ├─ Teleport
      └─ Bed
```

### 5.3. Script Layer (Camada de Scripts)

**Responsabilidade**: Lógica customizável em Lua

**Sistemas de Scripts**:

1. **Actions** - Uso de items
```lua
function onUse(player, item, fromPosition, target, toPosition)
    player:addHealth(100)
    item:remove(1)  -- Remove 1 charge
    return true
end
```

2. **Spells** - Magias e ataques
```lua
local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end
```

3. **Movements** - Movimento em tiles
```lua
function onStepIn(creature, item, position, fromPosition)
    if creature:isPlayer() then
        creature:teleportTo(Position(100, 100, 7))
    end
    return true
end
```

4. **TalkActions** - Comandos de chat
```lua
function onSay(player, words, param)
    if param == "" then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Usage: /tp x,y,z")
        return false
    end
    
    local split = param:split(",")
    local pos = Position(tonumber(split[1]), tonumber(split[2]), tonumber(split[3]))
    player:teleportTo(pos)
    return false
end
```

5. **Events** - Hooks de eventos
```lua
function onLogin(player)
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Welcome!")
    
    -- Dar items iniciais
    if player:getStorageValue(10050) == -1 then
        player:addItem(2120, 1)  -- Rope
        player:setStorageValue(10050, 1)
    end
    
    return true
end
```

6. **GlobalEvents** - Eventos globais com timer
```lua
function onTime(interval)
    -- Executado a cada X segundos
    Game.broadcastMessage("Server save in 5 minutes!")
    return true
end
```

7. **Modules** - Módulos customizados
```lua
-- Sistema modular do Poke Brave
module = {
    name = "catch",
    version = "2.0"
}

function module.init()
    module.connect("onUseItem", onUsePokeball)
end

function onUsePokeball(player, item, target)
    if target:isPokemon() then
        -- Lógica de captura
        local catchRate = calculateCatchRate(target)
        if math.random(100) <= catchRate then
            capturePokemon(player, target)
        end
    end
end
```

**Bridge C++ ↔ Lua**:
```cpp
// Registrar função C++ para Lua
lua_register(L, "doPlayerAddHealth", luaDoPlayerAddHealth);

// Implementação
int luaDoPlayerAddHealth(lua_State* L) {
    Player* player = getUserdata<Player>(L, 1);
    int32_t health = getNumber<int32_t>(L, 2);
    
    if (player) {
        player->changeHealth(health);
        pushBoolean(L, true);
    } else {
        pushBoolean(L, false);
    }
    
    return 1;  // Número de valores de retorno
}
```

### 5.4. Data Layer (Camada de Dados)

**Responsabilidade**: Persistência e configuração

**Componentes**:

1. **Database (MySQL)**
```sql
-- Principais tabelas
accounts          -- Contas de usuário
players           -- Personagens
player_items      -- Items dos players
player_storage    -- Storage values
guilds            -- Guildas
houses            -- Casas
market_offers     -- Ofertas do market
```

2. **XML Files**
```xml
<!-- items.xml - Definição de items -->
<item id="2120" name="rope">
    <attribute key="weight" value="350"/>
    <attribute key="description" value="A rope."/>
</item>

<!-- monsters.xml - Definição de monstros -->
<monster name="Pikachu" nameDescription="a pikachu">
    <health now="300" max="300"/>
    <look type="1025"/>
    <targetchange interval="5000" chance="8"/>
    <attacks>
        <attack name="thunderbolt" interval="2000" chance="100"/>
    </attacks>
</monster>
```

3. **Config (config.lua)**
```lua
-- Configurações do servidor
worldType = "pvp"
ip = "127.0.0.1"
loginProtocolPort = 7171
gameProtocolPort = 7172
maxPlayers = 1000
motd = "Welcome!"

-- Rates
rateExperience = 1.0
rateSkill = 1.0
rateLoot = 1.0
rateSpawn = 1.0
```

**Acesso aos Dados**:
```cpp
// Síncrono (bloqueia thread)
DBResult_ptr result = db.storeQuery("SELECT * FROM players WHERE id = 1");

// Assíncrono (não bloqueia)
g_databaseTasks.addTask([playerId]() {
    Database& db = Database::getInstance();
    DBResult_ptr result = db.storeQuery(
        fmt::format("SELECT * FROM players WHERE id = {:d}", playerId)
    );
    
    // Processa resultado em background
    // Depois envia resultado para game thread via dispatcher
    g_dispatcher.addTask([result]() {
        // Usa resultado na thread principal
    });
});
```

---

## 6. PADRÕES DE DESIGN

### 6.1. Singleton

Usado para gerenciadores globais:

```cpp
class Game {
public:
    static Game& getInstance() {
        static Game instance;
        return instance;
    }
    
private:
    Game() = default;
    Game(const Game&) = delete;
    Game& operator=(const Game&) = delete;
};

// Uso
Game& g_game = Game::getInstance();
```

### 6.2. Factory

Criação de objetos baseado em tipo:

```cpp
class Item {
public:
    static Item* CreateItem(uint16_t itemId, uint16_t count = 1) {
        const ItemType& it = items[itemId];
        
        if (it.isContainer()) {
            return new Container(itemId);
        } else if (it.isTeleport()) {
            return new Teleport(itemId);
        } else {
            return new Item(itemId, count);
        }
    }
};
```

### 6.3. Observer

Sistema de eventos e notificações:

```cpp
class Creature {
    virtual void onCreatureAppear(Creature* creature) {}
    virtual void onCreatureDisappear(Creature* creature) {}
    virtual void onCreatureMove(Creature* creature, 
                                const Position& oldPos,
                                const Position& newPos) {}
};

// Quando criatura se move, notifica observers
for (Creature* spectator : spectators) {
    spectator->onCreatureMove(creature, oldPos, newPos);
}
```

### 6.4. Strategy

Diferentes estratégias de combate:

```cpp
class Combat {
    CombatFormula formula;  // Strategy
    
    int32_t calculateDamage(Creature* attacker, Creature* target) {
        return formula.calculate(attacker, target);
    }
};

// Diferentes fórmulas
class LevelFormula : public CombatFormula { ... };
class MagicFormula : public CombatFormula { ... };
class MeleeFormula : public CombatFormula { ... };
```

### 6.5. Command

Tasks e comandos:

```cpp
class Task {
    std::function<void()> func;
    
public:
    Task(std::function<void()> f) : func(std::move(f)) {}
    void execute() { func(); }
};

// Uso
g_dispatcher.addTask(createTask([]() {
    // Código a executar
}));
```

---

## 7. SISTEMAS PRINCIPAIS

### 7.1. Sistema de Scheduler

**Propósito**: Agendar tasks para execução futura

```cpp
class Scheduler {
    boost::asio::io_context io_context;
    std::unordered_map<uint32_t, boost::asio::steady_timer> timers;
    
public:
    uint32_t addEvent(SchedulerTask* task) {
        auto& timer = timers[task->getEventId()];
        timer.expires_from_now(
            std::chrono::milliseconds(task->getDelay())
        );
        timer.async_wait([task](const boost::system::error_code& error) {
            if (!error) {
                g_dispatcher.addTask(task);
            }
        });
        return task->getEventId();
    }
    
    void stopEvent(uint32_t eventId) {
        auto it = timers.find(eventId);
        if (it != timers.end()) {
            it->second.cancel();
        }
    }
};
```

**Uso**:
```cpp
// Agendar para daqui a 1 segundo
g_scheduler.addEvent(createSchedulerTask(1000, []() {
    std::cout << "Hello after 1 second!" << std::endl;
}));

// Agendar recursivamente (game loop)
void Game::checkCreatures(size_t index) {
    g_scheduler.addEvent(createSchedulerTask(50, 
        std::bind(&Game::checkCreatures, this, (index + 1) % 10)
    ));
    
    // Processa criaturas...
}
```

### 7.2. Sistema de Dispatcher

**Propósito**: Executar tasks na thread principal (thread-safe)

```cpp
class Dispatcher {
    std::thread thread;
    std::condition_variable signal;
    std::mutex taskLock;
    std::list<Task*> taskList;
    
public:
    void addTask(Task* task) {
        std::lock_guard<std::mutex> lock(taskLock);
        taskList.push_back(task);
        signal.notify_one();
    }
    
    void threadMain() {
        while (running) {
            std::unique_lock<std::mutex> lock(taskLock);
            
            if (taskList.empty()) {
                signal.wait(lock);
            }
            
            while (!taskList.empty()) {
                Task* task = taskList.front();
                taskList.pop_front();
                
                lock.unlock();
                task->execute();
                delete task;
                lock.lock();
            }
        }
    }
};
```

**Por que é necessário?**
- Network threads recebem pacotes
- Mas Game só pode ser modificado na thread principal
- Dispatcher garante thread-safety

```cpp
// Thread de rede recebe pacote
void ProtocolGame::parseMove(Direction dir) {
    // Adiciona task para thread principal
    g_dispatcher.addTask(createTask([this, dir]() {
        g_game.playerMove(player, dir);
    }));
}
```


### 7.3. Sistema de Pathfinding

**Propósito**: Calcular caminho entre dois pontos

**Algoritmo**: A* (A-Star)

```cpp
class Map {
    bool getPathMatching(const Creature& creature, 
                        std::vector<Direction>& dirList,
                        const Position& targetPos,
                        bool fullPathSearch = true,
                        int32_t maxSearchDist = 7) {
        
        // A* pathfinding
        std::priority_queue<Node> openList;
        std::unordered_set<Position> closedList;
        
        Node startNode(creature.getPosition());
        openList.push(startNode);
        
        while (!openList.empty()) {
            Node current = openList.top();
            openList.pop();
            
            if (current.pos == targetPos) {
                // Reconstruir caminho
                reconstructPath(current, dirList);
                return true;
            }
            
            closedList.insert(current.pos);
            
            // Explorar vizinhos
            for (Direction dir : {NORTH, SOUTH, EAST, WEST}) {
                Position neighborPos = getNextPosition(dir, current.pos);
                
                if (closedList.count(neighborPos)) {
                    continue;
                }
                
                Tile* tile = getTile(neighborPos);
                if (!tile || !creature.canWalkTo(tile)) {
                    continue;
                }
                
                Node neighbor(neighborPos);
                neighbor.g = current.g + 1;
                neighbor.h = getDistance(neighborPos, targetPos);
                neighbor.f = neighbor.g + neighbor.h;
                neighbor.parent = current;
                
                openList.push(neighbor);
            }
        }
        
        return false;  // Caminho não encontrado
    }
};
```

**Otimizações**:
- Limite de distância de busca (maxSearchDist)
- Cache de paths recentes
- Pathfinding assíncrono para paths longos

### 7.4. Sistema de Spectators

**Propósito**: Encontrar jogadores que podem ver um evento

```cpp
class Map {
    void getSpectators(SpectatorVec& spectators, 
                      const Position& centerPos,
                      bool multifloor = false,
                      bool onlyPlayers = false,
                      int32_t minRangeX = 0,
                      int32_t maxRangeX = 0,
                      int32_t minRangeY = 0,
                      int32_t maxRangeY = 0) {
        
        // Área de visão padrão: 18x14 tiles
        if (maxRangeX == 0) {
            maxRangeX = 9;  // 9 tiles para cada lado
            minRangeX = -9;
        }
        if (maxRangeY == 0) {
            maxRangeY = 7;  // 7 tiles para cima/baixo
            minRangeY = -7;
        }
        
        // Varre área
        for (int32_t y = minRangeY; y <= maxRangeY; ++y) {
            for (int32_t x = minRangeX; x <= maxRangeX; ++x) {
                Position pos(centerPos.x + x, centerPos.y + y, centerPos.z);
                
                Tile* tile = getTile(pos);
                if (!tile) {
                    continue;
                }
                
                // Adiciona criaturas do tile
                const CreatureVector* creatures = tile->getCreatures();
                if (creatures) {
                    for (Creature* creature : *creatures) {
                        if (!onlyPlayers || creature->getPlayer()) {
                            spectators.push_back(creature);
                        }
                    }
                }
            }
        }
        
        // Multifloor: inclui andares acima/abaixo
        if (multifloor) {
            // ... código para outros andares
        }
    }
};
```

**Uso**:
```cpp
// Quando algo acontece, notificar quem pode ver
void Game::addMagicEffect(const Position& pos, uint16_t effect) {
    SpectatorVec spectators;
    map.getSpectators(spectators, pos, true, true);
    
    for (Creature* spectator : spectators) {
        Player* player = spectator->getPlayer();
        if (player) {
            player->sendMagicEffect(pos, effect);
        }
    }
}
```

### 7.5. Sistema de Spawn

**Propósito**: Spawnar criaturas no mapa

```cpp
class Spawn {
    Position centerPos;
    int32_t radius;
    uint32_t interval;  // Tempo entre spawns
    
    struct SpawnBlock {
        Position pos;
        std::string pokemonName;
        Direction direction;
        uint32_t interval;
        uint32_t lastSpawn;
    };
    
    std::vector<SpawnBlock> spawnBlocks;
    
    void checkSpawn() {
        uint32_t now = OTSYS_TIME();
        
        for (SpawnBlock& block : spawnBlocks) {
            if (now - block.lastSpawn < block.interval) {
                continue;  // Ainda não é hora
            }
            
            // Verifica se já tem criatura na posição
            Tile* tile = g_game.map.getTile(block.pos);
            if (tile && tile->getTopCreature()) {
                continue;  // Posição ocupada
            }
            
            // Cria pokémon
            Pokemon* pokemon = Pokemon::createPokemon(block.pokemonName);
            if (pokemon) {
                pokemon->setDirection(block.direction);
                pokemon->setMasterPos(centerPos);
                pokemon->setMasterRadius(radius);
                
                if (g_game.placeCreature(pokemon, block.pos)) {
                    block.lastSpawn = now;
                } else {
                    delete pokemon;
                }
            }
        }
        
        // Agenda próxima checagem
        g_scheduler.addEvent(createSchedulerTask(interval,
            std::bind(&Spawn::checkSpawn, this)
        ));
    }
};
```

**Carregamento de Spawns**:
```xml
<!-- map-spawn.xml -->
<spawn centerx="100" centery="100" centerz="7" radius="10">
    <pokemon name="Pikachu" x="0" y="0" z="0" spawntime="60"/>
    <pokemon name="Charmander" x="5" y="5" z="0" spawntime="120"/>
</spawn>
```

---

## 8. GLOSSÁRIO DE TERMOS

### Termos Gerais

- **OTServer**: Open Tibia Server - servidor de jogo baseado em Tibia
- **TFS**: The Forgotten Server - base de código mais popular
- **Canary**: Fork moderno do TFS com melhorias
- **OTBM**: Open Tibia Binary Map - formato de mapa
- **OTB**: Open Tibia Binary - formato de items

### Conceitos de Jogo

- **Thing**: Objeto base (criatura ou item)
- **Creature**: Criatura (player, pokémon, npc)
- **Tile**: Quadrado do mapa (8x8 pixels)
- **Position**: Coordenada 3D (x, y, z)
- **Cylinder**: Interface para objetos que contêm things
- **Spectator**: Criatura que pode ver um evento
- **Stack**: Pilha de items em um tile

### Network

- **Protocol**: Implementação de protocolo de comunicação
- **Packet**: Mensagem binária entre cliente e servidor
- **Opcode**: Código que identifica tipo de mensagem
- **XTEA**: Algoritmo de criptografia usado
- **RSA**: Criptografia assimétrica para login

### Scripts

- **Action**: Script de uso de item
- **Spell**: Script de magia/ataque
- **Movement**: Script de movimento em tile
- **TalkAction**: Script de comando de chat
- **GlobalEvent**: Script de evento global com timer
- **CreatureEvent**: Script de evento de criatura
- **Module**: Sistema modular customizado

### Database

- **Storage**: Valor persistente associado a player
- **Guild**: Guilda/clã de jogadores
- **House**: Casa que pode ser comprada
- **Market**: Sistema de mercado/leilão
- **VIP**: Lista de amigos

### Performance

- **Tick**: Ciclo do game loop (50ms)
- **Dispatcher**: Fila de tasks thread-safe
- **Scheduler**: Agendador de eventos futuros
- **Task**: Unidade de trabalho a executar
- **Async**: Operação assíncrona (não bloqueia)

---

## 9. EXEMPLOS PRÁTICOS

### 9.1. Criar um Novo Item Usável

**1. Definir item em items.xml**:
```xml
<item id="9000" name="super potion">
    <attribute key="weight" value="100"/>
    <attribute key="description" value="Heals 200 HP."/>
</item>
```

**2. Criar script em data/actions/scripts/super_potion.lua**:
```lua
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- Validar target
    if not target or not target:isCreature() then
        player:sendCancelMessage("You can only use this on creatures.")
        return false
    end
    
    -- Aplicar cura
    local healAmount = 200
    target:addHealth(healAmount)
    
    -- Efeito visual
    target:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    
    -- Mensagem
    player:sendTextMessage(MESSAGE_STATUS_DEFAULT, 
        string.format("You healed %s for %d HP.", target:getName(), healAmount))
    
    -- Remover item
    item:remove(1)
    
    return true
end
```

**3. Registrar em data/actions/actions.xml**:
```xml
<action itemid="9000" script="super_potion.lua"/>
```

### 9.2. Criar um Novo Comando

**1. Criar script em data/talkactions/scripts/teleport.lua**:
```lua
function onSay(player, words, param)
    -- Verificar permissão
    if not player:getGroup():getAccess() then
        player:sendCancelMessage("You don't have permission.")
        return false
    end
    
    -- Parse parâmetros
    if param == "" then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 
            "Usage: /tp x,y,z")
        return false
    end
    
    local split = param:split(",")
    if #split ~= 3 then
        player:sendCancelMessage("Invalid format. Use: /tp x,y,z")
        return false
    end
    
    -- Teleportar
    local pos = Position(
        tonumber(split[1]), 
        tonumber(split[2]), 
        tonumber(split[3])
    )
    
    player:teleportTo(pos)
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    
    return false
end
```

**2. Registrar em data/talkactions/talkactions.xml**:
```xml
<talkaction words="/tp" separator=" " script="teleport.lua"/>
```

### 9.3. Criar um Tile de Teleporte

**1. Criar script em data/movements/scripts/teleport_tile.lua**:
```lua
local destination = Position(100, 100, 7)

function onStepIn(creature, item, position, fromPosition)
    if not creature:isPlayer() then
        return true
    end
    
    local player = creature:getPlayer()
    
    -- Teleportar
    player:teleportTo(destination)
    destination:sendMagicEffect(CONST_ME_TELEPORT)
    
    -- Mensagem
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 
        "You have been teleported!")
    
    return true
end
```

**2. Registrar em data/movements/movements.xml**:
```xml
<movevent type="stepin" actionid="1000" script="teleport_tile.lua"/>
```

**3. No mapa, colocar actionid 1000 no tile desejado**

### 9.4. Criar um Sistema de Quest

**1. Definir quest em data/XML/quests.xml**:
```xml
<quest name="Pikachu Quest" startstorageid="50000" startstoragevalue="1">
    <mission name="Find Pikachu" storageid="50000" startvalue="1" endvalue="2">
        <missionstate id="1" description="Find and talk to Professor Oak."/>
        <missionstate id="2" description="Catch a Pikachu."/>
    </mission>
</quest>
```

**2. NPC que inicia quest (data/npc/professor_oak.lua)**:
```lua
local function greetCallback(npc, creature)
    local player = Player(creature)
    
    if player:getStorageValue(50000) == -1 then
        npcHandler:say("Hello! I need your help to catch a Pikachu!", npc, creature)
        player:setStorageValue(50000, 1)  -- Inicia quest
    elseif player:getStorageValue(50000) == 1 then
        npcHandler:say("Did you catch the Pikachu yet?", npc, creature)
    else
        npcHandler:say("Thank you for your help!", npc, creature)
    end
    
    return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
```

**3. Script de captura (data/modules/v2/catch/catch_main.lua)**:
```lua
function onCatchPokemon(player, pokemon)
    -- Verifica se é Pikachu e se está na quest
    if pokemon:getName():lower() == "pikachu" and 
       player:getStorageValue(50000) == 1 then
        
        player:setStorageValue(50000, 2)  -- Completa quest
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 
            "Quest completed! Return to Professor Oak.")
    end
end
```

---

## 10. DICAS PARA INICIANTES

### 10.1. Como Começar a Contribuir

1. **Entenda a estrutura**
   - Leia este guia completamente
   - Explore o código fonte
   - Rode o servidor localmente

2. **Comece pequeno**
   - Crie um item simples
   - Crie um comando básico
   - Modifique um script existente

3. **Use ferramentas**
   - Debugger (GDB, Visual Studio)
   - Lua debugger
   - Git para controle de versão

4. **Leia código existente**
   - Veja como outros items funcionam
   - Estude scripts de quests
   - Analise sistemas complexos

### 10.2. Debugging

**C++ (Visual Studio)**:
```cpp
// Adicionar breakpoint
int x = 10;  // F9 aqui

// Inspecionar variáveis
std::cout << "Player: " << player->getName() << std::endl;

// Assert para validação
assert(player != nullptr && "Player must not be null");
```

**Lua**:
```lua
-- Print debug
print("Player position:", player:getPosition())

-- Dump table
function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            s = s .. '['..k..'] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

print(dump(myTable))
```

### 10.3. Performance

**Evite**:
```lua
-- RUIM: Loop em todos os players
for _, player in ipairs(Game.getPlayers()) do
    -- ...
end

-- RUIM: Query síncrona na thread principal
db.query("SELECT * FROM huge_table")

-- RUIM: Criar muitos objetos temporários
for i = 1, 1000 do
    local pos = Position(x, y, z)  -- Cria 1000 objetos
end
```

**Prefira**:
```lua
-- BOM: Use spectators quando possível
local spectators = Game.getSpectators(position)

-- BOM: Query assíncrona
db.asyncQuery("SELECT * FROM huge_table", callback)

-- BOM: Reutilize objetos
local pos = Position(0, 0, 0)
for i = 1, 1000 do
    pos:setPosition(x, y, z)  -- Reutiliza objeto
end
```

### 10.4. Segurança

**Sempre valide input**:
```lua
function onSay(player, words, param)
    -- Validar parâmetro
    if param == "" then
        return false
    end
    
    -- Validar permissão
    if not player:getGroup():getAccess() then
        return false
    end
    
    -- Validar range
    local amount = tonumber(param)
    if not amount or amount < 1 or amount > 1000 then
        player:sendCancelMessage("Invalid amount (1-1000).")
        return false
    end
    
    -- Agora é seguro usar
    player:addItem(2160, amount)
    return false
end
```

**Previna SQL Injection**:
```cpp
// RUIM
std::string query = "SELECT * FROM players WHERE name = '" + playerName + "'";

// BOM - Use prepared statements
DBResult_ptr result = db.storeQuery(
    fmt::format("SELECT * FROM players WHERE name = {:s}", 
                db.escapeString(playerName))
);
```

---

## 11. RECURSOS ADICIONAIS

### 11.1. Documentação

- **TFS Wiki**: https://github.com/otland/forgottenserver/wiki
- **OTLand Forum**: https://otland.net/
- **Lua 5.1 Manual**: https://www.lua.org/manual/5.1/
- **Boost.Asio**: https://www.boost.org/doc/libs/release/doc/html/boost_asio.html

### 11.2. Ferramentas

- **Remere's Map Editor**: Editor de mapas WYSIWYG
- **Object Builder**: Editor de sprites e items
- **OTClient**: Cliente open source
- **MySQL Workbench**: Gerenciador de banco de dados

### 11.3. Comunidade

- **Discord**: Comunidades de OTServ
- **GitHub**: Repositórios de código
- **YouTube**: Tutoriais em vídeo
- **Stack Overflow**: Perguntas técnicas

---

## 12. CONCLUSÃO

Este guia cobriu a arquitetura completa de um OTServer, desde a estrutura de diretórios até os fluxos de execução detalhados. Com este conhecimento, você deve ser capaz de:

✅ Entender como o servidor funciona internamente  
✅ Navegar pelo código fonte com confiança  
✅ Criar novos items, comandos e sistemas  
✅ Debugar problemas eficientemente  
✅ Contribuir para o projeto  

### Próximos Passos

1. **Prática**: Crie seus próprios items e comandos
2. **Leitura**: Estude o código fonte de sistemas complexos
3. **Contribuição**: Corrija bugs e adicione features
4. **Comunidade**: Participe de fóruns e ajude outros

**Lembre-se**: Todo desenvolvedor experiente começou como iniciante. Não tenha medo de fazer perguntas e experimentar!

---

**Fim do Guia**

*Este documento foi gerado automaticamente pelo AGENT_ARCHITECTURE_DOC para ajudar desenvolvedores a entenderem a arquitetura do Poke Brave / OTServer.*
