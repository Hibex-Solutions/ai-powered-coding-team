<!--
  Este arquivo é incluído no contexto do assistente de IA via diretiva @-include.
  Não use cabeçalhos H1 (#) nem H2 (##) — as seções devem iniciar em H3 (###).
-->

Este documento descreve o **problema** que o framework se propõe a resolver e as **regras de negócio** que regem sua operação. Não descreve como o framework resolve esse problema — essa é a responsabilidade de `SOLUTION.md`.

A especificação do problema é responsabilidade do **analista de negócio** e é pré-requisito para a especificação da solução em `SOLUTION.md`.

---

O desenvolvimento de software com assistentes de IA deixou de ser experimental e passou a compor o dia a dia de engenheiros experientes e de times inteiros. A velocidade de produção aumentou — e, com ela, vieram os riscos: código gerado sem especificação prévia, decisões técnicas tomadas sem trilha documental, funcionalidades sem correspondência com um problema de negócio real e implementações que não podem ser validadas contra regras de negócio ou diretrizes de marca. O resultado típico é um software que evolui rápido no começo e perde sustentabilidade à medida que a base cresce.

Profissionais e equipes experientes reconhecem o ganho de produtividade oferecido pelos assistentes de IA, mas não abrem mão do rigor que sustenta software de qualidade: especificação antes de código, documentação antes de decisão, teste contra regra de negócio, interface fiel à identidade visual. Sem um fluxo de trabalho explícito, o assistente de IA tende a saltar etapas e produzir artefatos desconexos — e cada ferramenta impõe seu próprio modelo mental, prendendo o processo à tecnologia escolhida e dificultando a substituição ou a convivência de múltiplas ferramentas em um mesmo time.

O problema que este framework se propõe a resolver é **estruturar o processo de desenvolvimento com IA** de modo que times e profissionais experientes possam **ampliar sua capacidade de entrega sem abrir mão da governança**. Trata-se de disciplinar *como* o software é produzido quando parte relevante do trabalho é delegada a assistentes de IA: quem decide o quê, em que ordem, com quais critérios de aceite, e com qual rastreabilidade entre intenção, especificação, implementação e teste — independentemente da ferramenta escolhida.

---

### Clientes do framework

- **Engenheiro solo** — profissional sênior que assume todos os papéis (arquiteto, analista de negócio, designer, engenheiro) e delega a execução a um assistente de IA sob sua supervisão.
- **Time de engenharia** — múltiplos profissionais, cada um atuando em seu perfil específico, usando o assistente de IA para ampliar individualmente a capacidade de entrega, com base estrutural compartilhada entre todos.
- **Equipe que desenvolve o framework** — cliente secundário: os mesmos quatro papéis (arquiteto de soluções, analista de negócio, designer, engenheiro de software) aplicados ao próprio framework (*dogfooding*), apoiados pelas skills em `.claude/skills/` da raiz.

### Proposta de valor

- Nenhum código escrito sem especificação prévia.
- Nenhuma decisão técnica tomada sem documentação.
- Toda implementação validada contra regras de negócio e diretrizes de marca.
- Agnóstico à ferramenta de assistente de IA — o framework define o processo, não a tecnologia.
- Distribuição simples por comando único (`curl | bash`), sem dependências exóticas no host do consumidor.

---

### Convenção de identificadores

Cada regra deste documento possui um identificador alfanumérico globalmente único no formato `RN-<NOME>`:

- Prefixo `RN-` (regra de negócio) obrigatório.
- `<NOME>` em `SCREAMING-KEBAB-CASE`, caracteres `[A-Z0-9-]`, até **32 caracteres** no total (incluindo o prefixo).
- O nome descreve a regra (ex.: `RN-RELEASE-IMUTAVEL`, `RN-INSTALADOR-PREREQUISITOS`), não ocupa posição em sequência — identificadores novos não reaproveitam IDs removidos e a mudança de seção não exige renumeração.
- Quando útil, o primeiro segmento após `RN-` agrupa por domínio (`INSTALADOR`, `RELEASE`, `IA`, `CONSUMIDOR`, `SCRIPTS`). O domínio não é obrigatório — regras suficientemente específicas podem omiti-lo (ex.: `RN-SEM-RUNTIME-ADICIONAL`).
- Identificadores são **estáveis**: só são renomeados quando o nome deixa de refletir a regra. Toda referência em `SOLUTION.md` (ou outros artefatos) deve ser atualizada na mesma mudança.
- A distinção **funcional** × **não-funcional** é dada pela seção em que a regra aparece, não pelo identificador.

---

### Regras funcionais

#### Instalação

- `RN-INSTALADOR-SEM-PRIVILEGIO` — A instalação não exige privilégios elevados (sudo, Administrador).
- `RN-INSTALADOR-SEM-SEGREDO` — Nenhum token, segredo ou autenticação em serviço externo é exigido.
- `RN-INSTALADOR-ARGUMENTOS` — O diretório de destino é obrigatório; `--version` e `--stack` são opcionais.
- `RN-INSTALADOR-STACK-OPCIONAL` — Omissão de `--stack` produz uma instalação agnóstica de stack (nenhum arquivo stack-específico é adicionado).
- `RN-INSTALADOR-STACK-INVALIDA` — Quando `--stack <nome>` é informado e a stack não existe na versão alvo, a instalação falha com mensagem clara listando as stacks disponíveis e o diretório de destino é removido.
- `RN-INSTALADOR-GIT-INICIALIZADO` — Ao final da instalação bem-sucedida, o destino é um repositório Git inicializado em `main`, sem commits.
- `RN-INSTALADOR-PREREQUISITOS` — Pré-requisitos no host do consumidor: `git`, `curl` e `unzip` (ou equivalentes em PowerShell). Se qualquer um estiver ausente, a instalação falha com mensagem direcionando à instalação do utilitário.

#### Release e distribuição

- `RN-RELEASE-IMUTAVEL` — Releases são imutáveis: uma *tag* `v*` publicada não é reescrita. Correções saem sempre em nova versão.
- `RN-RELEASE-VERSIONAMENTO-SEMVER` — Versionamento é determinado por GitVersion a partir do histórico e da *tag* mais recente, respeitando a semântica SemVer.
- `RN-RELEASE-API-PUBLICA` — `src/**` é a **API pública** do framework. Nenhuma remoção ou renomeação pode ocorrer sem incremento MAJOR; adições retrocompatíveis são MINOR; correções sem impacto de API são PATCH.
- `RN-RELEASE-SKILLS-STACK-OPTIN` — Skills stack-específicas são instaladas apenas quando `--stack <nome>` correspondente é informado. Sem `--stack`, apenas as skills genéricas em `src/.claude/skills/` são copiadas.
- `RN-RELEASE-ZIP-CONTEUDO` — O ZIP publicado no GitHub Releases contém exclusivamente o conteúdo de `src/` (no topo do arquivo). Nunca inclui artefatos da raiz (`eng/`, `docs/`, `.github/`, etc.).
- `RN-RELEASE-CANAL-UNICO` — O canal de distribuição é único: GitHub Releases (assets ZIP) + GitHub Pages (site público e hospedagem de `install.sh`/`install.ps1`). Não há outros canais (npm, NuGet, Homebrew, etc.).

#### Agnosticismo à ferramenta de IA

- `RN-IA-DOCS-NORMATIVOS` — Nenhum dos cinco documentos normativos da raiz (`docs/GOAL.md`, `docs/ARCHITECTURE.md`, `docs/SOLUTION.md`, `docs/BUSINESS.md`, `docs/GUIDELINE.md`) cita uma ferramenta específica de assistente de IA como requisito.
- `RN-IA-COMUNICACAO-PUBLICA` — Comunicação pública (`README.md`, `docs/site/**`) usa "assistente de IA" genericamente. Menções a ferramentas concretas só são permitidas em exemplos, rotulados como `(ex.: ...)`.
- `RN-IA-CONSUMIDOR-INDEPENDENTE` — O projeto consumidor instalado não depende de nenhuma ferramenta de assistente de IA para funcionar — a dependência existe apenas para o fluxo de trabalho supervisionado que o consumidor adota.

#### Runtime do projeto consumidor

- `RN-CONSUMIDOR-RUNTIME-ISOLADO` — O projeto consumidor não consulta serviços externos em tempo de execução por causa do framework. O framework é estrutural — atua sobre o processo de desenvolvimento, não sobre o runtime do software produzido.
- `RN-CONSUMIDOR-AUTOCONTIDO` — O projeto instalado é autocontido: o conteúdo extraído do ZIP + repositório Git inicializado é suficiente para começar. Nenhum passo posterior de *bootstrap* consulta a internet.

---

### Regras não-funcionais

- `RN-INSTALADOR-OFFLINE` — O instalador funciona offline após o download inicial do ZIP (a única chamada remota é à API do GitHub para resolver a release e baixar o asset).
- `RN-SCRIPTS-COMPATIBILIDADE` — Scripts `.sh` rodam em Bash 4+ em Linux e macOS. Scripts `.ps1` rodam em PowerShell 7+ em Windows, Linux e macOS.
- `RN-SEM-RUNTIME-ADICIONAL` — Nenhum *runtime* adicional (Node.js, Python, Ruby, etc.) é exigido para instalar, empacotar ou operar o framework.

---

### Cobertura de testes — estado atual

Não há testes automatizados implementados no framework no momento.

Bateria mínima recomendada (a ser produzida durante a fase `criacao` ou priorizada logo no início de `desenvolvimento-ativo`):

- `T-INST-01` — *Smoke test* do `install.sh` em Linux e macOS, contra uma release real, validando estrutura final do destino.
- `T-INST-02` — *Smoke test* do `install.ps1` em Windows, com mesma validação.
- `T-INST-03` — Instalação com `--stack aspnet` e verificação da presença de `.claude/skills/aspnet-engineer/SKILL.md` e do `docs/SOLUTION.md` correto.
- `T-INST-04` — Instalação com `--stack <inexistente>`: verifica mensagem de erro, saída com código não-zero e remoção do diretório de destino.
- `T-REL-01` — Execução do `release.sh` em *branch* de PR, validando geração de ZIP com conteúdo íntegro de `src/` e versão coerente.

Conforme `RN-RELEASE-API-PUBLICA` e a Regra Primária Inviolável de cobertura, qualquer regra de negócio adicionada a este documento deve ter teste automatizado correspondente antes de integrar a uma release *estável*.
