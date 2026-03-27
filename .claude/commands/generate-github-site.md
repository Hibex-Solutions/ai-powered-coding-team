---
description: Gera o site estático para GitHub Pages em docs/site/ e atualiza o README com a URL do Pages.
allowed-tools: Bash, Read, Write, Edit
---

Gera o site estático do projeto em `docs/site/` e atualiza o `README.md` com a URL do GitHub Pages.

## Passo 1 — Derivar a URL do GitHub Pages

Execute:

```bash
git remote get-url origin
```

A URL pode estar em dois formatos:
- SSH: `git@github.com:owner/repo.git`
- HTTPS: `https://github.com/owner/repo.git`

Em ambos os casos, extraia `owner` e `repo` (sem o sufixo `.git`) e construa:

```
PAGES_URL = https://<owner>.github.io/<repo>
```

## Passo 2 — Criar o diretório docs/site/

Se `docs/site/` não existir, crie-o.

## Passo 3 — Gerar docs/site/index.html

Escreva um arquivo HTML autocontido e moderno seguindo estritamente a identidade visual do `banner.svg`
(`.github/assets/banner.svg`). O HTML deve ser uma única página com CSS e JS inline.
**Não use dependências externas**, exceto Google Fonts (Inter).

### Paleta de cores (extraída do banner.svg)

```
--bg-deep:       #080d1a
--bg-surface:    #0f1729
--bg-card:       #0d1530
--accent-blue:   #4f6ef7
--accent-purple: #a855f7
--title-start:   #7c9fff
--title-mid:     #ffffff
--title-end:     #c084fc
--text-secondary:#8899cc
--text-muted:    #3a4a6a
--green:         #10b981
```

### Estrutura do HTML

```
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="...">
  <title>AI Powered Coding Team</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <style>
    /* todo o CSS inline aqui */
  </style>
</head>
<body>
  <!-- barra de topo: gradiente #4f6ef7 → #a855f7, 3px, position fixed -->
  <!-- decorações SVG: hexágonos e linhas de circuito portados do banner.svg -->
  <header>
    <!-- badge "AI POWERED" (pill com borda gradiente) -->
    <!-- h1 com gradient text: #7c9fff → #fff → #c084fc -->
    <!-- tagline em #8899cc -->
    <!-- 4 role badges (mesmo estilo do banner.svg): -->
    <!--   Arquiteto: border #4f6ef7, bg #0f1f3d -->
    <!--   Analista:  border #7c3aed, bg #1a1040 -->
    <!--   Designer:  border #a855f7, bg #1a0f2e -->
    <!--   Engenheiro:border #10b981, bg #071a10 -->
    <!-- shields: MIT, Claude Code, Contribuição bem-vinda -->
  </header>
  <main>
    <!-- seção: O que é (tabela de papéis) -->
    <!-- seção: Como funciona (diagrama ASCII em <pre>) -->
    <!-- seção: Pré-requisitos -->
    <!-- seção: Iniciando um novo projeto (instalação) -->
    <!-- seção: Estrutura do projeto (árvore em <pre>) -->
    <!-- seção: Comandos disponíveis (tabela) -->
    <!-- seção: Regras fundamentais do modelo (lista) -->
    <!-- seção: Contribuindo e Licença -->
  </main>
  <footer>
    <!-- "Feito com ♥ por Hibex Solutions" -->
  </footer>
  <script>
    /* clipboard copy para blocos de código */
  </script>
</body>
</html>
```

### Detalhes de CSS obrigatórios

- `body`: `background: linear-gradient(135deg, #080d1a, #0f1729)`, `font-family: 'Inter', 'Segoe UI', sans-serif`, `color: #ffffff`
- Barra de topo: `position: fixed; top: 0; left: 0; right: 0; height: 3px; background: linear-gradient(90deg, #4f6ef7, #a855f7); z-index: 100`
- `h1`: `font-size: clamp(2.5rem, 6vw, 4.5rem); font-weight: 800; background: linear-gradient(90deg, #7c9fff, #ffffff, #c084fc); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text`
- `h2`: `color: #7c9fff; border-bottom: 1px solid rgba(79,110,247,0.3); padding-bottom: 8px`
- Cards/seções: `background: rgba(13,21,48,0.6); border: 1px solid rgba(79,110,247,0.15); border-radius: 12px; padding: 32px`
- Blocos `<pre>/<code>`: `background: #0a1020; border: 1px solid rgba(79,110,247,0.25); border-radius: 8px; color: #c0cff0`
- Tabelas: cabeçalho com `color: #4f6ef7`, linhas com `border-bottom: 1px solid rgba(255,255,255,0.05)`
- Links: `color: #7c9fff`
- Botão Copiar: `background: rgba(79,110,247,0.15); border: 1px solid rgba(79,110,247,0.3); color: #7c9fff; border-radius: 6px`
- Decorações hex/circuito: `position: fixed; pointer-events: none; z-index: 0; opacity: 0.07`

### Conteúdo das seções (baseado no README.md)

Use o conteúdo de `README.md` como fonte para todas as seções. Leia o arquivo antes de gerar.

### URLs de instalação

Nos blocos de código da seção de instalação, use o placeholder literal:

```
@@INSTALL_BASE_URL@@
```

Exemplo do bloco:

```html
<pre><code>curl -fsSL @@INSTALL_BASE_URL@@/install.sh | bash -s -- meu-projeto</code></pre>
```

Esse placeholder será substituído pela URL real ao executar `eng/update-site-data.sh`.

## Passo 4 — Executar eng/update-site-data.sh

Após escrever `docs/site/index.html`, execute:

```bash
bash eng/update-site-data.sh "<PAGES_URL>"
```

Substituindo `<PAGES_URL>` pelo valor derivado no Passo 1.

## Passo 5 — Atualizar README.md

Edite `README.md` substituindo as duas ocorrências da URL do `install.sh` na seção `### 1. Instale o template`:

- De: `https://raw.githubusercontent.com/hibex-solutions/ai-powered-coding-team/main/eng/install.sh`
- Para: `<PAGES_URL>/install.sh`

Altere somente as URLs dentro dos blocos de código dessa seção. Não altere nenhuma outra linha.

## Resultado

Ao final, informe:
- Caminho do arquivo gerado: `docs/site/index.html`
- URL base utilizada
- Que o `README.md` foi atualizado

Não faça commits.
