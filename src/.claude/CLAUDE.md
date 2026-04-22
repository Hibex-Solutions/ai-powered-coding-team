# Instruções para Claude Code

## Perfil do usuário

O usuário é **arquiteto de soluções de software**. Foco em decisões de design, qualidade estrutural e escolhas técnicas fundamentadas. Respostas devem ser diretas, técnicas e sem floreios — assuma conhecimento sólido de engenharia de software.

---

## Regras gerais

- Commits são feitos por mim, nunca pelo Claude
- O diretório de trabalho deve ser sempre um repositório Git
- Espera-se que as configurações locais do Git quanto a nome e e-mail estejam presentes sempre

---

## O que o Claude NÃO deve fazer

- Instalar pacotes sem perguntar, seja no sistema operacional ou no projeto.
- Criar arquivos fora da estrutura de pastas definida
- Fazer commits ou adicionar mudanças Git ao estágio

---

## Estrutura de diretórios do projeto

- `src` - Todo código do software reside aqui
- `test` - Todo código de teste do software reside aqui
- `eng` - Todo programa/script de engenharia reside aqui. Utilitários de CI/CD ou automações de validação etc.
- `docs` - Toda documentação do projeto reside aqui
- `samples` - Todo e qualquer exemplo de código reside aqui. Quando é um projeto de biblioteca/framework, os exemplos de uso ficam aqui

---

### Sobre documentação

A documentação reside no diretório `./docs`, dividida segundo o fluxo de quatro etapas: **engenheiro (GOAL, etapa 1) → analista (BUSINESS, etapa 2) → projeção paralela por designer e arquiteto (GUIDELINE + ARCHITECTURE + SOLUTION, etapa 3) → engenheiro (implementação, etapa 4)**:

- `./docs/GOAL.md` — objetivo do projeto, fase atual e critérios de aceite (responsável: engenheiro; **etapa 1**, antes de tudo).
- `./docs/BUSINESS.md` — **problema** que o software resolve e regras de negócio que regem sua operação (responsável: analista de negócio; **etapa 2**; pré-requisito para a etapa de projeção).
- `./docs/GUIDELINE.md` — diretrizes de marca, UI e UX (responsável: designer; **etapa 3**, em paralelo com `ARCHITECTURE.md` e `SOLUTION.md`).
- `./docs/ARCHITECTURE.md` — regras arquiteturais invioláveis que atuam sobre toda a solução (responsável: arquiteto; **etapa 3**, em paralelo com `GUIDELINE.md` e `SOLUTION.md`).
- `./docs/SOLUTION.md` — **solução** técnica para o problema descrito em `BUSINESS.md` (responsável: arquiteto em conjunto com designer; **etapa 3**, em paralelo com `GUIDELINE.md` e `ARCHITECTURE.md`; pré-requisito para a implementação em `src/` e `test/`).

A **etapa 3** é uma etapa de projeção colaborativa: os três artefatos são elaborados em conjunto, por profissionais distintos ou por um único profissional que acumula os papéis. `BUSINESS.md` trata do problema; `SOLUTION.md` trata da solução para esse problema. Toda decisão em `SOLUTION.md` deve ter origem rastreável em uma regra de `BUSINESS.md` (funcional ou não-funcional) ou em uma restrição de `ARCHITECTURE.md`.

Quando há necessidade de mais informações sobre esses cinco tipos de documentação, essas são incluídas
em documentos adicionais, que residem em diretórios correspondentes a seus nomes, a saber: `./docs/architecture/`,
`./docs/solution/`, `./docs/business/`, e `./docs/guideline/` respectivamente.

Outras documentações também podem estar presentes, como _tutoriais_. Nesse caso espera-se que sempre haja um
arquivo de categoria (ex: `./docs/TUTORIAIS.md`) e um diretório `./docs/tutoriais/` para os arquivos complementares.
Essa regra se aplica para toda a documentação.

#### Convenção de includes

Os arquivos de documentação listados acima são incluídos no contexto via diretiva `@`. Cada inclusão é
precedida de um cabeçalho `##` que identifica a seção. Por isso, **esses arquivos não devem conter
cabeçalho H1 (`#`)** — o conteúdo começa diretamente após o título. Todos os cabeçalhos internos
nesses arquivos devem iniciar em nível 3 (`###`) ou inferior.

---

## Comportamento por fase do projeto

Antes de qualquer implementação, consulte a seção **Objetivo e fase atual** para identificar a fase
corrente, e siga as regras de conduta definidas na **Especificação arquitetural** — ambas disponíveis
nas seções de especificação deste arquivo.

---

## Sobre análise em repositórios do GitHub e GitLab

Quando solicitado ao Claude analisar conteúdo de repositórios Git públicos no GitHub ou GitLab, prefira clonar
o repositório via HTTPS em diretório temporário e analisar os arquivos à partir desse diretório ao invés de baixar
os conteúdos usando as chamadas diversas de APIs que esses serviços entregam.

Quando se tratar de poucos arquivos (até 5) prefira usar a API, mas com mais arquivos prefira o clone. Mas ao
clonar, considere não clonar o repositório completo, mas apenas com profundidade do último commit.

Ao final da análise o usuário deve ser questionado se deseja remover o diretório temporário.

---

## Especificação arquitetural

@../docs/ARCHITECTURE.md
