Esta especificação documenta as decisões de stack tecnológica para projetos baseados em ASP.NET.
As definições abaixo são vinculantes para toda a implementação.

---

### Tecnologias adotadas

| Camada | Tecnologia | Versão mínima |
|---|---|---|
| Runtime | .NET | 10 |
| Linguagem | C# | 13 |
| Web API — OpenAPI | Microsoft.AspNetCore.OpenApi | 10.x |
| UI Framework (Blazor) | Blazor Web App | .NET 10 |
| Testes — Framework | TUnit | 1.x |
| Testes — Mocking | Moq | 4.x |
| Testes — Runner | Microsoft.Testing.Platform | última estável |
| Arquitetura | TheCleanArch (Hibex Solutions) | 0.1.0-rc* |

> As tecnologias de UI são opcionais e dependem dos adapters escolhidos para a solução.

---

### Estrutura de arquivos raiz

Todo projeto ASP.NET gerado a partir deste template deve ter os seguintes arquivos na raiz:

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

**Adapters de interface de usuário disponíveis nesta stack:**
- `UI.WebApi` — Web API REST com OpenAPI (use `dotnet new tca-webapi`)
- `UI.WebApp` — Blazor Web App (use `dotnet new tca-webapp`)

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
6. **Web API com OpenAPI** — o adaptador `UI.WebApi` inclui `Microsoft.AspNetCore.OpenApi`; o endpoint `MapOpenApi()` é mapeado apenas em ambiente de desenvolvimento
7. **Blazor Web App** — usar `dotnet new tca-webapp` para o projeto de UI Blazor; nunca `dotnet new blazorserver` ou `dotnet new blazorwasm` isolados
8. **BlazorDisableThrowNavigationException** — projetos Blazor devem ter `<BlazorDisableThrowNavigationException>true</BlazorDisableThrowNavigationException>` no `.csproj`
9. **Reconexão e rotas ausentes** — apps Blazor devem ter o componente `ReconnectModal` e a página `NotFound` para tratamento de desconexão e rotas inválidas
10. **Testes na camada External** — projetos de teste declaram `[assembly: ArchLayer(External, ...)]` no `AssemblyInfo.cs`; nomes de métodos de teste em PascalCase (sem sublinhados)
11. **Templates TheCleanArch** — use `dotnet new tca-webapi` para Web API, `dotnet new tca-webapp` para Blazor e `dotnet new tca-unittest` para testes; requer `TheCleanArch.Templates` instalado

---

### Skill disponível

Use `/aspnet-engineer` no Claude Code para delegar a implementação ao engenheiro ASP.NET especializado.
Essa skill conhece as convenções TheCleanArch e os templates de projeto desta stack.
