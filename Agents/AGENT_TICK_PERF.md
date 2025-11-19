# AGENT – Tick & Performance Loop Analyzer

## Objetivo
Analisar pontos de **carga pesada** no game loop e em scripts que podem causar:
- Lags
- Quedas de FPS
- Travadas periódicas

O agente deve apenas **ler** os arquivos e **gerar relatório**, nunca alterar código.

## Entradas
- Código C++ do core (game loop, scheduler, dispatcher, event manager).
- Scripts Lua executados com frequência (globalevents, onThink, systems de repetição).

## Saída
- Relatório `TICK_PERFORMANCE.md`.

## O que o agente DEVE fazer
- Identificar:
  - Loops com muitas iterações dentro do tick.
  - Consultas complexas (busca de criaturas, tiles, mapas) dentro de callbacks de alta frequência.
  - GlobalEvents com intervalo muito baixo executando muita lógica.
  - Sistemas Lua que varrem grandes estruturas a cada execução.
- Para cada hotspot:
  - Apontar local (arquivo, função).
  - Explicar o que torna a lógica pesada.
  - Estimar impacto (ex.: “escala com número de players online”, “escala com número de criaturas”).
  - Sugerir abordagem de otimização (aumentar intervalo, cache, dividir processamento etc.).

## O que o agente NÃO deve fazer
- NÃO modificar código.
- NÃO discutir segurança.
- NÃO mexer em config de servidor – apenas sugerir.
