# Sequência de criação da solução

Siga estes passos ao criar uma nova solução .NET Blazor do zero:

## Passo 1 — Estrutura de diretórios e arquivos essenciais

```sh
mkdir docs eng samples src test

dotnet new globaljson --sdk-version $(dotnet --version) --roll-forward feature
dotnet new nugetconfig
dotnet new gitignore
dotnet new editorconfig
dotnet new tool-manifest
```

## Passo 2 — Criar projetos de cada camada

```sh
# Business layers
mkdir src/Business
dotnet new classlib -n {Prefix}.Business.Entities -o src/Business/Entities
dotnet new classlib -n {Prefix}.Business.UseCases -o src/Business/UseCases

# InterfaceAdapters (um ou mais, conforme docs/SOLUTION.md)
mkdir src/InterfaceAdapters

# Para UI Blazor Web App usar:
dotnet new blazor -n {Prefix}.InterfaceAdapters.UI.WebApp -o src/InterfaceAdapters/UI.WebApp --interactivity None --auth None --all-interactive false
# Para outros adapters (dados, gateways, workers) usar classlib:
# dotnet new classlib -n {Prefix}.InterfaceAdapters.{AdapterName} -o src/InterfaceAdapters/{AdapterName}
```

## Passo 3 — `Directory.Build.props` e limpeza dos `.csproj`

Crie o `Directory.Build.props` na raiz (baseado em `templates/Directory.Build.props`) e remova `<ImplicitUsings>` e `<Nullable>` de todos os `.csproj` em `src/`.

## Passo 4 — Pacotes TheCleanArch por camada

**Confirme com o usuário antes de instalar.** Após confirmação:

```sh
# Entities
dotnet package add TheCleanArch.Enterprise --prerelease --project src/Business/Entities/{Prefix}.Business.Entities.csproj

# UseCases
dotnet package add TheCleanArch.Application --prerelease --project src/Business/UseCases/{Prefix}.Business.UseCases.csproj

# Cada InterfaceAdapter
dotnet package add TheCleanArch.InterfaceAdapter --prerelease --project src/InterfaceAdapters/{AdapterName}/{Prefix}.InterfaceAdapters.{AdapterName}.csproj
```

## Passo 5 — `AssemblyInfo.cs` e `Usings.cs`

Crie em cada projeto em `src/` os dois arquivos usando os templates de referência conforme definido no SKILL.md.

Para o projeto Blazor (`UI.WebApp`), use `templates/Usings.webapp.cs` ao invés de `Usings.business.cs`.

## Passo 6 — `_Imports.razor` no projeto Blazor

Crie o arquivo `_Imports.razor` no projeto `src/InterfaceAdapters/UI.WebApp/` com os namespaces específicos do projeto:

```razor
@using System.Net.Http
@using System.Net.Http.Json
@using Microsoft.AspNetCore.Components.Forms
@using Microsoft.AspNetCore.Components.Routing
@using Microsoft.AspNetCore.Components.Web
@using Microsoft.AspNetCore.Components.Web.Virtualization
@using {Prefix}.InterfaceAdapters.UI.WebApp
@using {Prefix}.InterfaceAdapters.UI.WebApp.Components
```

## Passo 7 — Dependências entre projetos

Configure as referências de acordo com as regras de dependência e o diagrama da solução:

```sh
dotnet add src/Business/UseCases/{Prefix}.Business.UseCases.csproj reference src/Business/Entities/{Prefix}.Business.Entities.csproj

dotnet add src/InterfaceAdapters/{AdapterName}/... reference src/Business/UseCases/{Prefix}.Business.UseCases.csproj
```

## Passo 8 — Arquivo de solução `.slnx`

```sh
dotnet new sln -n {Solução} -f slnx

dotnet sln add src/Business/Entities/{Prefix}.Business.Entities.csproj
dotnet sln add src/Business/UseCases/{Prefix}.Business.UseCases.csproj
dotnet sln add src/InterfaceAdapters/{AdapterName}/{Prefix}.InterfaceAdapters.{AdapterName}.csproj
# (repetir para todos os projetos)
```

## Passo 9 — Projetos de teste

**Confirme com o usuário antes de criar e instalar pacotes de teste.** Após confirmação:

```sh
mkdir test/{Category}
dotnet new console -n {Prefix}.{Category}.{TestComponentName} -o test/{Category}/{TestComponentName}

dotnet add test/{Category}/{TestComponentName}/{Prefix}.{Category}.{TestComponentName}.csproj package TUnit
dotnet add test/{Category}/{TestComponentName}/{Prefix}.{Category}.{TestComponentName}.csproj package Moq

# Remover Program.cs gerado (TUnit provê o entry point)
rm test/{Category}/{TestComponentName}/Program.cs

# Referenciar o componente alvo
dotnet add test/{Category}/{TestComponentName}/{Prefix}.{Category}.{TestComponentName}.csproj reference src/...

# Adicionar à solução
dotnet sln add test/{Category}/{TestComponentName}/{Prefix}.{Category}.{TestComponentName}.csproj
```

Crie o `Usings.cs` em cada projeto de teste usando o template `templates/Usings.tests.cs`.
Remova `<ImplicitUsings>` e `<Nullable>` dos `.csproj` em `test/`.

## Passo 10 — Runner de testes no `global.json`

Adicione o bloco `"test"` ao `global.json` conforme o template `templates/global.json`.
