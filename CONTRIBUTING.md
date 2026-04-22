# Guia de Contribuição — Framework

Este documento descreve como contribuir com o **AI Powered Coding Team** — o próprio framework.

A raiz do repositório hospeda o framework em si: documentação estratégica (`docs/`), scripts de engenharia (`eng/`), site público (`docs/site/`), workflows (`.github/workflows/`) e skills de meta-uso em `.claude/skills/`. O diretório `src/` contém o software distribuído a cada projeto consumidor — empacotado em cada release por `eng/release.sh` e extraído por `eng/install.sh`.

> **Atenção:** qualquer alteração em `src/**` afeta **todos os projetos consumidores futuros** criados a partir da próxima release. Trate mudanças nesse diretório com a cautela de uma API pública.

Para contribuir com um projeto que **usa** o framework, consulte o `CONTRIBUTING.md` que o `eng/install.sh` instala no projeto (proveniente de `src/CONTRIBUTING.md`).

---

## Dogfooding e os quatro papéis

O desenvolvimento do framework segue o mesmo fluxo de quatro etapas que o framework impõe aos projetos consumidores:

**engenheiro (GOAL, etapa 1) → analista (BUSINESS, etapa 2) → projeção paralela por designer e arquiteto (GUIDELINE + ARCHITECTURE + SOLUTION, etapa 3) → engenheiro (implementação, etapa 4)**

Os mesmos quatro papéis — **arquiteto de soluções, analista de negócio, designer, engenheiro de software** — são assumidos para produzir cada artefato do próprio framework. Mudar *o que* o framework resolve começa por uma sessão supervisionada de IA editando `docs/BUSINESS.md` (raiz), sob o papel de analista. Mudar *como* ele resolve começa por edições coordenadas em `docs/SOLUTION.md`, `docs/ARCHITECTURE.md` e `docs/GUIDELINE.md`, sob os papéis de arquiteto e designer. Nenhuma alteração em `src/**`, `eng/`, workflows ou site precede uma atualização coerente dessas especificações.

Cada papel humano pode ser assumido pelo mesmo contribuidor (solo) ou distribuído entre pessoas distintas. A IA propõe; o papel humano correspondente revisa e commita.

---

## Áreas de contribuição

Contribuições incidem sobre uma das três áreas. Os quatro papéis são assumidos conforme a área demanda — uma contribuição pontual pode envolver apenas um dos papéis; uma contribuição estrutural pode envolver todos.

### Core do framework

Cinco documentos normativos da raiz, scripts em `eng/`, site público em `docs/site/**`, workflows em `.github/workflows/`.

**Ações típicas:**

- Editar os documentos normativos da raiz sob o papel correspondente (arquiteto, analista, designer ou engenheiro), respeitando a ordem inviolável das quatro etapas.
- Evoluir scripts em `eng/` (instalador, empacotador de release, sincronizador 12factor) **após** atualização coerente em `docs/SOLUTION.md`.
- Manter o site público (`docs/site/`) coerente com o estado do framework; *build* via Hugo Extended.
- Validar que `docs/ARCHITECTURE.md` (raiz) e `src/docs/ARCHITECTURE.md` permanecem coerentes a cada ciclo — o primeiro rege o framework, o segundo é o template entregue ao consumidor.

### Stacks plugáveis

Estrutura: `src/stacks/<nome>/{skills/, docs/}`. Hoje existe a stack `aspnet`; futuras stacks (`node`, `rust`, etc.) seguem o mesmo padrão.

**Ações típicas:**

- **Papel de arquiteto** — especificar `src/stacks/<nome>/docs/SOLUTION.md` (**obrigatório**; substitui o template vazio do consumidor na instalação).
- **Papel de analista / designer** — opcionalmente especificar `src/stacks/<nome>/docs/BUSINESS.md` e/ou `GUIDELINE.md`, quando a stack traz regras ou diretrizes próprias. Quando presentes, são copiados pelo `eng/install.sh`.
- **Papel de engenheiro** — criar a skill de engenheiro da stack em `src/stacks/<nome>/skills/<nome>-engineer/` (ex.: `aspnet-engineer`). Essas skills **só são instaladas** quando o consumidor executa `install.sh --stack <nome>`.
- Registrar a nova skill na tabela de *Skills disponíveis* em `src/CONTRIBUTING.md`, com a marca `Somente se inicializado com --stack <nome>`.
- Validar o ciclo completo localmente antes de abrir PR:
  1. `eng/release.sh` — gera o pacote em `dist/`.
  2. `eng/install.sh /tmp/test-<nome> --stack <nome>` — instala o template com a stack.
  3. Inspecionar o projeto instalado: a skill deve aparecer em `.claude/skills/`, o `SOLUTION.md` da stack deve ter substituído o template vazio, e o fluxo documentado na skill deve executar sem erros.

### Skills

Três localizações distintas com semânticas distintas:

- `.claude/skills/` na **raiz** — skills de meta-uso, disponíveis apenas ao trabalhar no próprio framework (não distribuídas).
- `src/.claude/skills/` — skills **genéricas** distribuídas para todo projeto consumidor (hoje: `architect-reviewer`, `business-reviewer`, `guideline-reviewer`, `c4model-architectural-designer`).
- `src/stacks/<nome>/skills/` — skills **stack-específicas**, instaladas apenas com `--stack <nome>`.

**Ações típicas:**

- Seguir o padrão de `SKILL.md` das skills existentes: frontmatter com `name`/`description`, descrição clara do perfil assumido, âmbito de atuação bem delimitado.
- Decidir o escopo correto antes de criar a skill:
  - Genérica a qualquer projeto → `src/.claude/skills/`.
  - Dependente de stack → `src/stacks/<nome>/skills/`.
  - Uso interno no framework → `.claude/skills/` (raiz).
- Toda skill distribuída (genérica ou stack-específica) deve aparecer na tabela de *Skills disponíveis* em `src/CONTRIBUTING.md`, com o perfil assumido e a disponibilidade.
- Skills que tocam documentos normativos (ARCHITECTURE.md, SOLUTION.md, BUSINESS.md, GUIDELINE.md) devem respeitar a **Convenção de includes** descrita em `.claude/CLAUDE.md` (cabeçalhos a partir de `###`, sem H1/H2).

---

## Governança

Governança do repositório é atribuição dos *committers* — contribuidores com direito de merge. Não constitui um papel de produção separado: cada tarefa de governança é executada sob um dos quatro papéis, conforme a natureza da tarefa (engenheiro quando envolve script/configuração, arquiteto quando envolve decisão estrutural).

**Tarefas de governança:**

- **Releases** — publicar uma *tag* `v*`, acionando `.github/workflows/release.yml`. O workflow invoca `eng/release.sh`, que resolve a versão via GitVersion e anexa `dist/v<versao>.zip` ao GitHub Release. Releases são **imutáveis** (`RN-RELEASE-IMUTAVEL` em `docs/BUSINESS.md`).
- **Sincronização de referências externas** — executar `eng/update-12factor.{sh,ps1}` periodicamente para atualizar `src/docs/architecture/12factor/` a partir do *upstream* `heroku/12factor`. Atualização paralela em `docs/architecture/12factor/` (raiz) para manter o *dogfooding* coerente.
- **Publicação do site** — garantir que `main` permaneça em estado publicável; `.github/workflows/pages.yml` publica a cada *push* em `main`.

---

## Regras gerais de contribuição

- Commits são feitos por humanos, nunca pela IA. A IA propõe — em **todos** os artefatos: cinco documentos normativos da raiz, scripts em `eng/`, conteúdo em `src/**`, site público e workflows — e o papel humano correspondente decide.
- O repositório local deve estar configurado explicitamente com nome e e-mail do contribuidor (não usar configuração global do Git).
- Mudanças em `src/**` exigem execução do fluxo `release → install` antes do *merge*, com teste em projeto temporário.
- Alterações em `.claude/skills/` da raiz não afetam consumidores, mas sua documentação interna (`SKILL.md`) deve permanecer autoexplicativa.
- Toda contribuição deve respeitar as regras em `docs/ARCHITECTURE.md`, inclusive as *Regras primárias invioláveis*.
