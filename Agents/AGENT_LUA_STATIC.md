# AGENT – Lua Script Static Analyzer

## Objetivo
Analisar scripts Lua do servidor para encontrar **erros de código e lógica** em:
- actions
- movements
- creaturescripts
- talkactions
- globalevents
- outros módulos Lua

O agente deve apenas **ler** os arquivos e **gerar relatório**, nunca alterar código.

## Entradas
- Todos os arquivos `.lua` do servidor.
- Opcional: referência da API exposta pelo engine (funções disponíveis, assinaturas).

## Saída
- Relatório `LUA_ERRORS.md`.

## O que o agente DEVE fazer
- Detectar:
  - Chamadas a funções inexistentes da API.
  - Uso de variáveis potencialmente nil em pontos críticos.
  - Callbacks (`onUse`, `onStepIn`, `onThink`, etc.) com retorno incorreto ou ausente.
  - Condições de lógica claramente invertidas / inúteis.
  - Loops pesados em eventos de alta frequência (`onThink`, globalevents com intervalo baixo).
- Descrever para cada problema:
  - Arquivo, função e linha aproximada.
  - Descrição do erro.
  - Impacto in-game (ex.: alavanca não funciona, quest não avança, crash etc.).
  - Sugestão de ajuste em texto (sem reescrever o script inteiro).

## O que o agente NÃO deve fazer
- NÃO alterar scripts.
- NÃO comentar sobre segurança.
- NÃO reescrever o estilo do código sem motivo funcional.
