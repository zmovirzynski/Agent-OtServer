# Suite de Agentes de IA para Análise de OTServer

Análise automatizada de código para servidores Open Tibia usando Inteligência Artificial.

---

## O que é isso?

Este projeto usa **agentes de IA** para analisar automaticamente o código de servidores OTServer (como Poke Brave, TFS, Canary) e gerar relatórios profissionais sobre problemas, bugs e melhorias.

Pense nisso como contratar 7 consultores especializados que leem todo o seu código e te entregam relatórios detalhados sobre o que está errado e como corrigir.

## Para quem é?

- Desenvolvedores de OTServer que querem melhorar a qualidade do código
- Administradores que querem entender problemas técnicos do servidor
- Qualquer pessoa que trabalha com servidores Open Tibia e quer usar IA

**Não precisa ser expert em IA!** Este projeto foi feito para ser simples de usar.

---

## O que os agentes fazem?

Cada agente é especialista em uma área específica:

### 1. AGENT_PROTOCOL_SYNC
**O que faz:** Verifica se cliente e servidor estão conversando direito  
**Por que importa:** Evita desconexões e bugs de comunicação  
**Relatório gerado:** `PROTOCOL_SYNC.md`

### 2. AGENT_LUA_STATIC
**O que faz:** Encontra erros em scripts Lua  
**Por que importa:** Scripts com erro não funcionam e podem crashar o servidor  
**Relatório gerado:** `LUA_ERRORS.md`

### 3. AGENT_CONTENT_INTEGRITY
**O que faz:** Valida arquivos XML (items, monstros, spells)  
**Por que importa:** Dados errados causam bugs estranhos no jogo  
**Relatório gerado:** `CONTENT_INTEGRITY.md`

### 4. AGENT_TICK_PERF
**O que faz:** Analisa performance do servidor  
**Por que importa:** Identifica o que causa lag e travamentos  
**Relatório gerado:** `TICK_PERFORMANCE.md`

### 5. AGENT_QUEST_STORAGE
**O que faz:** Verifica sistema de quests e storages  
**Por que importa:** Previne quests bugadas e progressão travada  
**Relatório gerado:** `QUEST_STORAGE_REPORT.md`

### 6. AGENT_CPP_CRASH_RISK
**O que faz:** Encontra código C++ que pode crashar  
**Por que importa:** Previne crashes inesperados do servidor  
**Relatório gerado:** `CPP_CRASH_RISKS.md`

### 7. AGENT_CODE_SMELL
**O que faz:** Identifica código mal feito  
**Por que importa:** Código ruim é difícil de manter e causa bugs  
**Relatório gerado:** `CODE_SMELLS.md`

---

## Como funciona?

### Processo Simples:

```
1. Você aponta os agentes para seu servidor
2. Agentes leem todo o código automaticamente
3. Cada agente analisa sua área de especialidade
4. Você recebe 7 relatórios profissionais
5. Relatórios mostram problemas e como corrigir
```

### Tempo de Execução:

- Análise manual: 40-50 horas
- Com agentes: 20-30 minutos

### O que você recebe:

7 documentos em Markdown com:
- Lista de problemas encontrados
- Localização exata (arquivo e linha)
- Explicação do que está errado
- Sugestão de como corrigir
- Prioridade (crítico, médio, baixo)

---

## Estrutura do Projeto

```
.
├── Agents/                          # Definições dos agentes
│   ├── ORCHESTRATOR.md             # Coordenador dos agentes
│   ├── AGENT_PROTOCOL_SYNC.md      # Agente de protocolo
│   ├── AGENT_LUA_STATIC.md         # Agente de Lua
│   ├── AGENT_CONTENT_INTEGRITY.md  # Agente de conteúdo
│   ├── AGENT_TICK_PERF.md          # Agente de performance
│   ├── AGENT_QUEST_STORAGE.md      # Agente de quests
│   ├── AGENT_CPP_CRASH_RISK.md     # Agente de crashes
│   ├── AGENT_CODE_SMELL.md         # Agente de qualidade
│   └── AGENT_ARCHITECTURE_DOC.md   # Agente de documentação
│
├── pokebrave-server-main/          # Exemplo: código do servidor
│   ├── src/                        # Código C++
│   └── data/                       # Scripts Lua e XML
│
├── PROTOCOL_SYNC.md                # Relatório de protocolo
├── LUA_ERRORS.md                   # Relatório de erros Lua
├── CONTENT_INTEGRITY.md            # Relatório de conteúdo
├── TICK_PERFORMANCE.md             # Relatório de performance
├── QUEST_STORAGE_REPORT.md         # Relatório de quests
├── CPP_CRASH_RISKS.md              # Relatório de crashes
├── CODE_SMELLS.md                  # Relatório de qualidade
├── ARCHITECTURE_GUIDE.md           # Guia de arquitetura
└── GUIA_AGENTES_IA_PARA_INICIANTES.txt  # Tutorial completo
```

---

## Como Usar

### Opção 1: Usar com Kiro IDE (Recomendado)

Kiro IDE já tem sistema de agentes integrado:

1. Abra seu projeto no Kiro IDE
2. Coloque a pasta `Agents/` no seu projeto
3. Execute o orquestrador
4. Aguarde os relatórios serem gerados

### Opção 2: Usar com outra ferramenta de IA

1. Copie as definições dos agentes da pasta `Agents/`
2. Configure sua ferramenta de IA (LangChain, AutoGPT, etc.)
3. Aponte para seu servidor
4. Execute os agentes

### Opção 3: Adaptar para seu caso

Os agentes são apenas instruções em Markdown. Você pode:
- Modificar as regras
- Adicionar novos agentes
- Remover agentes que não precisa
- Customizar para seu servidor

---

## Exemplo de Uso Real

### Antes dos Agentes:

```
Você: "O servidor está crashando às vezes, não sei por quê"
Processo:
1. Passar horas debugando
2. Testar várias hipóteses
3. Talvez encontrar o problema
4. Talvez não encontrar

Tempo: Dias ou semanas
Resultado: Incerto
```

### Depois dos Agentes:

```
Você: "Vou rodar os agentes"
Processo:
1. Executar agentes (30 minutos)
2. Ler relatório CPP_CRASH_RISKS.md
3. Ver: "Null pointer em game.cpp linha 310"
4. Corrigir em 5 minutos

Tempo: 35 minutos
Resultado: Problema resolvido
```

---

## Benefícios Reais

### Economia de Tempo
- Análise manual: 50 horas
- Com agentes: 3 horas
- **Economia: 94%**

### Prevenção de Problemas
- Encontra bugs antes de afetar players
- Identifica problemas de performance
- Previne crashes

### Qualidade do Código
- Código mais limpo
- Menos bugs
- Mais fácil de manter

### Servidor Mais Estável
- Menos crashes
- Menos lag
- Players mais felizes

---

## Documentação Incluída

### Para Iniciantes:

**GUIA_AGENTES_IA_PARA_INICIANTES.txt**
- O que são agentes de IA
- Por que usar
- Como funcionam
- Tutorial passo a passo
- Exemplos práticos

### Para Desenvolvedores:

**ARCHITECTURE_GUIDE.md**
- Como funciona um OTServer
- Estrutura do código
- Fluxos de execução
- Exemplos de código
- Glossário de termos

### Relatórios de Exemplo:

Todos os 7 relatórios estão incluídos como exemplo, mostrando:
- Formato dos relatórios
- Tipo de análise feita
- Como interpretar resultados

---

## Perguntas Frequentes

### Preciso saber programar?

Não precisa ser expert, mas ajuda entender o básico de:
- Como funciona um OTServer
- Estrutura de arquivos (C++, Lua, XML)
- Como ler relatórios técnicos

### Os agentes corrigem o código automaticamente?

Não. Os agentes apenas **analisam** e **reportam** problemas. Você decide o que corrigir e como.

### É seguro? Meu código vai para onde?

Depende da ferramenta que usar:
- Kiro IDE: Código processado localmente quando possível
- APIs de IA: Código enviado para processamento (OpenAI, etc.)
- Solução própria: Você controla tudo

**Recomendação:** Não use com código super secreto ou proprietário sensível.

### Funciona com qualquer OTServer?

Sim! Funciona com:
- TFS (The Forgotten Server)
- Canary
- OTX
- Nostalrius
- Qualquer fork baseado em OTServer

Pode precisar ajustar algumas regras para seu caso específico.

### Posso modificar os agentes?

Sim! Os agentes são apenas arquivos Markdown com instruções. Você pode:
- Modificar regras existentes
- Adicionar novos agentes
- Remover o que não precisa
- Adaptar para seu servidor

### Preciso executar todos os 7 agentes?

Não. Execute apenas os que fazem sentido para você:
- Só quer analisar Lua? Execute AGENT_LUA_STATIC
- Só quer ver performance? Execute AGENT_TICK_PERF
- Quer análise completa? Execute todos

---

## Limitações

### O que os agentes NÃO fazem:

- Não executam código
- Não testam funcionalidades
- Não corrigem automaticamente
- Não entendem contexto de negócio
- Não substituem desenvolvedor

### O que você ainda precisa fazer:

- Validar os relatórios
- Decidir o que corrigir
- Implementar correções
- Testar mudanças

### Cuidados:

- Nem tudo que os agentes apontam é problema real
- Use bom senso ao aplicar sugestões
- Valide antes de aplicar em produção
- Mantenha backup do código original

---

## Contribuindo

Quer melhorar os agentes? Contribuições são bem-vindas!

### Como contribuir:

1. Fork este repositório
2. Crie um branch para sua feature
3. Faça suas modificações
4. Teste com seu servidor
5. Envie um Pull Request

### Ideias de contribuição:

- Novos agentes especializados
- Melhorias nas regras existentes
- Correções de bugs nos relatórios
- Documentação adicional
- Exemplos de uso

---

## Licença

Este projeto é open source. Use, modifique e distribua livremente.

Os relatórios de exemplo foram gerados a partir de código open source (TFS/Canary).

---

## Suporte

### Problemas ou Dúvidas?

- Abra uma Issue no GitHub
- Consulte a documentação incluída

---

## Agradecimentos

Este projeto foi criado para ajudar a comunidade de OTServer a usar IA de forma prática e efetiva.

Agradecimentos especiais a:
- Comunidade Open Tibia
- Desenvolvedores do TFS e Canary
- Todos que contribuem com código open source

---

## Versão

**Versão:** 1.0  
**Data:** 2025 
**Status:** Estável e pronto para uso

---

## Começe Agora

1. Clone este repositório
2. Escolha uma ferramenta de IA
3. Execute os agentes no seu servidor
4. Leia os relatórios
5. Corrija os problemas
6. Tenha um servidor melhor!

**Boa sorte e bom código!**
