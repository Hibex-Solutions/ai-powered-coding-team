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

A documentação reside no diretório `./docs`, porém ainda assim estão divididos em:

- `./docs/GOAL.md` define a meta atual do projeto, a fase em que se encontra e os critérios de aceite
- `./docs/ARCHITECTURE.md` tem a especificação da arquitetura do software e suas regras
- `./docs/SOLUTION.md` tem a descrição da solução, que por sua vez deve obedecer todas as regras arquiteturais
- `./docs/BUSINESS.md` tem a especificação negocial para o software em questão
- `./docs/GUIDELINE.md` são as diretrizes, as regras de aplicação quanto a marca, UI/UX

Quando há necessidade de mais informações sobre esses 4 tipos de documentação, essas são incluídas
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
