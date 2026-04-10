# Guia de Contribuição

Este documento descreve as responsabilidades e ações esperadas de cada perfil que contribui com o projeto.
Toda contribuição deve respeitar as regras definidas em `docs/ARCHITECTURE.md`.

---

## Arquiteto de soluções

**Documentos sob sua responsabilidade:** `docs/ARCHITECTURE.md`, `docs/SOLUTION.md`

**Ações esperadas:**

- Validar a arquitetura com o Claude Code — revisar aderência às regras primárias invioláveis antes de qualquer mudança estrutural
- Usar `/c4model-architectural-designer` para criar e manter os diagramas C4Model em `docs/solution/`, documentando contexto, containers e componentes da solução
- Atualizar as definições do Twelve-Factor App em `docs/architecture/12factor/` sempre que houver mudança na stack ou no modelo de implantação
- Manter `docs/SOLUTION.md` atualizado conforme a solução evolui, garantindo que componentes e tecnologias adotados estejam documentados
- Garantir que nenhuma tecnologia ou componente seja adotado sem estar registrado no desenho de solução

### Tarefas de engenharia disponíveis

| Script (Linux/macOS) | Script (Windows) | Descrição |
|---|---|---|
| `eng/update-12factor.sh` | `eng/update-12factor.ps1` | Atualiza os documentos de `docs/architecture/12factor/` a partir do repositório oficial `heroku/12factor` (pt_br). |

---

## Analista de negócio

**Documentos sob sua responsabilidade:** `docs/BUSINESS.md`

**Ações esperadas:**

- Documentar regras de negócio em `docs/BUSINESS.md` antes de qualquer implementação de funcionalidade
- Garantir que toda funcionalidade proposta tenha correspondência negocial documentada

---

## Designer

**Documentos sob sua responsabilidade:** `docs/GUIDELINE.md`

**Ações esperadas:**

- Documentar padrões visuais, de marca e de experiência do usuário em `docs/GUIDELINE.md`
- Atualizar o Guideline sempre que houver evolução nas diretrizes de marca ou UX
- Garantir que nenhum comportamento de interface viole as regras estabelecidas no Guideline

---

## Engenheiro de Software

**Documentos sob sua responsabilidade:** `src/`, `test/`

**Ações esperadas:**

- Iniciar o Claude Code (`claude`) somente após as especificações estarem documentadas
- Delegar a implementação à IA, revisando e validando cada entrega antes de commitar
- Garantir que toda implementação tenha cobertura de testes baseada nas regras de negócio
- Nunca commitar código sem revisão — a IA propõe, o engenheiro decide

### Skills disponíveis

Cada skill faz o Claude assumir um perfil especializado — não são comandos avulsos, mas contextos de atuação que a IA assume durante a sessão. Para ativar, use `/nome-da-skill` no Claude Code.

> Skills marcadas como dependentes de stack são incluídas no projeto somente quando o script de inicialização é executado com a opção `--stack <nome>` correspondente.

| Skill | Perfil assumido / Descrição |
|---|---|
| `/c4model-architectural-designer` | Atua como designer de arquitetura — cria diagramas C4Model com sintaxe Mermaid e salva em `docs/solution/` |
| `/architect-reviewer` | Atua como arquiteto revisor — valida conformidade com `docs/ARCHITECTURE.md` e os doze fatores |
| `/business-reviewer` | Atua como revisor de negócio — valida cobertura de todas as regras em `docs/BUSINESS.md` |
| `/guideline-reviewer` | Atua como revisor de UX — valida conformidade das interfaces com `docs/GUIDELINE.md` |
| `/aspnet-engineer` | Atua como engenheiro ASP.NET — implementa componentes seguindo a arquitetura limpa (TheCleanArch). Disponível apenas em projetos inicializados com `--stack aspnet`. |
| `/github-site-generator` | Atua como gerador de site — produz o GitHub Pages em `docs/site/` e atualiza o README |

