## Stack tecnológica: .NET Blazor

Esta seção documenta as decisões de stack tecnológica para projetos baseados em .NET Blazor.
As definições abaixo complementam a especificação agnóstica de `SOLUTION.md` e são
vinculantes para toda a implementação.

---

### Tecnologias adotadas

| Camada | Tecnologia | Versão mínima |
|---|---|---|
| Runtime | .NET | 10 |
| Linguagem | C# | 13 |
| UI Framework | Blazor Web App | .NET 10 |
| Testes — Framework | TUnit | 1.x |
| Testes — Mocking | Moq | 4.x |
| Testes — Runner | Microsoft.Testing.Platform | última estável |
| Arquitetura | TheCleanArch (Hibex Solutions) | 0.1.0-rc* |

---

### Estrutura de arquivos raiz

Todo projeto .NET Blazor gerado a partir deste template deve ter os seguintes arquivos na raiz:

```
./
├─ {Solução}.slnx            ← arquivo de solução .NET (formato XML moderno)
├─ global.json               ← versão explícita do SDK .NET
├─ Directory.Build.props     ← propriedades globais de build
├─ nuget.config              ← configuração de feeds NuGet
├─ omnisharp.json            ← configuração do servidor de linguagem (independência de IDE)
└─ dotnet-tools.json         ← manifesto de ferramentas .NET locais
```

---

### Camadas arquiteturais

A solução segue o padrão TheCleanArch com **3 ou mais camadas**:

| Camada | Namespace | Diretório | Pacote NuGet |
|---|---|---|---|
| Enterprise (Entities) | `{Prefix}.Business.Entities` | `src/Business/Entities/` | `TheCleanArch.Enterprise --prerelease` |
| Application (UseCases) | `{Prefix}.Business.UseCases` | `src/Business/UseCases/` | `TheCleanArch.Application --prerelease` |
| InterfaceAdapters (×N) | `{Prefix}.InterfaceAdapters.{Nome}` | `src/InterfaceAdapters/{Nome}/` | `TheCleanArch.InterfaceAdapter --prerelease` |

O adapter de interface de usuário padrão para esta stack é `UI.WebApp` (Blazor Web App).

> Quando um componente é único em sua categoria, os diretórios podem ser combinados.
> Ex: `src/Business.UseCases/` ao invés de `src/Business/UseCases/`.

---

### Convenção de nomenclatura de projetos de teste

```
{Prefix}.{Categoria}.{ComponenteTestado}{TipoTeste}
```

Sufixos válidos: `UnitTests`, `IntegrationTests`, `EndToEndTests`, `LoadTests`

---

### Decisões de implementação invioláveis

1. **SDK explícito** — `global.json` com versão fixada; nunca depender da versão global instalada
2. **Sem implicit usings** — `<ImplicitUsings>disable</ImplicitUsings>` no `Directory.Build.props`; cada projeto declara seus `global using` em `Usings.cs`
3. **Abstração de tempo** — use `TimeProvider` (.NET 8+); nunca `DateTime.UtcNow` ou `DateTime.Now` diretamente
4. **Licença no código** — todo arquivo `.cs` deve começar com o cabeçalho de licença Apache 2.0
5. **Independência de IDE** — configurar `omnisharp.json` e `.editorconfig`; nunca depender de recursos exclusivos de um editor
6. **Blazor Web App** — usar `dotnet new tca-webapp` para o projeto de UI; nunca `dotnet new blazorserver` ou `dotnet new blazorwasm` isolados
7. **BlazorDisableThrowNavigationException** — o projeto Blazor deve ter `<BlazorDisableThrowNavigationException>true</BlazorDisableThrowNavigationException>` no `.csproj`
8. **Reconexão e rotas ausentes** — o app Blazor deve ter o componente `ReconnectModal` e a página `NotFound` para tratamento de desconexão e rotas inválidas
9. **Testes na camada External** — projetos de teste declaram `[assembly: ArchLayer(External, ...)]` no `AssemblyInfo.cs`; nomes de métodos de teste em PascalCase (sem sublinhados)
10. **Templates TheCleanArch** — use `dotnet new tca-webapp` para Blazor e `dotnet new tca-unittest` para testes; requer `TheCleanArch.Templates` instalado

---

### Skill disponível

Use `/dotnetblazor-engineer` no Claude Code para delegar a implementação ao engenheiro .NET Blazor especializado.
Essa skill conhece as convenções TheCleanArch e os templates de projeto desta stack.
