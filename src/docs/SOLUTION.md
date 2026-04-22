<!--
  Template — Especificação da SOLUÇÃO técnica do seu projeto.

  Este documento descreve a solução técnica para o problema e as regras de negócio
  especificadas em `BUSINESS.md`. Cada componente, tecnologia, fluxo e diagrama aqui
  deve responder a uma regra de `BUSINESS.md` (funcional ou não-funcional) ou a uma
  restrição de `ARCHITECTURE.md`.

  Responsável: arquiteto de soluções (em conjunto com o designer para os aspectos
  cobertos por `GUIDELINE.md`).
  Pré-requisito: `BUSINESS.md` consolidado para o escopo.
  Serve de base para: implementação pelo engenheiro.

  Use `/c4model-architectural-designer` para incorporar diagramas C4Model (Contexto,
  Contêiner, Componente, Dinâmico) inline nas seções em que o assunto ilustrado é
  tratado. Use `/architect-reviewer` para validar a conformidade com `ARCHITECTURE.md`
  e a rastreabilidade para `BUSINESS.md`.

  Este arquivo é incluído no contexto do assistente de IA via diretiva @-include.
  Não use cabeçalhos H1 (#) nem H2 (##) — as seções devem iniciar em H3 (###).
-->

### Site de documentação

O site público de documentação é gerado pelo **Hugo** (Extended v0.147+), um gerador de site estático.

- Projeto Hugo: `docs/site/`
- Conteúdo: `docs/site/content/` (arquivos Markdown com shortcodes)
- Templates: `docs/site/layouts/` (HTML com Go templates)
- CSS/JS: `docs/site/static/`
- Publicação: GitHub Pages via `.github/workflows/pages.yml`, a cada push em `main`
- Preview local: `hugo server --source docs/site`

