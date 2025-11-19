# Tibia OTServer AI Agents Suite

Suite de agentes de IA desenhada para analisar servidores baseados em:
- Source C++ (TFS, Canary, forks)
- Scripts Lua
- Conteúdo XML (items, monsters, spells, etc.)
- Client OTC (opcodes/protocolo)

Todos os agents têm uma regra em comum:

> **Eles nunca alteram nada no repositório.**  
> Apenas leem arquivos e geram relatórios em Markdown.

---

## Arquivos de agente (`AGENT_*.md`)

Cada `AGENT_XXXX.md` descreve o comportamento esperado de um agente de IA específico.

### 1. `AGENT_PROTOCOL_SYNC.md`
**Foco:** Protocolo e opcodes.

- Compara opcodes, mensagens e estrutura de pacotes entre:
  - Source C++ (server)
  - Client OTC (ou derivados)
- Encontra:
  - OpCodes inconsistentes.
  - Pacotes com tamanhos diferentes em client/server.
  - Campos lidos/escritos em ordem diferente.
- Gera: `PROTOCOL_SYNC.md`.

### 2. `AGENT_LUA_STATIC.md`
**Foco:** Scripts Lua.

- Analisa:
  - Chamadas a funções inexistentes.
  - Uso de variáveis potencialmente `nil`.
  - Callbacks com retorno errado.
  - Loops pesados em eventos frequentes.
- Gera: `LUA_ERRORS.md`.

### 3. `AGENT_CONTENT_INTEGRITY.md`
**Foco:** Conteúdo de jogo (XML/Lua).

- Cruza:
  - `items.xml`, `monsters/*.xml`, `spells`, `actions`, `movements`, `weapons`, `vocations`.
- Procura:
  - IDs inexistentes.
  - Loot apontando para itens que não existem.
  - Spells/efeitos inválidos.
  - actions/movements sem script.
- Gera: `CONTENT_INTEGRITY.md`.

### 4. `AGENT_TICK_PERF.md`
**Foco:** Performance de tick/game loop.

- Olha:
  - Game loop em C++.
  - Scripts Lua de alta frequência (globalevents, onThink, etc.).
- Procura:
  - Loops pesados.
  - Consultas caras em contextos sensíveis.
  - Sistemas que escalam mal com número de players/monstros.
- Gera: `TICK_PERFORMANCE.md`.

### 5. `AGENT_QUEST_STORAGE.md`
**Foco:** Storages e quests.

- Mapeia:
  - Uso de storages em scripts Lua.
- Procura:
  - IDs usados em sistemas diferentes.
  - Storages lidos e nunca escritos.
  - Storages escritos e nunca lidos.
  - Lógicas incoerentes de progresso.
- Gera: `QUEST_STORAGE_REPORT.md`.

### 6. `AGENT_CPP_CRASH_RISK.md`
**Foco:** Riscos de crash no C++.

- Analisa:
  - Acessos a ponteiros sem checagem.
  - Uso de containers sem validação de limites.
  - Funções com fluxos sem retorno.
  - Switches sem tratamento mínimo de casos inesperados.
- Gera: `CPP_CRASH_RISKS.md`.

### 7. `AGENT_CODE_SMELL.md`
**Foco:** Código mal feito / code smells.

- Em Lua e C++:
  - Funções gigantes.
  - `if` aninhado demais.
  - Código duplicado.
  - Variáveis/funções com nomes genéricos demais em contexto crítico.
  - Mistura de muitas responsabilidades num único trecho.
- Gera: `CODE_SMELLS.md`.

---

## Orquestrador

### `ORCHESTRATOR.md`
Define como rodar todos os agents em conjunto:

- Ordem sugerida de execução.
- Quais diretórios/arquivos cada agent precisa.
- Quais relatórios são esperados ao final.

---

## Como usar na prática

1. Adicione estes arquivos ao seu repositório ou pipeline de análise.
2. Implemente cada agent na sua stack de IA (por exemplo, chamando um modelo com o conteúdo do `AGENT_*.md` como instrução).
3. Aponte o orquestrador para os diretórios do servidor (C++, Lua, XML, client OTC).
4. Colete os relatórios `.md` gerados para revisar problemas.

---

## Regras importantes

- Nenhum agente pode editar ou formatar arquivos de código.
- Esta suite serve como **raio-x de problemas e riscos**, não como ferramenta de auto-fix.
- Qualquer correção deve ser feita manualmente por um desenvolvedor.
