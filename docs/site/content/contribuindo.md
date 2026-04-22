---
title: "Contribuindo"
weight: 5
---

{{% card title="Contribuindo" %}}

Contribuições são bem-vindas — especialmente melhorias nas instruções da IA, novas skills de revisão, e suporte a outros assistentes além do Claude Code.

Veja [CONTRIBUTING.md](https://github.com/hibex-solutions/ai-powered-coding-team/blob/main/CONTRIBUTING.md) para entender as responsabilidades de cada perfil e as regras de colaboração.

### Perfis e fluxo

O projeto é desenvolvido em quatro etapas. As duas primeiras são sequenciais — objetivo e problema. A terceira é uma **etapa de projeção paralela** em que designer e arquiteto produzem três artefatos coordenados. A quarta é a implementação. `BUSINESS.md` descreve o problema; `SOLUTION.md` descreve a solução para esse problema.

Em **todas as etapas**, a IA produz o artefato (documento ou código) e o papel humano correspondente supervisiona, revisa e commita.

| Etapa | Perfil que supervisiona | Documento / entrega produzido pela IA |
|---|---|---|
| 1 | Engenheiro de Software | `docs/GOAL.md` — objetivo do projeto, fase atual e critérios de aceite |
| 2 | Analista de negócio | `docs/BUSINESS.md` — problema e regras de negócio |
| 3 (projeção, paralela) | Designer + Arquiteto de soluções | `docs/GUIDELINE.md` (designer) + `docs/ARCHITECTURE.md` e `docs/SOLUTION.md` (arquiteto) — marca/UX, regras arquiteturais e solução técnica |
| 4 | Engenheiro de Software | código em `src/` e testes em `test/` |

Os três artefatos da etapa 3 são elaborados em conjunto. Os papéis podem ser distribuídos entre profissionais distintos ou acumulados em um único profissional.

### Como contribuir

- **Skills**: Melhorias nas instruções existentes ou novas skills para outros papéis
- **Stacks**: Suporte a novas stacks além do ASP.NET
- **Documentação**: Correções e melhorias no conteúdo deste site
- **Assistentes de IA**: Adaptações para outros assistentes além do Claude Code

{{% /card %}}

{{% card title="Documentação local" %}}

Para visualizar este site localmente durante o desenvolvimento, é necessário ter o [Hugo Extended v0.147+](https://gohugo.io/installation/) instalado:

```bash
hugo server --source docs/site
```

Acesse em `http://localhost:1313/ai-powered-coding-team/`. O servidor recarrega automaticamente ao salvar arquivos.

{{% /card %}}

{{% card title="Licença" %}}

<div class="contrib-grid">
  <div class="contrib-card">
    <h3>Licença MIT</h3>
    <p>
      Distribuído sob a licença <a href="https://github.com/hibex-solutions/ai-powered-coding-team/blob/main/LICENSE">MIT</a>.<br><br>
      Copyright © 2026 <a href="https://github.com/hibex-solutions">Hibex Solutions</a>
    </p>
  </div>
  <div class="contrib-card">
    <h3>Código de conduta</h3>
    <p>
      Este projeto adota o <a href="https://github.com/hibex-solutions/ai-powered-coding-team/blob/main/CODE_OF_CONDUCT.md">Contributor Covenant</a> como código de conduta. Ao contribuir, você concorda em respeitar seus termos.
    </p>
  </div>
</div>

{{% /card %}}
