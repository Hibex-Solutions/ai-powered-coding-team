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
│   └── CLAUDE.md                          # instruções para contribuir com o framework
│
├── docs/
│   ├── ARCHITECTURE.md                    # especificação do framework
│   └── site/                              # site público (Hugo)
│
├── eng/
│   ├── install.sh / install.ps1           # instalador do template no projeto consumidor
│   ├── release.sh / release.ps1           # empacota src/ em dist/
│   └── update-12factor.sh / .ps1
│
├── src/                                   # template distribuído em cada release
│   ├── .claude/
│   │   └── skills/
│   │       ├── c4model-architectural-designer/
│   │       ├── architect-reviewer/
│   │       ├── business-reviewer/
│   │       └── guideline-reviewer/
│   ├── stacks/
│   │   └── aspnet/
│   │       ├── docs/
│   │       └── skills/
│   │           └── aspnet-engineer/
│   ├── docs/
│   ├── eng/
│   └── CLAUDE.md, CONTRIBUTING.md, .gitignore
│
├── CLAUDE.md, CONTRIBUTING.md, LICENSE
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
