---
title: "Instalação"
weight: 1
---

{{% card title="Pré-requisitos" %}}
- Assistente de IA compatível instalado e configurado (ex: [Claude Code](https://www.anthropic.com/claude-code))
- [Git](https://git-scm.com) instalado localmente
- PowerShell 5.1 ou superior — nativo no Windows 10+; necessário apenas para usuários Windows
- Conhecimento sólido de engenharia de software (o modelo foi projetado para profissionais sênior)
{{% /card %}}

{{% card title="Iniciando um novo projeto" %}}

{{% step num="1" title="Instale o template" %}}
**Linux / macOS (bash):**

```bash
# Sem stack (agnóstico — você define a tecnologia depois)
curl -fsSL https://hibex-solutions.github.io/ai-powered-coding-team/install.sh | bash -s -- meu-projeto

# Com stack ASP.NET (Web API, Blazor e outros componentes .NET)
curl -fsSL https://hibex-solutions.github.io/ai-powered-coding-team/install.sh | bash -s -- meu-projeto --stack aspnet
```

**Windows (PowerShell 5.1+):**

```powershell
# Sem stack (agnóstico — você define a tecnologia depois)
& ([ScriptBlock]::Create((irm https://hibex-solutions.github.io/ai-powered-coding-team/install.ps1))) meu-projeto

# Com stack ASP.NET (Web API, Blazor e outros componentes .NET)
& ([ScriptBlock]::Create((irm https://hibex-solutions.github.io/ai-powered-coding-team/install.ps1))) meu-projeto -Stack aspnet
```

> **Versão específica (bash):** use `--version <tag>` — ex: `meu-projeto --version v0.1.0-alpha8 --stack aspnet`
>
> **Versão específica (PowerShell):** use `-Version <tag>` — ex: `meu-projeto -Version v0.1.0-alpha8 -Stack aspnet`
>
> **Stack inválida:** o script falha imediatamente e lista as stacks disponíveis na versão solicitada.
{{% /step %}}

{{% step num="2" title="Configure o Git e faça o primeiro commit" %}}
```bash
cd meu-projeto

# Configure o Git local (obrigatório — não use as configurações globais)
git config user.name "Seu Nome"
git config user.email "seu@email.com"

git add .
git commit -m "chore: inicializa projeto a partir do template"
```
{{% /step %}}

{{% step num="3" title="Especifique antes de implementar" %}}
Antes de qualquer linha de código, documente os cinco artefatos seguindo o fluxo de quatro etapas: **engenheiro (objetivo) → analista (problema) → projeção paralela por designer e arquiteto (marca + arquitetura + solução) → engenheiro (implementação)**. `BUSINESS.md` descreve o **problema**; `GUIDELINE.md`, `ARCHITECTURE.md` e `SOLUTION.md` são elaborados em conjunto na etapa de projeção, coordenando marca/UX, regras arquiteturais e solução técnica.

```
docs/GOAL.md          ← etapa 1 — objetivo, fase e critérios de aceite (engenheiro)
docs/BUSINESS.md      ← etapa 2 — problema e regras de negócio (analista)
docs/GUIDELINE.md     ↰
docs/ARCHITECTURE.md  ├─ etapa 3 (projeção, paralela) — marca/UX, regras arquiteturais e solução (designer + arquiteto)
docs/SOLUTION.md      ↲
                      → etapa 4 — implementação em src/ e test/ (engenheiro)
```
{{% /step %}}

{{% step num="4" title="Delegue para a IA" %}}
Com as especificações em mãos, inicie seu assistente de IA (ex: `claude` para Claude Code):

```bash
claude
```

O `CLAUDE.md` do projeto já instrui a IA com as regras arquiteturais, a especificação negocial e as diretrizes de marca — sem necessidade de repetir contexto a cada sessão.
{{% /step %}}

{{% /card %}}
