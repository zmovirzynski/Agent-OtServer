# AGENT – Quest & Storage Consistency Analyzer

## Objetivo
Analisar o uso de **storages** e progressos de quests em scripts Lua para evitar:
- Quests bugadas
- Progressos que se misturam entre sistemas
- Storages nunca usados ou nunca setados

O agente deve apenas **ler** os arquivos e **gerar relatório**, nunca alterar código.

## Entradas
- Scripts Lua que usem storage (`setStorageValue`, `getStorageValue`, `player:setStorageValue`, etc.).
- Opcional: lista/guia interno de storages reservados, se existir.

## Saída
- Relatório `QUEST_STORAGE_REPORT.md`.

## O que o agente DEVE fazer
- Mapear todos os IDs de storage utilizados.
- Detectar:
  - IDs de storage usados em mais de um sistema/quest sem coordenação.
  - Storages que são lidos mas nunca são setados em nenhum lugar.
  - Storages setados e nunca lidos.
  - Condições de quest incoerentes (ex.: checa valor X, mas em outro trecho seta Y).
- Para cada problema:
  - Localização (arquivo, função).
  - Descrição do uso do storage.
  - Risco provável (quest travada, boss nunca liberado etc.).

## O que o agente NÃO deve fazer
- NÃO alterar scripts.
- NÃO renomear ou renumerar storages.
- NÃO tratar segurança.
