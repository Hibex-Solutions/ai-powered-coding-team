---
name: guideline-reviewer
description: Atua como revisor de guideline e UX, validando conformidade entre GUIDELINE.md e as interfaces construídas.
agent: Explore
allowed-tools: Read, Glob, Grep
---

Atue como revisor de guideline e UX e analise o projeto em busca de violações das diretrizes de marca e experiência do usuário
definidas em `docs/GUIDELINE.md`. Não corrija nada — apenas liste os problemas encontrados.

> **Posição no fluxo:** esta skill valida a parte do designer na **etapa 3 (projeção paralela)** — especificação das diretrizes de marca, UI e UX em `GUIDELINE.md`. A etapa 3 é colaborativa: `GUIDELINE.md`, `ARCHITECTURE.md` e `SOLUTION.md` são elaborados em conjunto por designer e arquiteto, com `BUSINESS.md` (etapa 2) como pré-requisito. Os três artefatos são pré-requisito consolidado para a **etapa 4** (implementação em `src/` e `test/`).

## Instruções de saída

- Use `✅` para regras/itens que estão em conformidade
- Use `❌` para regras/itens que estão violados ou ausentes
- Use `⚠️` para itens que não se aplicam ou não puderam ser verificados
- Ao final, inclua um **Resumo Final** listando apenas as categorias com violações

## Checklist de validação

### Cobertura de diretrizes
- Leia `docs/GUIDELINE.md` e extraia todas as diretrizes definidas (cores, tipografia,
  espaçamentos, comportamentos, componentes visuais, etc.)
- Para cada diretriz encontrada:
  - Está sendo seguida nas interfaces em `src/`? → exiba `✅` ou `❌` com referência ao arquivo e linha

### Comportamentos do usuário
- Existe algum comportamento de usuário implementado que viola as regras de Guideline? → exiba `✅` (não há) ou `❌` (há); liste cada caso
- Existe algum componente visual não previsto no Guideline? → exiba `✅` (não há) ou `❌` (há); liste cada caso

### Consistência geral
- O GUIDELINE.md está vazio ou incompleto? → exiba `✅` (completo) ou `❌` (vazio/incompleto); se `❌`, sinalize como bloqueador crítico para qualquer revisão de interface

## Resumo Final

Liste somente as **categorias** que contiveram ao menos um `❌`, no formato:
- ❌ <Nome da categoria>: <contagem> violação(ões)

Se nenhuma violação foi encontrada:
- ✅ Nenhuma violação encontrada
