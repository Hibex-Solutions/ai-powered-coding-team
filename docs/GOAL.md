<!--
  Este arquivo é incluído no contexto do assistente de IA via diretiva @-include.
  Não use cabeçalhos H1 (#) nem H2 (##) — as seções devem iniciar em H3 (###).
-->

### Fase atual

**Fase:** `criacao`
> O framework está sendo construído do zero. A primeira versão ainda não foi publicada.

---

### Descrição do objetivo atual

Entregar a **v1** do framework **AI Powered Coding Team** — um template instalável que estrutura papéis, documentos normativos e delegação supervisionada a assistentes de IA para o desenvolvimento de software.

O framework é construído sob as mesmas regras que impõe aos seus consumidores (*dogfooding*): nenhum código sem especificação, nenhuma decisão técnica sem documentação, toda implementação validada contra regras de negócio e diretrizes de marca.

---

### Critérios de aceite

- [ ] Release **v1.0.0** publicada em GitHub Releases, com ZIP gerado por `eng/release.sh` e versão resolvida por GitVersion.
- [ ] Site público operacional em `https://hibex-solutions.github.io/ai-powered-coding-team/`, servindo `install.sh` e `install.ps1` como assets estáticos.
- [ ] `eng/install.sh` validado manualmente em Linux e macOS; `eng/install.ps1` validado manualmente em Windows.
- [ ] Instalação com `--stack aspnet` instala a skill `aspnet-engineer` em `.claude/skills/` e substitui o `docs/SOLUTION.md` do projeto consumidor pelo da stack.
- [ ] Instalação com `--stack` inexistente falha com mensagem clara listando as stacks disponíveis e remove o diretório de destino.
- [ ] Os cinco documentos normativos da raiz (`docs/GOAL.md`, `docs/ARCHITECTURE.md`, `docs/SOLUTION.md`, `docs/BUSINESS.md`, `docs/GUIDELINE.md`) estão preenchidos e respeitam a convenção de includes.
- [ ] `.claude/CLAUDE.md` da raiz instrui o assistente de IA para o contexto de manutenção do framework (e não de um projeto consumidor).
- [ ] Skills genéricas em `src/.claude/skills/` (`architect-reviewer`, `business-reviewer`, `guideline-reviewer`, `c4model-architectural-designer`) estão presentes, com `SKILL.md` válido, e listadas na tabela de `src/CONTRIBUTING.md`.
- [ ] `CONTRIBUTING.md` da raiz descreve o desenvolvimento do framework sob os mesmos quatro papéis (arquiteto de soluções, analista de negócio, designer, engenheiro de software) aplicados às áreas de contribuição (core, stacks, skills), e cita separadamente as atribuições de governança dos *committers*.
