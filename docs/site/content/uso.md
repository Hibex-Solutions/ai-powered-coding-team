---
title: "Como usar"
weight: 2
---

{{% card title="Skills disponíveis" %}}
Cada skill faz o assistente de IA assumir um perfil especializado em uma etapa do fluxo de desenvolvimento do framework: **etapa 1** — engenheiro define o objetivo em `GOAL.md`; **etapa 2** — analista de negócio define o problema em `BUSINESS.md`; **etapa 3 (projeção, paralela)** — designer e arquiteto produzem, em colaboração, `GUIDELINE.md` (marca/UX), `ARCHITECTURE.md` (regras arquiteturais) e `SOLUTION.md` (solução técnica); **etapa 4** — engenheiro implementa em `src/` e `test/`. Para ativar, use `/nome-da-skill` numa sessão do seu assistente de IA.

| Skill | Etapa | Perfil assumido / Descrição |
|---|---|---|
| `/business-reviewer` | 2 — problema | Atua como revisor de negócio — valida conformidade entre `BUSINESS.md`, implementação e cobertura de testes |
| `/guideline-reviewer` | 3 — projeção (marca/UX) | Atua como revisor de UX — valida conformidade entre `GUIDELINE.md` e as interfaces construídas |
| `/c4model-architectural-designer` | 3 — projeção (solução) | Atua como designer de arquitetura — cria diagramas C4Model em `docs/SOLUTION.md` com rastreabilidade para `BUSINESS.md` |
| `/architect-reviewer` | 3 — projeção (arquitetura/solução) | Atua como arquiteto revisor — valida conformidade com `ARCHITECTURE.md`, `SOLUTION.md`, os 12 fatores e a rastreabilidade SOLUTION → BUSINESS |
| `/aspnet-engineer` | 4 — implementação | Atua como engenheiro ASP.NET — implementa componentes seguindo a arquitetura limpa (TheCleanArch) |

> Os três artefatos da **etapa 3** são produzidos em paralelo, com coordenação entre designer e arquiteto — por profissionais distintos ou por um único profissional que acumula os papéis.
{{% /card %}}
