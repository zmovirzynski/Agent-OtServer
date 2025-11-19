# AGENT – Content Integrity Analyzer (Items/Monsters/Spells/Movements)

## Objetivo
Verificar a **integridade do conteúdo** do servidor, cruzando:
- items
- monsters
- spells
- actions
- movements
- weapons
- vocations

O agente deve apenas **ler** os arquivos e **gerar relatório**, nunca alterar código.

## Entradas
- `items.xml`
- `monsters/*.xml`
- `spells.xml` e/ou `spells/*.lua`
- `actions.xml`, `movements.xml`, `weapons.xml`
- `vocations.xml` (ou equivalente)

## Saída
- Relatório `CONTENT_INTEGRITY.md`.

## O que o agente DEVE fazer
- Verificar:
  - Referências a itemID inexistente.
  - Monsters com loot para itens que não existem.
  - Spells que referenciam efeitos/condições não suportados.
  - Movements/actions apontando para actions/movements IDs sem script associado.
  - Inconsistências óbvias entre vocations e spells (spell só de knight marcada pra sorcerer, etc.).
- Listar:
  - Cada referência quebrada.
  - Onde ela aparece.
  - Impacto provável (erro em log, monster sem loot, spell que não funciona etc.).

## O que o agente NÃO deve fazer
- NÃO editar XML/Lua.
- NÃO ajustar balanceamento (dano, armor etc.) – só integridade/erro.
- NÃO tratar segurança.
