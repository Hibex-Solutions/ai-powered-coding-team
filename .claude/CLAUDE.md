# Instruções para o assistente de IA — Repositório do framework

## Contexto do repositório

Este é o repositório do framework **AI Powered Coding Team**. Você está trabalhando no **software do framework em si**, não em um projeto consumidor gerado a partir dele.

- **Raiz** — software do framework: documentação estratégica (`docs/`), scripts de engenharia (`eng/`), site público (`docs/site/`) e skills de meta-uso em `.claude/skills/`.
- **`src/`** — conteúdo distribuído aos consumidores em cada release. É a **API pública** do framework. Qualquer alteração aqui afeta todos os projetos consumidores futuros — trate com a cautela de uma API pública.

---

## Perfil do usuário

O usuário é **mantenedor ou contribuidor do framework** — atua em um dos três perfis descritos em `CONTRIBUTING.md` na raiz: Mantenedor do framework, Contribuidor de stack ou Contribuidor de skill. Foco em decisões de design, qualidade estrutural, compatibilidade de API e escolhas técnicas fundamentadas. Respostas devem ser diretas, técnicas e sem floreios — assuma conhecimento sólido de engenharia de software.

---

## Regras gerais

- Commits são feitos pelo mantenedor, nunca pela IA
- O diretório de trabalho deve ser sempre um repositório Git
- Espera-se que as configurações locais do Git quanto a nome e e-mail estejam presentes sempre
- **Agnosticismo à ferramenta de IA** é regra dura: nunca mencione uma ferramenta específica (Claude Code, Cursor, Copilot, etc.) como requisito em `README.md`, `docs/site/**` ou nos cinco documentos normativos (`docs/GOAL.md`, `docs/ARCHITECTURE.md`, `docs/SOLUTION.md`, `docs/BUSINESS.md`, `docs/GUIDELINE.md`). "Assistente de IA" como termo genérico. Ferramentas concretas só em exemplos rotulados `(ex.: ...)`, e ainda assim evite quando possível.

---

## O que a IA NÃO deve fazer

- Instalar pacotes sem perguntar, seja no sistema operacional ou no projeto.
- Criar arquivos fora da estrutura de pastas definida.
- Fazer commits ou adicionar mudanças Git ao estágio.
- Modificar `src/**` sem considerar o impacto como API pública. Sempre sinalize quando uma mudança for potencialmente *breaking* e proponha o incremento de versão correspondente (MAJOR/MINOR/PATCH).
- Adicionar nova stack, skill ou script de engenharia sem correspondência em `docs/SOLUTION.md` (raiz).
- Propor alterações em `src/docs/ARCHITECTURE.md` (template do consumidor) e em `docs/ARCHITECTURE.md` (raiz) de forma inconsistente — os dois têm responsabilidades distintas, mas o dogfooding exige coerência nas regras primárias invioláveis.

---

## Estrutura de diretórios do projeto

- `src/` — software distribuído aos consumidores (templates de documentação, skills genéricas, stacks). Tratado como API pública do framework.
- `eng/` — scripts de engenharia do framework (instalador, empacotador de release, sincronizador 12factor).
- `docs/` — documentação estratégica do framework (cinco documentos normativos + subdiretórios correspondentes) e site público em `docs/site/`.
- `.claude/` — skills de meta-uso disponíveis apenas no desenvolvimento do framework (não distribuídas).
- `dist/` — artefatos gerados por `eng/release.sh` (não versionados no Git).
- `test/` e `samples/` — não existem no escopo atual; serão criados quando houver bateria de testes automatizados do framework.

---

### Sobre documentação

A documentação do framework reside em `./docs`, dividida em:

- `./docs/GOAL.md` — fase atual, objetivo em curso e critérios de aceite.
- `./docs/ARCHITECTURE.md` — especificação da arquitetura do framework e suas regras.
- `./docs/SOLUTION.md` — descrição da solução do framework (componentes, tecnologias, fluxos).
- `./docs/BUSINESS.md` — regras de negócio do framework.
- `./docs/GUIDELINE.md` — diretrizes de marca, identidade visual, tom e UI/UX.

Quando há necessidade de aprofundamento, conteúdo adicional é incluído em subdiretórios correspondentes: `./docs/architecture/`, `./docs/solution/`, `./docs/business/`, `./docs/guideline/`.

Outras documentações (ex.: tutoriais) seguem o mesmo padrão: arquivo-índice no nível de `./docs` e subdiretório homônimo para os arquivos complementares.

Todos os cinco documentos normativos da raiz devem estar preenchidos — nenhum no estado de *template* vazio.

#### Convenção de includes

Os cinco documentos normativos são incluídos no contexto do assistente de IA via diretiva `@` (ao final deste arquivo). Cada inclusão é precedida de um cabeçalho `##` que identifica a seção. Por isso, **esses arquivos não devem conter cabeçalho H1 (`#`) nem H2 (`##`)** — todos os cabeçalhos internos iniciam em `###` ou inferior.

---

## Comportamento por fase do projeto

Antes de qualquer implementação, consulte a seção **Objetivo e fase atual** para identificar a fase corrente, e siga as regras de conduta definidas na **Especificação arquitetural** — ambas disponíveis nas seções de especificação deste arquivo.

---

## Sobre análise em repositórios do GitHub e GitLab

Quando solicitado ao assistente analisar conteúdo de repositórios Git públicos no GitHub ou GitLab, prefira clonar o repositório via HTTPS em diretório temporário e analisar os arquivos a partir desse diretório ao invés de baixar os conteúdos usando as chamadas diversas de APIs que esses serviços entregam.

Quando se tratar de poucos arquivos (até 5), prefira usar a API, mas com mais arquivos prefira o clone. Ao clonar, considere não clonar o repositório completo, mas apenas com profundidade do último commit.

Ao final da análise o usuário deve ser questionado se deseja remover o diretório temporário.

---

## Objetivo e fase atual

@../docs/GOAL.md

---

## Especificação arquitetural

@../docs/ARCHITECTURE.md

---

## Desenho da solução

@../docs/SOLUTION.md

---

## Regras de negócio

@../docs/BUSINESS.md

---

## Diretrizes de marca e interface

@../docs/GUIDELINE.md
