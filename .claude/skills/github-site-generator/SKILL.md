---
name: github-site-generator
description: Atua como gerador do site GitHub Pages, produzindo docs/site/ e atualizando o README com a URL do Pages.
allowed-tools: Bash, Read, Write, Edit, WebFetch
---

Atue como gerador do site GitHub Pages e produza o site estático do projeto em `docs/site/`, atualizando o `README.md` com a URL do GitHub Pages.

## Passo 1 — Atualizar a versão no README.md

Consulte a última release disponível em https://api.github.com/repos/hibex-solutions/ai-powered-coding-team/releases/latest
e extraia o valor de `tag_name`.

Use a ferramenta `WebFetch` para acessar essa URL (não use `gh api` nem `curl`, pois `gh` pode não estar disponível no ambiente).

Se a resposta for 404 ou `tag_name` estiver vazio, use a string `latest` como versão.

Em seguida, edite o arquivo `README.md` substituindo o segundo argumento do comando de instalação com versão específica pelo valor obtido. A linha a editar segue o padrão:

```
... | bash -s -- meu-projeto <versão-atual>
```

Essa linha aparece no segundo bloco de código da seção "### 1. Instale o template". Substitua apenas o valor da versão nessa linha, mantendo todo o restante inalterado.

## Passo 2 — Derivar a URL do GitHub Pages

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

## Passo 3 — Criar o diretório docs/site/

Se `docs/site/` não existir, crie-o.

## Passo 4 — Gerar docs/site/index.html

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
    <!-- seção: Skills disponíveis (tabela com parágrafo introdutório explicando que cada skill faz o Claude assumir um perfil especializado, não executa um comando avulso) -->
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
- Cards/seções: `background: rgba(13,21,48,0.6); border: 1px solid rgba(79,110,247,0.15); border-radius: 12px; padding: 32px; overflow: hidden` — o `overflow: hidden` é obrigatório para conter blocos de código longos
- Blocos `<pre>`: `background: #0a1020; border: 1px solid rgba(79,110,247,0.25); border-radius: 8px; color: #c0cff0; overflow-x: auto; max-width: 100%`
- `.code-block` (wrapper do `<pre>`): `position: relative; min-width: 0; max-width: 100%` — o `min-width: 0` é obrigatório quando o wrapper está dentro de um flex container para evitar overflow
- Tabelas: cabeçalho com `color: #4f6ef7`, linhas com `border-bottom: 1px solid rgba(255,255,255,0.05)`
- Links: `color: #7c9fff`
- Botão Copiar: `background: rgba(79,110,247,0.15); border: 1px solid rgba(79,110,247,0.3); color: #7c9fff; border-radius: 6px; position: absolute; top: 8px; right: 8px`
- `.code-block:has(.copy-btn) pre`: `padding-top: 40px` — garante que a primeira linha nunca fique sob o botão Copiar, independente do comprimento do texto
- Decorações hex/circuito: `position: fixed; pointer-events: none; z-index: 0; opacity: 0.07`
- `.shields` (linha de badges/shields): `display: flex; flex-wrap: wrap; gap: 8px; justify-content: center; align-items: center` — `align-items: center` é obrigatório para alinhamento vertical uniforme entre imagens e emojis
- `.shields img`: `display: block; height: 20px` — garante que todos os shields tenham a mesma altura e não causem desalinhamento vertical
- `.step-num` (número de passo na seção "Iniciando um novo projeto"): `width: 28px; height: 28px; min-width: 28px; border-radius: 50%; background: linear-gradient(135deg, #4f6ef7, #a855f7); display: flex; align-items: center; justify-content: center; font-size: 0.8rem; font-weight: 700; color: #fff; margin-top: 2px` — círculo com degradê azul→roxo, obrigatório para todos os índices de passo

### Decorações de background obrigatórias

O background deve incluir **obrigatoriamente** os seguintes elementos fixos (portados do `banner.svg`), para garantir consistência visual entre gerações:

1. **Barra de topo** (3px, gradiente azul→roxo, `position: fixed`)
2. **Glow blobs** — dois elementos `div` com `position: fixed`, `background: radial-gradient`, sem interação:
   - `.glow-left`: `top: 10%; left: -10%; width: 500px; height: 400px; background: radial-gradient(ellipse, rgba(79,110,247,0.15) 0%, transparent 70%)`
   - `.glow-right`: `bottom: 10%; right: -10%; width: 450px; height: 380px; background: radial-gradient(ellipse, rgba(168,85,247,0.12) 0%, transparent 70%)`
3. **Grade hexagonal superior direita** — SVG inline com `position: fixed; top: 0; right: 0; opacity: 0.07`, hexágonos em `stroke="#7c9fff"`
4. **Grade hexagonal inferior esquerda** — SVG inline com `position: fixed; bottom: 0; left: 0; opacity: 0.07`, hexágonos em `stroke="#a855f7"`
5. **Linhas de circuito esquerda** — SVG inline com `position: fixed; opacity: 0.12`, linhas em `stroke="#4f6ef7"` com círculos terminais
6. **Linhas de circuito direita** — SVG inline com `position: fixed; opacity: 0.12`, linhas em `stroke="#a855f7"` com círculos terminais

Todos esses elementos devem ter `pointer-events: none; z-index: 0`.

### Layout dos steps de instalação

Os passos da seção "Iniciando um novo projeto" devem usar a estrutura de `div.step` com flex:

```css
.step {
  display: flex;
  gap: 16px;
  margin-bottom: 24px;
  align-items: flex-start;
}

.step-num {
  width: 28px; height: 28px; min-width: 28px;
  border-radius: 50%;
  background: linear-gradient(135deg, #4f6ef7, #a855f7);
  display: flex; align-items: center; justify-content: center;
  font-size: 0.8rem; font-weight: 700; color: #fff;
  margin-top: 2px;
}

/* OBRIGATÓRIO: min-width: 0 para evitar que pre/code estourem o card */
.step-body {
  min-width: 0;
  flex: 1;
}
```

### Layout da seção "Regras fundamentais do modelo"

Esta seção **deve obrigatoriamente** usar o formato de lista com ícone, título e descrição. Nunca use parágrafo ou lista `<ul>/<li>` simples.

CSS obrigatório:

```css
.rules-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.rule-item {
  display: flex;
  gap: 12px;
  align-items: flex-start;
  padding: 12px 16px;
  background: rgba(79,110,247,0.05);
  border: 1px solid rgba(79,110,247,0.12);
  border-radius: 8px;
}
.rule-icon {
  font-size: 1rem;
  min-width: 24px;
}
.rule-text strong { color: #c0cff0; display: block; margin-bottom: 2px; font-size: 0.9rem; }
.rule-text span   { color: #8899cc; font-size: 0.85rem; }
```

HTML obrigatório para cada regra:

```html
<div class="rules-list">
  <div class="rule-item">
    <div class="rule-icon"><!-- emoji --></div>
    <div class="rule-text">
      <strong>Título da regra</strong>
      <span>Breve descrição da regra</span>
    </div>
  </div>
  <!-- repetir para cada regra -->
</div>
```

As regras e ícones devem ser derivados do conteúdo de `docs/ARCHITECTURE.md`. Exemplos de mapeamento:
- 📋 Especificação antes de implementação — Nenhuma funcionalidade sem regra de negócio documentada
- 📂 Nenhuma tecnologia sem registro — Toda stack deve estar em `docs/SOLUTION.md`
- 🧪 Testes guiados por negócio — Cobertura 100% das regras especificadas
- 🔒 Secrets nunca no código — Sempre configuráveis por ambiente
- ⚙️ The Twelve-Factor App — Software aderente aos doze fatores
- 🤝 Commits são humanos — A IA propõe, o engenheiro commita

### Conteúdo das seções (baseado no README.md)

Use o conteúdo de `README.md` como fonte para todas as seções. Leia o arquivo antes de gerar.

### Seção "Skills disponíveis"

A seção deve abrir com um parágrafo introdutório antes da tabela:

```html
<p>Cada skill faz o Claude assumir um perfil especializado. Para ativar, use <code>/nome-da-skill</code> numa sessão do Claude Code.</p>
```

A tabela deve ter duas colunas: **Skill** e **Perfil assumido / Descrição**. Liste as 5 skills na seguinte ordem, usando o padrão "Atua como [papel] — [descrição]":

| Skill | Perfil assumido / Descrição |
|---|---|
| `/architect-reviewer` | Atua como arquiteto revisor — valida conformidade com `ARCHITECTURE.md`, `SOLUTION.md` e os 12 fatores |
| `/business-reviewer` | Atua como revisor de negócio — valida conformidade entre `BUSINESS.md`, implementação e cobertura de testes |
| `/guideline-reviewer` | Atua como revisor de UX — valida conformidade entre `GUIDELINE.md` e as interfaces construídas |
| `/dotnet-engineer` | Atua como engenheiro .NET — implementa componentes seguindo a arquitetura limpa (TheCleanArch) |
| `/github-site-generator` | Atua como gerador de site — produz o GitHub Pages em `docs/site/` e atualiza o README |

### URLs de instalação

Nos blocos de código da seção de instalação, use a `PAGES_URL` derivada no Passo 2 diretamente. Exemplo:

```html
<pre><code>curl -fsSL <PAGES_URL>/install.sh | bash -s -- meu-projeto</code></pre>
```

## Resultado

Ao final, informe:
- Caminho do arquivo gerado: `docs/site/index.html`
- URL base utilizada
- Que o `README.md` foi atualizado com a versão e a URL do GitHub Pages

Não faça commits.
