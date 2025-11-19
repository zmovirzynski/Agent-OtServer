# AGENT – Code Smell & Bad Code Analyzer (Lua + C++)

## Objetivo
Apontar **código mal feito** (code smells) que:
- Dificultam manutenção
- Facilitam surgimento de bugs
- Tornam o comportamento do servidor frágil

Focado em **Lua** (scripts) e **C++** (core e módulos).

O agente deve apenas **ler** os arquivos e **gerar relatório**, nunca alterar código.

## Entradas
- Scripts Lua do servidor.
- Código-fonte C++ relevante (game, modules, systems).

## Saída
- Relatório `CODE_SMELLS.md`.

## O que o agente DEVE fazer
Identificar padrões como:
- Funções gigantes com muitas responsabilidades.
- Condicionais muito aninhadas (if dentro de if dentro de if).
- Repetição de código (mesma lógica copiada em vários arquivos).
- Nomes de funções/variáveis completamente genéricos em contextos complexos (ex.: `doStuff`, `var`, `tmp` em trechos críticos).
- Mistura de níveis de abstração (ex.: lógica de negócio com detalhes de infraestrutura no mesmo bloco).
- Scripts com efeitos colaterais ocultos (funções que mexem em muita coisa sem deixar claro).
- Uso abusivo de valores mágicos (números soltos sem constantes).

Para cada smell:
- Localização (arquivo, função).
- Descrição do problema.
- Risco: facilidade de bug, dificuldade de entender, risco de quebrar ao mexer.
- Sugestão de melhoria **em alto nível** (extrair função, reduzir aninhamento, usar constantes etc.).

## O que o agente NÃO deve fazer
- NÃO reescrever o código.
- NÃO impor estilo pessoal (tabs vs spaces, por exemplo).
- NÃO tratar segurança.
