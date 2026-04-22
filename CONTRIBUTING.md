# Guia de Contribuição — Framework

Este documento descreve as responsabilidades e ações esperadas de cada perfil que contribui com o **AI Powered Coding Team** — o próprio framework.

O repositório tem natureza dual:

- **Raiz** — o framework em si: documentação estratégica, scripts de engenharia (`eng/`), site público (`docs/site/`) e skills de meta-uso em `.claude/skills/`.
- **`src/`** — template distribuído em cada release (`eng/release.sh`) e extraído dentro de cada projeto consumidor por `eng/install.sh`.

> **Atenção:** qualquer alteração em `src/**` afeta **todos os projetos consumidores futuros** criados a partir da próxima release. Trate mudanças nesse diretório com a mesma cautela de uma API pública.

Para contribuir com um projeto que **usa** o framework, consulte o `CONTRIBUTING.md` que o `eng/install.sh` instala junto ao projeto (proveniente de `src/CONTRIBUTING.md`).

---

## Mantenedor do framework

**Responsabilidades:** governança do projeto, documentação pública, processo de release e sincronização das referências externas.

> **Dogfooding:** a evolução do framework segue o mesmo fluxo que ele impõe aos consumidores — **engenheiro (GOAL, etapa 1) → analista (BUSINESS, etapa 2) → projeção paralela por designer e arquiteto (GUIDELINE + ARCHITECTURE + SOLUTION, etapa 3) → engenheiro (implementação, etapa 4)**. Mudar o que o framework resolve começa por uma sessão supervisionada de IA produzindo a edição em `docs/BUSINESS.md` (raiz); mudar como ele resolve começa por uma sessão supervisionada produzindo a edição em `docs/SOLUTION.md` (raiz), em coordenação com `docs/ARCHITECTURE.md` e `docs/GUIDELINE.md` quando a mudança afeta regras ou marca/UX. O mantenedor supervisiona; a IA propõe; o mantenedor revisa e commita. Nenhuma alteração em `src/**`, `eng/`, workflows ou site precede uma atualização coerente dessas especificações.

**Ações esperadas:**

- Gerar novas releases com `eng/release.sh` / `eng/release.ps1`. O script usa GitVersion para determinar a versão semântica e empacota o conteúdo de `src/` em `dist/package/*.zip`.
- Sincronizar a especificação *The Twelve-Factor App* com `eng/update-12factor.sh` / `eng/update-12factor.ps1`, que clona esparso o repositório `heroku/12factor` e copia a tradução `pt_br` para `src/docs/architecture/12factor/`.
- Manter o site público coerente com o estado do framework: conteúdo em `docs/site/content/**`, build via Hugo.
- Validar que o par `docs/ARCHITECTURE.md` (raiz) e `src/docs/ARCHITECTURE.md` permanece coerente a cada ciclo.

---

## Contribuidor de stack

**Responsabilidade:** adicionar ou evoluir stacks tecnológicas em `src/stacks/<nome>/`. Hoje existe a stack `aspnet`; futuras stacks (`node`, `rust`, etc.) seguem o mesmo padrão.

**Ações esperadas:**

- Estruturar a stack em `src/stacks/<nome>/{skills/, docs/}`:
  - `docs/SOLUTION.md` é **obrigatório** — ele substitui o template vazio do projeto consumidor na instalação.
  - `docs/BUSINESS.md` e `docs/GUIDELINE.md` são opcionais; quando presentes, são copiados pelo `eng/install.sh` junto com `SOLUTION.md`.
- Criar a skill de engenheiro da stack em `src/stacks/<nome>/skills/<nome>-engineer/` (ex.: `aspnet-engineer`). Essas skills **só são instaladas** quando o consumidor executa `install.sh --stack <nome>`.
- Registrar a nova skill na tabela de *Skills disponíveis* em `src/CONTRIBUTING.md`, com a marca `Somente se inicializado com --stack <nome>`.
- Validar o ciclo completo localmente antes de abrir PR:
  1. `eng/release.sh` — gera o pacote em `dist/`.
  2. `eng/install.sh /tmp/test-<nome> --stack <nome>` — instala o template com a stack.
  3. Inspecionar o projeto instalado: a skill deve aparecer em `.claude/skills/`, o `SOLUTION.md` da stack deve ter substituído o template vazio, e o fluxo de criação documentado na skill deve executar sem erros.

---

## Contribuidor de skill

**Responsabilidade:** skills de IA em duas localizações distintas com semânticas distintas.

- `.claude/skills/` na **raiz** — skills de meta-uso, disponíveis apenas ao trabalhar no próprio framework.
- `src/.claude/skills/` — skills **genéricas** distribuídas para todo projeto consumidor (hoje: `architect-reviewer`, `business-reviewer`, `guideline-reviewer`, `c4model-architectural-designer`).
- `src/stacks/<nome>/skills/` — skills **stack-específicas**, instaladas apenas com `--stack <nome>`.

**Ações esperadas:**

- Seguir o padrão de `SKILL.md` das skills existentes: frontmatter com `name`/`description`, descrição clara do perfil assumido, e âmbito de atuação bem delimitado.
- Decidir o escopo correto antes de criar a skill:
  - Genérica a qualquer projeto → `src/.claude/skills/`.
  - Dependente de stack → `src/stacks/<nome>/skills/`.
  - Uso interno no framework → `.claude/skills/` (raiz).
- Toda skill distribuída (genérica ou stack-específica) deve aparecer na tabela de *Skills disponíveis* em `src/CONTRIBUTING.md`, com o perfil assumido e a disponibilidade.
- Skills que tocam documentos normativos (ARCHITECTURE.md, SOLUTION.md, BUSINESS.md, GUIDELINE.md) devem respeitar a **Convenção de includes** descrita em `.claude/CLAUDE.md` (cabeçalhos a partir de `###`, sem H1).

---

## Regras gerais de contribuição

- Commits são feitos por humanos, nunca pela IA. A IA propõe — em **todos** os artefatos: cinco documentos normativos da raiz, scripts em `eng/`, conteúdo em `src/**`, site público e workflows — e o mantenedor decide.
- O repositório local deve estar configurado explicitamente com nome e e-mail do contribuidor (não usar configuração global do Git).
- Mudanças em `src/**` exigem execução do fluxo `release → install` antes do merge, com teste em projeto temporário.
- Alterações em `.claude/skills/` da raiz não afetam consumidores, mas sua documentação interna (`SKILL.md`) deve permanecer autoexplicativa.
- Toda contribuição deve respeitar as regras em `docs/ARCHITECTURE.md`, inclusive as *Regras primárias invioláveis*.
