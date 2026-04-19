<!--
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

