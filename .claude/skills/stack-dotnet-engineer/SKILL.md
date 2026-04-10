---
name: stack-dotnet-engineer
description: Atua como engenheiro .NET implementando soluções conforme TheCleanArch (hibex-solutions.github.io/TheCleanArch)
allowed-tools: Bash, Read, Write, Edit, Glob, Grep
---

Atue como engenheiro .NET e implemente a solução seguindo estritamente as convenções do guia _TheCleanArch_ da Hibex Solutions. Antes de qualquer ação:

1. Leia `docs/SOLUTION.md` para entender o contexto e os componentes da solução que deve ser construída.
2. Leia a **seção de stack tecnológica** em `docs/SOLUTION.md` (normalmente ao final do arquivo). Essa seção é a fonte de verdade para: tecnologias adotadas, versões, decisões de implementação invioláveis e convenções de nomenclatura. Siga-as rigorosamente.

> **Templates:** Leia todos os arquivos em `.claude/skills/stack-dotnet-engineer/templates/` antes de iniciar qualquer implementação. Esses arquivos são os templates de referência que devem ser usados como base para gerar o código real — substituindo os placeholders `{Projeto}`, `{Solução}`, `{Prefix}` etc. pelos valores corretos do projeto.

> **Pré-requisito:** Os templates TheCleanArch devem estar instalados no ambiente antes de usar os comandos `dotnet new tca-*`. Instale com: `dotnet new install TheCleanArch.Templates`

---

## Estrutura de diretórios da solução

Toda solução .NET no estilo TheCleanArch deve ter a seguinte estrutura na raiz:

```
./
├─ docs/
├─ eng/
├─ samples/
├─ src/
├─ test/
├─ .editorconfig
├─ .gitignore
├─ {Solução}.slnx
├─ dotnet-tools.json
├─ global.json
├─ nuget.config
└─ omnisharp.json
```

**Entendendo:**
- `docs/` — documentação da solução
- `eng/` — programas e scripts de engenharia (CI/CD, automações)
- `samples/` — exemplos de uso
- `src/` — código-fonte dos componentes (.csproj)
- `test/` — projetos de teste
- `dotnet-tools.json` — manifesto de ferramentas .NET (gerado na raiz por `dotnet new tool-manifest`)
- `global.json` — versão explícita do SDK .NET (template: `templates/global.json`)
- `nuget.config` — configurações de feeds NuGet
- `omnisharp.json` — configuração do servidor de linguagem (independência de IDE)

---

## Camadas arquiteturais

A solução tem **3 ou mais camadas**: 2 obrigatórias de negócio + 1 ou mais adaptadores.

### Camada Enterprise (Entities)
- Nome do projeto: `{Prefix}.Business.Entities`
- Diretório: `src/Business/Entities/`
- Pacote TheCleanArch: `TheCleanArch.Enterprise --prerelease`
- Não depende de nenhuma outra camada da solução (camada mais interna)

### Camada Application (UseCases)
- Nome do projeto: `{Prefix}.Business.UseCases`
- Diretório: `src/Business/UseCases/`
- Pacote TheCleanArch: `TheCleanArch.Application --prerelease`
- Depende apenas de Enterprise

### Camada InterfaceAdapters
- Podem existir **quantos componentes adaptadores forem necessários**, todos pertencentes à mesma camada
- Nome de cada componente: `{Prefix}.InterfaceAdapters.{AdapterName}`
- Pacote TheCleanArch (todos): `TheCleanArch.InterfaceAdapter --prerelease`
- Dependem de Application (e Enterprise quando necessário; adaptadores também podem depender entre si)

**Exemplos de nomes de adaptadores (`{AdapterName}`):**
- Acesso a dados: `Data.MongoDB`, `Data.EFPostgres`, `Data.RedisCache`
- Interface de usuário: `UI.WebApi` (Web API), `UI.WebApp` (Blazor), `UI.CliApp`
- Gateways externos: `Gateways.GitHub`, `Gateways.Stripe`
- Workers: `Workers.PaymentProcessor`

**Diretórios em `src/InterfaceAdapters/`** usam o `{AdapterName}` com ponto como separador de pasta:
```
src/InterfaceAdapters/
├─ Data.MongoDB/
├─ UI.WebApi/
└─ Gateways.Stripe/
```

**Combinação de diretórios:** Quando há apenas 1 componente em uma categoria, combine os diretórios:
```
# Antes (múltiplos componentes)
src/Business/Entities/
src/Business/UseCases/

# Depois (componente único)
src/Business.UseCases/
src/InterfaceAdapters.UI.WebApi/
```

---

## Arquivos mínimos por componente

Todo projeto em `src/` deve conter **no mínimo 3 arquivos**:

### `{ComponentName}.csproj`
Use como base o template `.claude/skills/stack-dotnet-engineer/templates/component.csproj`.
Para projetos Web API (`UI.WebApi`) use `dotnet new tca-webapi` — o template já inclui os pacotes `TheCleanArch.InterfaceAdapter` e `Microsoft.AspNetCore.OpenApi`.
Remova `<ImplicitUsings>` e `<Nullable>` do arquivo `.csproj` gerado — essas propriedades ficam no `Directory.Build.props` global.

### `AssemblyInfo.cs`
Identifica a camada a que o componente pertence. Use o template correspondente:
- Enterprise: `.claude/skills/stack-dotnet-engineer/templates/AssemblyInfo.enterprise.cs`
- Application: `.claude/skills/stack-dotnet-engineer/templates/AssemblyInfo.application.cs`
- InterfaceAdapter: `.claude/skills/stack-dotnet-engineer/templates/AssemblyInfo.interfaceadapter.cs`

### `Usings.cs`
Declara `global using` de forma **explícita** — nunca use `<ImplicitUsings>enable`. Use o template correspondente ao tipo do componente:
- Camadas de negócio (Entities e UseCases): `.claude/skills/stack-dotnet-engineer/templates/Usings.business.cs`
- Web API (`UI.WebApi`): `.claude/skills/stack-dotnet-engineer/templates/Usings.webapi.cs`

---

## `Directory.Build.props` (raiz da solução)

Use como base o template `.claude/skills/stack-dotnet-engineer/templates/Directory.Build.props`.
Substitua `{Solução}` pelo nome real da solução.

---

## Header de licença

Todo arquivo de código deve começar com o aviso de licença (já presente nos templates):

```
// Copyright (c) {Projeto}. All rights reserved.
// Licensed under the Apache version 2.0: LICENSE file.
```

---

## Projetos de teste

### Nomenclatura
`{Prefix}.{Category}.{TestComponentName}` — **sem ponto** antes do sufixo do tipo de teste.

Sufixos: `UnitTests`, `IntegrationTests`, `EndToEndTests`, `LoadTests`

**Exemplos:**
- `Hibex.Age.Business.EntitiesUnitTests`
- `Hibex.Age.Business.UseCasesUnitTests`
- `Hibex.Age.InterfaceAdapters.Data.MongoDBIntegrationTests`
- `Hibex.Age.InterfaceAdapters.UI.WebApiLoadTests`

### Estrutura mínima para um projeto de teste

```
test/{Category}/{TestComponentName}/
├─ {Prefix}.{Category}.{TestComponentName}.csproj
├─ AssemblyInfo.cs
└─ Usings.cs
```

Podem existir **quantos componentes de teste forem necessários**, cada um em seu próprio diretório.

### `AssemblyInfo.cs` para projetos de teste
Projetos de teste pertencem à camada **External**. Use o template:
`.claude/skills/stack-dotnet-engineer/templates/AssemblyInfo.external.cs`

### `Usings.cs` para projetos de teste
Use o template `.claude/skills/stack-dotnet-engineer/templates/Usings.tests.cs`.

### `.csproj` de teste
Use como base o template `.claude/skills/stack-dotnet-engineer/templates/test.csproj`.
Remova `<ImplicitUsings>` e `<Nullable>` (ficam no `Directory.Build.props`).
O template já inclui as referências a `TheCleanArch.Core`, `TUnit` e `Moq`.

O arquivo `Program.cs` gerado automaticamente deve ser removido — TUnit já fornece o entry point.

### Convenções de nomenclatura de testes (TUnit)
- Nomes de método em **PascalCase** — nunca com sublinhados separadores
- Use `[Arguments(DisplayName = "...")]` para nomear casos de teste
- Use `[Arguments(...)]` para testes data-driven
- Use `[Skip("...")]` para ignorar testes demonstrativos

### `global.json` — adicionar runner de testes
Use o template `.claude/skills/stack-dotnet-engineer/templates/global.json`.
Ajuste a versão do SDK conforme a versão instalada no ambiente (`dotnet --version`).

---

## Criando uma nova solução do zero

Ao criar uma solução nova do zero, leia `.claude/skills/stack-dotnet-engineer/creation-sequence.md` para obter a sequência completa de passos com os comandos necessários.

---

## Referências

- Guia oficial: https://hibex-solutions.github.io/TheCleanArch/
- Repositório GitHub: https://github.com/Hibex-Solutions/TheCleanArch
- Documentação oficial ASP.NET Core: https://learn.microsoft.com/pt-br/aspnet/core/overview
