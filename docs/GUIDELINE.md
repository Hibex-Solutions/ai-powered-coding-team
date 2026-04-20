<!--
  Este arquivo é incluído no contexto do assistente de IA via diretiva @-include.
  Não use cabeçalhos H1 (#) nem H2 (##) — as seções devem iniciar em H3 (###).
-->

### Identidade da marca

- **Mantenedora:** Hibex Solutions (`github.com/hibex-solutions`).
- **Banner oficial:** `.github/assets/banner.png`. Utilizado no topo do `README.md`.
- **Paleta dos badges** (shields.io, estilo `flat-square`):
  - Licença MIT: `#4f6ef7`.
  - AI powered: `#a855f7`.
  - Contribuição bem-vinda: `#10b981`.
  - Open source: `#ff6b6b`.
- **Licença:** MIT. Copyright Hibex Solutions.

---

### Idioma e tom editorial

- Toda comunicação pública (README, site, documentos normativos, mensagens dos scripts) é em **português do Brasil**.
- Tom direto, técnico, imperativo. Sem floreios. Assuma leitor com sólido conhecimento de engenharia de software.
- Títulos de seções usam letra inicial maiúscula apenas na primeira palavra (ex.: "Início rápido", não "Início Rápido").
- Exemplos de comando em blocos *fenced* com anotação de linguagem (` ```bash `, ` ```powershell `).

---

### Agnosticismo à ferramenta de assistente de IA

- **Nunca** mencione ferramentas específicas de assistente de IA como requisito do framework, em qualquer documento normativo ou canal público.
- Em exemplos ilustrativos, use "assistente de IA" como termo genérico.
- Se for imprescindível ilustrar com uma ferramenta concreta, utilize o formato `(ex.: <nome>)` e mantenha a menção fora do corpo normativo.
- Essa regra se aplica aos cinco documentos da raiz, ao `README.md` e a todo o conteúdo de `docs/site/`.

---

### Convenção de includes

- Os cinco documentos normativos (`GOAL.md`, `ARCHITECTURE.md`, `SOLUTION.md`, `BUSINESS.md`, `GUIDELINE.md`) são inseridos no contexto do assistente de IA via diretiva `@` a partir de `.claude/CLAUDE.md`. Por isso:
  - **Não usar H1 (`#`) nem H2 (`##`)** nesses arquivos.
  - Cabeçalhos internos iniciam em `###` ou inferior.
  - É permitido começar o arquivo com um comentário HTML explicativo.
  - Um separador `---` entre seções pode ser usado para legibilidade.

---

### Estrutura do README

Ordem canônica das seções:

1. Banner.
2. Badges.
3. *Tagline* em citação (`>`).
4. Descrição curta do framework (parágrafo).
5. Seção **Início rápido** com três passos numerados:
   1. Instalar via `curl | bash`.
   2. Preencher os documentos normativos antes de qualquer linha de código.
   3. Iniciar o assistente de IA.
6. Seção **Documentação completa** com link para o site público.
7. Seção **Contribuindo** com link para `CONTRIBUTING.md`.
8. Seção **Licença**.
9. Assinatura final centralizada com link para a Hibex Solutions.

Blocos de comando sempre em `bash` *fenced*, com comentários em pt-BR quando necessários.

---

### Estrutura do site público

- Gerador: Hugo Extended v0.147+.
- Projeto: `docs/site/`.
- Conteúdo em `docs/site/content/`:
  - `_index.md` — página inicial.
  - `instalacao.md` — guia de instalação.
  - `uso.md` — boas práticas de uso do framework.
  - `boas-praticas.md` — boas práticas de desenvolvimento guiado por IA.
  - `contribuindo.md` — convites e diretrizes de contribuição.
  - `atualizacao-artefatos.md` — como manter referências externas (ex.: *The Twelve-Factor App*) em dia.
- *Layouts* em `docs/site/layouts/`; *assets* em `docs/site/static/` (inclusive `install.sh`/`install.ps1` copiados pelo workflow `pages.yml`).
- URLs em *kebab-case* em pt-BR (ex.: `/instalacao/`, `/boas-praticas/`).

---

### Regras para skills distribuídas

- Localização: `src/.claude/skills/<nome-da-skill>/SKILL.md` para genéricas; `src/stacks/<stack>/skills/<nome-da-skill>/SKILL.md` para stack-específicas.
- Um arquivo `SKILL.md` por skill.
- Frontmatter obrigatório:
  - `name` — em *kebab-case*, idêntico ao nome do diretório.
  - `description` — uma frase em pt-BR, imperativa, descrevendo o perfil que a skill faz o assistente assumir.
- Escopo bem delimitado: uma skill representa um perfil único. Não misturar responsabilidades.
- Nomenclatura de skills stack-específicas: `<nome-da-stack>-engineer` (ex.: `aspnet-engineer`, `node-engineer`).
- Toda skill distribuída deve aparecer na tabela *Skills disponíveis* de `src/CONTRIBUTING.md`, com colunas *Skill*, *Perfil assumido* e *Disponibilidade* (`Sempre` ou `Somente se inicializado com --stack <x>`).

---

### Mensagens dos scripts (CLI UX)

- Mensagens de progresso em `stdout`, prefixadas por `==>`.
- Mensagens de erro em `stderr`, prefixadas por `ERRO:`.
- Idioma das mensagens: pt-BR.
- Ao final da instalação bem-sucedida, o instalador exibe um bloco de próximos passos numerados, incluindo:
  1. Configuração local de `user.name`/`user.email`.
  2. Comando para o primeiro commit.
  3. Ordem recomendada de preenchimento dos documentos normativos.
  4. Passo para iniciar o assistente de IA no projeto (genérico; ferramentas específicas apenas como exemplo).

---

### Diagramas

- Diagramas C4Model são incorporados inline em `docs/SOLUTION.md`, na seção em que o assunto ilustrado é tratado: Contexto na visão geral, Contêiner e Componente junto à apresentação estrutural, Dinâmico junto ao fluxo documentado. Sintaxe **Mermaid**.
- Não existe seção dedicada a diagramas por padrão — diagramas são parte da narrativa da solução, não um anexo.
- Diagramas verdadeiramente complementares (tipicamente *Landscape*, *Deployment* ou dinâmicos auxiliares) residem em `docs/solution/` e são referenciados em seção curta "Diagramas complementares" ao final de `docs/SOLUTION.md`.
- No site público, diagramas são embutidos via *shortcode* Hugo apropriado, a partir do mesmo fonte Mermaid.
- Evitar imagens estáticas (PNG/SVG exportados) quando o equivalente Mermaid puder renderizar no *build*.
