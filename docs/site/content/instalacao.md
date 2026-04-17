---
title: "Instalação"
weight: 1
---

{{% card title="Pré-requisitos" %}}
- [Claude Code](https://www.anthropic.com/claude-code) instalado e configurado
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
Antes de qualquer linha de código, documente:

```
docs/GOAL.md          ← fase atual, meta em curso e critérios de aceite
docs/ARCHITECTURE.md  ← decisões arquiteturais e regras invioláveis
docs/SOLUTION.md      ← componentes, tecnologias e desenho da solução
docs/BUSINESS.md      ← regras de negócio e requisitos funcionais
docs/GUIDELINE.md     ← padrões de marca, UI e UX
```
{{% /step %}}

{{% step num="4" title="Delegue para a IA" %}}
Com as especificações em mãos, inicie o Claude Code:

```bash
claude
```

O `CLAUDE.md` do projeto já instrui a IA com as regras arquiteturais, a especificação negocial e as diretrizes de marca — sem necessidade de repetir contexto a cada sessão.
{{% /step %}}

{{% /card %}}
