Toda documentação escrita, e código construído deve seguir estritamente as regras
contidas neste documento, que mantém as decisões arquiteturais relevantes de forma
global para toda solução de software construída.

### Regras primárias invioláveis

- `BUSINESS.md` é a especificação do **problema** a ser resolvido e das regras de negócio que regem sua operação. `SOLUTION.md` é a especificação da **solução** que resolve esse problema.
  - Toda decisão em `SOLUTION.md` (componente, tecnologia, fluxo) deve ter origem rastreável em uma regra de `BUSINESS.md` (funcional ou não-funcional) ou em uma restrição de `ARCHITECTURE.md`.
  - Nenhuma regra de negócio presente em `BUSINESS.md` pode ficar sem tratamento na solução.
- O fluxo de especificação tem quatro etapas: **etapa 1** — engenheiro produz `GOAL.md` (objetivo do projeto); **etapa 2** — analista de negócio produz `BUSINESS.md` (problema); **etapa 3 (projeção)** — designer e arquiteto produzem `GUIDELINE.md`, `ARCHITECTURE.md` e `SOLUTION.md` em colaboração, podendo trabalhar em paralelo (os três artefatos se coordenam entre si e com `BUSINESS.md`); **etapa 4** — engenheiro implementa em `src/` e `test/`. Os papéis da etapa 3 podem ser distribuídos entre profissionais distintos ou acumulados em um único profissional que assume múltiplos papéis. Nenhuma etapa posterior começa enquanto a anterior não está documentada para o escopo em questão.
- Todo código de software construído deve obedecer ao desenho de solução especificado
  - Nenhum componente de software pode ser adicionado se não estiver mencionado no desenho de solução
  - Nenhuma tecnologia pode ser adotada sem estar mencionada no desenho de solução
- Todo teste deve ser baseado em regras de negócio definidas
  - Nenhuma regra de negócio pode deixar de ser implementada
  - Nenhuma funcionalidade deve existir sem uma especificação das regras de negócio
  - As regras de negócio especificadas devem estar 100% cobertas por testes
- A experiência do usuário deve obedecer ao Guideline da marca
  - Toda interface construída deve obeceder as regras de Guideline
  - Nenhum comportamento do usuário pode violar as regras de Guideline

O framework **se submete** às suas próprias regras primárias invioláveis — desenvolver
o framework é, ele mesmo, um exercício de dogfooding: nenhuma skill, stack, script
ou documento é adicionado ao framework sem estar especificado em `docs/SOLUTION.md`
(raiz); nenhuma funcionalidade existe sem regra de negócio correspondente em
`docs/BUSINESS.md` (raiz); nenhuma interface pública (site, mensagens de CLI, README)
viola `docs/GUIDELINE.md` (raiz).

### Regras gerais de codificação

- A raiz do projeto deve ser um repositório Git
- Deve existir um arquivo `.gitignore` na raiz do projeto com as regras de arquivos ignoráveis do Git
- Deve existir um arquivo `.editorconfig` na raiz do projeto com as regras de personalização dos editores de código
- Não devem existir arquivos `.gitkeep` em diretórios que não estejam vazios. Esses são arquivos usados exclusivamente para manter diretórios vazios na árvore do repositório Git. Desnecessários quando o diretório não é vazio.
- Nenhum segredo deve ser condificado puramente no código. Ao invés disso devem ser configuráveis
- O software construído deve estar de acordo com as definições de "The Twelve-Factor App" (veja documentos em `./architecture/12factor/`)
- Deve existir um arquivo `CONTRIBUTING.md` na raiz do projeto com as diretrizes de contribuição por perfil
- O repositório local deve estar configurado explicitamente com nome e e-mail do desenvolvedor ao invés de usar as configurações global do Git. Isso evita erros quando se está utilizando várias contas Git, e fazer commits com usuários errados
- Scripts em `eng/` não podem introduzir dependência de runtime adicional (Node.js, Python, Ruby, etc.) além de `bash`/`pwsh`, `git`, `curl` e utilitários POSIX comuns. Essa restrição garante que o framework rode em qualquer sistema sem instalações prévias específicas. As linguagens concretas adotadas para `.sh` e `.ps1` estão definidas em `SOLUTION.md` ("Tecnologias adotadas").

### Sobre a fase do projeto

O arquivo `docs/GOAL.md` é obrigatório e deve sempre existir preenchido. Ele define a fase atual
do projeto, a meta em curso e os critérios de aceite que determinam quando essa fase pode ser considerada
concluída. O arquivo nunca deve estar no estado de template vazio.

#### Fases válidas

| Fase | Descrição |
|---|---|
| `criacao` | Projeto sendo construído do zero; não há código legado nem funcionalidades existentes |
| `desenvolvimento-ativo` | Software lançado em desenvolvimento ativo; novas funcionalidades têm prioridade |
| `manutencao` | Software em manutenção; apenas correções críticas de bugs são permitidas |
| `migracao` | Migração de projeto legado; código e documentação originais devem ser consultados |

#### Regras por fase

- **`criacao`** e **`desenvolvimento-ativo`**: Implementação livre dentro das especificações documentadas.
- **`manutencao`**: Novas funcionalidades não devem ser implementadas. Qualquer pedido de nova
  funcionalidade deve ser recusado ou sinalizado como fora do escopo da fase atual. Apenas correções
  de bugs críticos que afetam o funcionamento essencial do sistema são permitidas.
- **`migracao`**: Os caminhos para código e documentação legados declarados em `docs/GOAL.md`
  devem ser consultados antes de qualquer implementação. A migração deve preservar o comportamento
  original salvo especificação explícita em contrário.

### Sobre a contribuição no projeto

Cada perfil de contribuidor tem responsabilidade sobre áreas específicas do repositório do framework.

| Perfil | Áreas sob sua responsabilidade |
|---|---|
| Mantenedor do framework | Governança, releases, documentação pública (`docs/site/**`), sincronização de referências externas (`eng/update-12factor.*`), coerência dos 5 documentos normativos da raiz |
| Contribuidor de stack | Stacks em `src/stacks/<nome>/` (docs + skills específicas da stack) |
| Contribuidor de skill | Skills em `.claude/skills/` (meta-uso interno), `src/.claude/skills/` (genéricas distribuídas) e `src/stacks/<nome>/skills/` (stack-específicas) |

As ações esperadas de cada perfil, bem como as regras de colaboração, estão detalhadas em `CONTRIBUTING.md` na raiz do projeto. Para a contribuição **em um projeto consumidor** gerado a partir do framework, a referência é o `CONTRIBUTING.md` instalado pelo `eng/install.sh` (proveniente de `src/CONTRIBUTING.md`), que descreve os perfis Arquiteto, Analista de negócio, Designer e Engenheiro.
