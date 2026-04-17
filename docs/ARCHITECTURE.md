Toda documentação escrita, e código construído deve seguir estritamente as regras
contidas neste documento, que mantém as decisões arquiteturais relevantes de forma
global para toda solução de software construída.

### Regras primárias invioláveis

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

### Regras gerais de codificação

- A raiz do projeto deve ser um repositório Git
- Deve existir um arquivo `.gitignore` na raiz do projeto com as regras de arquivos ignoráveis do Git
- Deve existir um arquivo `.editorconfig` na raiz do projeto com as regras de personalização dos editores de código
- Não devem existir arquivos `.gitkeep` em diretórios que não estejam vazios. Esses são arquivos usados exclusivamente para manter diretórios vazios na árvore do repositório Git. Desnecessários quando o diretório não é vazio.
- Nenhum segredo deve ser condificado puramente no código. Ao invés disso devem ser configuráveis
- O software construído deve estar de acordo com as definições de "The Twelve-Factor App" (veja documentos em `./architecture/12factor/`)
- Deve existir um arquivo `CONTRIBUTING.md` na raiz do projeto com as diretrizes de contribuição por perfil
- O repositório local deve estar configurado explicitamente com nome e e-mail do desenvolvedor ao invés de usar as configurações global do Git. Isso evita erros quando se está utilizando várias contas Git, e fazer commits com usuários errados

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

Cada perfil de colaborador tem responsabilidade sobre documentos específicos e ações bem definidas no ciclo de vida do projeto.

| Perfil | Documentos sob sua responsabilidade |
|---|---|
| Arquiteto de soluções | `docs/ARCHITECTURE.md`, `docs/SOLUTION.md`, `docs/GOAL.md` |
| Analista de negócio | `docs/BUSINESS.md` |
| Designer | `docs/GUIDELINE.md` |

As ações esperadas de cada perfil, bem como as regras de colaboração, estão detalhadas em `CONTRIBUTING.md` na raiz do projeto.

