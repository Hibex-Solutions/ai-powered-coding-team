# Guia de Contribuição

Este documento descreve as responsabilidades e ações esperadas de cada perfil que contribui com este projeto.

Toda contribuição deve respeitar as regras definidas em `docs/ARCHITECTURE.md`, em especial as *Regras primárias invioláveis*.

---

## Arquiteto de soluções

**Documentos sob sua responsabilidade:** `docs/ARCHITECTURE.md`, `docs/SOLUTION.md`, `docs/GOAL.md`

**Ações esperadas:**

- Manter `docs/GOAL.md` sempre preenchido com a fase atual, a meta em curso e os critérios de aceite (nunca no estado de template vazio).
- Validar a arquitetura com a IA — revisar aderência às regras primárias invioláveis antes de qualquer mudança estrutural.
- Usar `/c4model-architectural-designer` para criar e manter os diagramas C4Model em `docs/solution/`, documentando contexto, containers e componentes da solução.
- Manter `docs/SOLUTION.md` atualizado conforme a solução evolui, garantindo que componentes e tecnologias adotados estejam documentados.
- Garantir que nenhuma tecnologia ou componente seja adotado sem estar registrado no desenho de solução.
- Usar `/architect-reviewer` para validar conformidade com `docs/ARCHITECTURE.md` e os doze fatores antes de mudanças estruturais ou de release.

---

## Analista de negócio

**Documentos sob sua responsabilidade:** `docs/BUSINESS.md`

**Ações esperadas:**

- Documentar regras de negócio em `docs/BUSINESS.md` antes de qualquer implementação de funcionalidade.
- Garantir que toda funcionalidade proposta tenha correspondência negocial documentada.
- Usar `/business-reviewer` para validar cobertura de todas as regras em `docs/BUSINESS.md` pela implementação e pelos testes.

---

## Designer

**Documentos sob sua responsabilidade:** `docs/GUIDELINE.md`

**Ações esperadas:**

- Documentar padrões visuais, de marca e de experiência do usuário em `docs/GUIDELINE.md`.
- Atualizar o Guideline sempre que houver evolução nas diretrizes de marca ou UX.
- Garantir que nenhum comportamento de interface viole as regras estabelecidas no Guideline.
- Usar `/guideline-reviewer` para validar conformidade das interfaces com `docs/GUIDELINE.md`.

---

## Engenheiro de Software

**Responsabilidade:** código em `src/` e `test/`.

**Ações esperadas:**

- Iniciar o assistente de IA (ex.: `claude` para Claude Code) somente após as especificações estarem documentadas (`ARCHITECTURE.md`, `SOLUTION.md`, `BUSINESS.md` e `GUIDELINE.md` preenchidos para o escopo em questão).
- Delegar a implementação à IA, revisando e validando cada entrega antes de commitar.
- Garantir que toda implementação tenha cobertura de testes baseada nas regras de negócio documentadas.
- Nunca commitar código sem revisão — a IA propõe, o engenheiro decide.
- Quando o projeto tiver sido inicializado com uma stack específica, usar a skill de engenheiro correspondente (ver tabela abaixo) para manter a implementação aderente às convenções da stack.

---

## Skills disponíveis

Cada skill faz a IA assumir um perfil especializado — não são comandos avulsos, mas contextos de atuação que a IA assume durante a sessão. Para ativar, use `/nome-da-skill` no seu assistente de IA.

| Skill | Perfil assumido | Disponibilidade |
|---|---|---|
| `/c4model-architectural-designer` | Designer de arquitetura — cria diagramas C4Model com sintaxe Mermaid em `docs/solution/` | Sempre |
| `/architect-reviewer` | Arquiteto revisor — valida conformidade com `docs/ARCHITECTURE.md` e os doze fatores | Sempre |
| `/business-reviewer` | Revisor de negócio — valida cobertura das regras em `docs/BUSINESS.md` | Sempre |
| `/guideline-reviewer` | Revisor de UX — valida conformidade das interfaces com `docs/GUIDELINE.md` | Sempre |
| `/aspnet-engineer` | Engenheiro ASP.NET — implementa componentes seguindo a arquitetura limpa (TheCleanArch) | Somente se inicializado com `--stack aspnet` |

> Skills marcadas como stack-específicas são incluídas no projeto apenas quando o script de inicialização do framework foi executado com a opção `--stack <nome>` correspondente. Se a stack não foi selecionada no início do projeto, a skill não estará disponível.
