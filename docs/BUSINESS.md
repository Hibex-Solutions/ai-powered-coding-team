<!--
  Este arquivo é incluído no contexto do assistente de IA via diretiva @-include.
  Não use cabeçalhos H1 (#) nem H2 (##) — as seções devem iniciar em H3 (###).
-->

Este documento descreve o **problema** que o framework se propõe a resolver e as **regras de negócio** que regem sua operação (instalação, release, distribuição, agnosticismo à ferramenta de IA, runtime do consumidor, requisitos não-funcionais). Não descreve como o framework resolve esse problema — essa é a responsabilidade de `SOLUTION.md`.

A especificação do problema é responsabilidade do **analista de negócio** e é pré-requisito para a especificação da solução em `SOLUTION.md`.

---

### Clientes do framework

- **Engenheiro solo** — profissional sênior que assume todos os papéis (arquiteto, analista de negócio, designer, engenheiro) e delega a execução a um assistente de IA sob sua supervisão.
- **Time de engenharia** — múltiplos profissionais, cada um atuando em seu perfil específico, usando o assistente de IA para ampliar individualmente a capacidade de entrega, com base estrutural compartilhada entre todos.
- **Mantenedor ou contribuidor do framework** — cliente secundário, que usa o próprio framework (especialmente as skills em `.claude/skills/` da raiz) para desenvolver o framework.

### Proposta de valor

- Nenhum código escrito sem especificação prévia.
- Nenhuma decisão técnica tomada sem documentação.
- Toda implementação validada contra regras de negócio e diretrizes de marca.
- Agnóstico à ferramenta de assistente de IA — o framework define o processo, não a tecnologia.
- Distribuição simples por comando único (`curl | bash`), sem dependências exóticas no host do consumidor.

---

### Regras de instalação

- `RN-INST-01` — A instalação não exige privilégios elevados (sudo, Administrador).
- `RN-INST-02` — Nenhum token, segredo ou autenticação em serviço externo é exigido.
- `RN-INST-03` — O diretório de destino é obrigatório; `--version` e `--stack` são opcionais.
- `RN-INST-04` — Omissão de `--stack` produz uma instalação agnóstica de stack (nenhum arquivo stack-específico é adicionado).
- `RN-INST-05` — Quando `--stack <nome>` é informado e a stack não existe na versão alvo, a instalação falha com mensagem clara listando as stacks disponíveis e o diretório de destino é removido.
- `RN-INST-06` — Ao final da instalação bem-sucedida, o destino é um repositório Git inicializado em `main`, sem commits.
- `RN-INST-07` — Pré-requisitos no host do consumidor: `git`, `curl` e `unzip` (ou equivalentes em PowerShell). Se qualquer um estiver ausente, a instalação falha com mensagem direcionando à instalação do utilitário.

### Regras de release e distribuição

- `RN-REL-01` — Releases são imutáveis: uma *tag* `v*` publicada não é reescrita. Correções saem sempre em nova versão.
- `RN-REL-02` — Versionamento é determinado por GitVersion a partir do histórico e da *tag* mais recente, respeitando a semântica SemVer.
- `RN-REL-03` — `src/**` é a **API pública** do framework. Nenhuma remoção ou renomeação pode ocorrer sem incremento MAJOR; adições retrocompatíveis são MINOR; correções sem impacto de API são PATCH.
- `RN-REL-04` — Skills stack-específicas são instaladas apenas quando `--stack <nome>` correspondente é informado. Sem `--stack`, apenas as skills genéricas em `src/.claude/skills/` são copiadas.
- `RN-REL-05` — O ZIP publicado no GitHub Releases contém exclusivamente o conteúdo de `src/` (no topo do arquivo). Nunca inclui artefatos da raiz (`eng/`, `docs/`, `.github/`, etc.).
- `RN-REL-06` — O canal de distribuição é único: GitHub Releases (assets ZIP) + GitHub Pages (site público e hospedagem de `install.sh`/`install.ps1`). Não há outros canais (npm, NuGet, Homebrew, etc.).

### Regras de agnosticismo à ferramenta de IA

- `RN-IA-01` — Nenhum dos cinco documentos normativos da raiz (`docs/GOAL.md`, `docs/ARCHITECTURE.md`, `docs/SOLUTION.md`, `docs/BUSINESS.md`, `docs/GUIDELINE.md`) cita uma ferramenta específica de assistente de IA como requisito.
- `RN-IA-02` — Comunicação pública (`README.md`, `docs/site/**`) usa "assistente de IA" genericamente. Menções a ferramentas concretas só são permitidas em exemplos, rotulados como `(ex.: ...)`.
- `RN-IA-03` — O projeto consumidor instalado não depende de nenhuma ferramenta de assistente de IA para funcionar — a dependência existe apenas para o fluxo de trabalho supervisionado que o consumidor adota.

### Regras do projeto consumidor em runtime

- `RN-CON-01` — O projeto consumidor não consulta serviços externos em tempo de execução por causa do framework. O framework é estrutural — atua sobre o processo de desenvolvimento, não sobre o runtime do software produzido.
- `RN-CON-02` — O projeto instalado é autocontido: o conteúdo extraído do ZIP + repositório Git inicializado é suficiente para começar. Nenhum passo posterior de *bootstrap* consulta a internet.

### Regras não-funcionais

- `RN-NF-01` — O instalador funciona offline após o download inicial do ZIP (a única chamada remota é à API do GitHub para resolver a release e baixar o asset).
- `RN-NF-02` — Scripts `.sh` rodam em Bash 4+ em Linux e macOS. Scripts `.ps1` rodam em PowerShell 7+ em Windows, Linux e macOS.
- `RN-NF-03` — Nenhum *runtime* adicional (Node.js, Python, Ruby, etc.) é exigido para instalar, empacotar ou operar o framework.

---

### Cobertura de testes — estado atual

Não há testes automatizados implementados no framework no momento.

Bateria mínima recomendada (a ser produzida durante a fase `criacao` ou priorizada logo no início de `desenvolvimento-ativo`):

- `T-INST-01` — *Smoke test* do `install.sh` em Linux e macOS, contra uma release real, validando estrutura final do destino.
- `T-INST-02` — *Smoke test* do `install.ps1` em Windows, com mesma validação.
- `T-INST-03` — Instalação com `--stack aspnet` e verificação da presença de `.claude/skills/aspnet-engineer/SKILL.md` e do `docs/SOLUTION.md` correto.
- `T-INST-04` — Instalação com `--stack <inexistente>`: verifica mensagem de erro, saída com código não-zero e remoção do diretório de destino.
- `T-REL-01` — Execução do `release.sh` em *branch* de PR, validando geração de ZIP com conteúdo íntegro de `src/` e versão coerente.

Conforme `RN-REL-03` e a Regra Primária Inviolável de cobertura, qualquer regra de negócio adicionada a este documento deve ter teste automatizado correspondente antes de integrar a uma release *estável*.
