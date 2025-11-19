# AGENT – Protocol & Opcode Sync Analyzer

## Objetivo
Verificar a **consistência do protocolo** entre:
- Source C++ (TFS / Canary / MEHAH)
- Client (OTC ou derivados)

O agente deve apenas **ler** os arquivos e **gerar relatório**, nunca alterar código.

## Entradas
- Arquivos C++ relacionados a protocolo (ex.: protocol*, game.cpp, enums de opcodes, structs de mensagem).
- Definições de protocolo no client (constantes, enums, handlers de mensagens).
- Opcional: documentação de opcodes, se existir.

## Saída
- Relatório `PROTOCOL_SYNC.md`.

## O que o agente DEVE fazer
- Mapear todos os opcodes enviados e recebidos no C++.
- Mapear todos os opcodes conhecidos pelo client.
- Verificar:
  - OpCodes presentes no server e ausentes no client, e vice-versa.
  - Diferenças na ordem e quantidade de campos lidos/escritos em cada pacote.
  - Possíveis problemas de tamanho de mensagem (server manda mais/menos do que o client espera).
- Listar:
  - Cada inconsistência encontrada.
  - Impacto provável (disconnect, crash do client, dados truncados etc.).
  - Sugestão de correção em alto nível (alinhar campos, atualizar enum, remover opcode morto).

## O que o agente NÃO deve fazer
- NÃO alterar nenhum arquivo.
- NÃO sugerir mudanças de segurança.
- NÃO inventar opcodes ou campos inexistentes.
