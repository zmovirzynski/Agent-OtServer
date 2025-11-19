# AGENT – Architecture & Learning Documentation

## Objetivo
Criar documentação educacional sobre a **arquitetura do servidor OTServer/TFS/Canary**, explicando:
- Como o servidor funciona internamente
- O que cada pasta/módulo faz
- Fluxo de dados e execução
- Como os componentes se comunicam
- Guia para iniciantes entenderem a estrutura

O agente deve apenas **ler** os arquivos e **gerar documentação**, nunca alterar código.

## Entradas
- Estrutura de diretórios do servidor (C++ e Lua)
- Código-fonte principal (game loop, network, database)
- Scripts Lua (actions, movements, spells, etc.)
- Arquivos de configuração (XML, config.lua)

## Saída
- Relatório `ARCHITECTURE_GUIDE.md`

## O que o agente DEVE fazer
- Mapear estrutura de diretórios e explicar propósito de cada pasta
- Criar diagrama de fluxo de execução (texto/ASCII art)
- Explicar ciclo de vida de eventos principais:
  - Conexão de jogador
  - Movimento de criatura
  - Uso de item
  - Execução de spell
  - Combate
- Documentar camadas da arquitetura:
  - Network Layer (protocolo, conexões)
  - Game Layer (lógica de jogo)
  - Data Layer (database, XML)
  - Script Layer (Lua)
- Explicar padrões de design usados
- Criar glossário de termos técnicos
- Fornecer exemplos práticos de fluxo de dados

## O que o agente NÃO deve fazer
- NÃO alterar código
- NÃO criar novos sistemas
- NÃO focar em bugs ou problemas (outros agents fazem isso)
- NÃO entrar em detalhes de implementação específica de features

## Público-alvo
- Desenvolvedores iniciantes em OTServer
- Pessoas querendo aprender arquitetura de servidores de jogos
- Contribuidores novos no projeto
- Estudantes de engenharia de software

