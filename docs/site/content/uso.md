---
title: "Como usar"
weight: 2
---

{{% card title="Skills disponíveis" %}}
Cada skill faz o Claude assumir um perfil especializado. Para ativar, use `/nome-da-skill` numa sessão do Claude Code.

| Skill | Perfil assumido / Descrição |
|---|---|
| `/c4model-architectural-designer` | Atua como designer de arquitetura — cria diagramas C4Model com sintaxe Mermaid e salva em `docs/solution/` |
| `/architect-reviewer` | Atua como arquiteto revisor — valida conformidade com `ARCHITECTURE.md`, `SOLUTION.md` e os 12 fatores |
| `/business-reviewer` | Atua como revisor de negócio — valida conformidade entre `BUSINESS.md`, implementação e cobertura de testes |
| `/guideline-reviewer` | Atua como revisor de UX — valida conformidade entre `GUIDELINE.md` e as interfaces construídas |
| `/aspnet-engineer` | Atua como engenheiro ASP.NET — implementa componentes seguindo a arquitetura limpa (TheCleanArch) |
{{% /card %}}

{{% card title="Estrutura do projeto" %}}
O framework (repositório do template):

```
.
├── .claude/
│   ├── CLAUDE.md
│   └── skills/
│       ├── c4model-architectural-designer/   # skill genérica
│       ├── architect-reviewer/               # skill genérica
│       ├── business-reviewer/                # skill genérica
│       └── guideline-reviewer/               # skill genérica
│
├── stacks/
│   └── aspnet/                     # stack ASP.NET (Web API, Blazor, Workers...)
│       ├── docs/
│       └── skills/
│           └── aspnet-engineer/    # skill de stack
│
├── docs/
│   ├── GOAL.md
│   ├── ARCHITECTURE.md
│   ├── SOLUTION.md
│   ├── BUSINESS.md
│   ├── GUIDELINE.md
│   └── architecture/
│       └── 12factor/
│
├── src/
├── test/
├── eng/
├── samples/
├── CLAUDE.md
├── CONTRIBUTING.md
└── LICENSE
```

Após a inicialização com `--stack aspnet`:

```
meu-projeto/
├── .claude/
│   └── skills/
│       ├── c4model-architectural-designer/   # skills genéricas incluídas
│       ├── architect-reviewer/
│       ├── business-reviewer/
│       ├── guideline-reviewer/
│       └── aspnet-engineer/                  # skill da stack
│
├── docs/
│   ├── GOAL.md
│   ├── ARCHITECTURE.md
│   ├── SOLUTION.md             # base + conteúdo da stack mesclado
│   ├── BUSINESS.md
│   └── GUIDELINE.md
│
└── ...
```
{{% /card %}}
