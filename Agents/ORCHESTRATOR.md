# ORCHESTRATOR – Suite de Agents OTC/TFS/Canary/MEHAH

## Objetivo
Definir como orquestrar a execução de todos os agents desta suite em um repositório de servidor (source C++ + Lua + XML de conteúdo).

O orquestrador **não executa mudanças no código**, apenas coordena a leitura dos arquivos e a geração dos relatórios por cada agent.

## Ordem sugerida de execução

1. `AGENT_PROTOCOL_SYNC.md`
2. `AGENT_LUA_STATIC.md`
3. `AGENT_CONTENT_INTEGRITY.md`
4. `AGENT_TICK_PERF.md`
5. `AGENT_QUEST_STORAGE.md`
6. `AGENT_CPP_CRASH_RISK.md`
7. `AGENT_CODE_SMELL.md`

## Inputs esperados por tipo de arquivo

- C++: diretórios como `src/`, `src/game/`, `src/protocols/`, etc.
- Lua: `data/actions/`, `data/movements/`, `data/creaturescripts/`, `data/talkactions/`, `data/globalevents/`, e outros.
- XML: `data/items/`, `data/monsters/`, `data/spells/`, `data/actions/`, `data/movements/`, `data/weapons/`, `data/vocations/`.

## Saídas esperadas ao final da orquestração

- `PROTOCOL_SYNC.md`
- `LUA_ERRORS.md`
- `CONTENT_INTEGRITY.md`
- `TICK_PERFORMANCE.md`
- `QUEST_STORAGE_REPORT.md`
- `CPP_CRASH_RISKS.md`
- `CODE_SMELLS.md`

Cada agent deve ser chamado com acesso somente-leitura aos arquivos, e deve gravar apenas o relatório de saída correspondente.

## Regras gerais

- Nenhum agent pode alterar arquivos do projeto.
- Todos os agents devem ser idempotentes (rodar novamente gera o mesmo relatório para o mesmo estado de código).
- O orquestrador pode rodar todos em paralelo ou em série, desde que respeite paths corretos de entrada/saída.
