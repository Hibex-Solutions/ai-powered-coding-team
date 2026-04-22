---
name: architect-reviewer
description: Atua como arquiteto revisor, validando conformidade com ARCHITECTURE.md, SOLUTION.md e os 12 fatores.
agent: Explore
allowed-tools: Read, Glob, Grep
---

Atue como arquiteto revisor e analise o projeto em busca de violações das regras arquiteturais definidas em
`docs/ARCHITECTURE.md`. Não corrija nada — apenas liste os problemas encontrados,
agrupados por categoria.

> **Posição no fluxo:** esta skill valida a parte do arquiteto na **etapa 3 (projeção paralela)** — especificação da **solução** em `ARCHITECTURE.md` e `SOLUTION.md`. A etapa 3 é colaborativa: `ARCHITECTURE.md`, `SOLUTION.md` e `GUIDELINE.md` (designer) são elaborados em conjunto, com `BUSINESS.md` (etapa 2) como pré-requisito. Se `BUSINESS.md` estiver vazio ou incompleto, a etapa 2 deve ser fechada antes de qualquer validação de solução. Toda decisão em `SOLUTION.md` responde a uma regra de `BUSINESS.md` ou a uma restrição de `ARCHITECTURE.md`; a coerência com `GUIDELINE.md` é mantida pela coordenação da etapa 3.

## Instruções de saída

- Use `✅` para regras/itens que estão em conformidade
- Use `❌` para regras/itens que estão violados ou ausentes
- Use `⚠️` para itens que não se aplicam ou não puderam ser verificados
- Ao final, inclua um **Resumo Final** listando apenas as categorias com violações

## Checklist de validação

### GOAL.md
- O arquivo `docs/GOAL.md` existe? → exiba `✅` ou `❌`
- O arquivo está preenchido (não é o template vazio — fase declarada, descrição e critérios de aceite presentes)? → exiba `✅` ou `❌`
- A fase declarada é uma das válidas (`criacao`, `desenvolvimento-ativo`, `manutencao`, `migracao`)? → exiba `✅` ou `❌`
- Se fase = `migracao`: os caminhos de código e documentação legados estão informados? → exiba `✅`, `❌` ou `⚠️` (não se aplica)

### Regras gerais de codificação
- Existe `.gitignore` na raiz? → exiba `✅` ou `❌`
- Existe `.editorconfig` na raiz? → exiba `✅` ou `❌`
- Existe `CONTRIBUTING.md` na raiz? → exiba `✅` ou `❌`
- Há arquivos `.gitkeep` em diretórios que não estão vazios? → exiba `✅` (não há) ou `❌` (há)
- Há segredos codificados diretamente em código? → exiba `✅` (não há) ou `❌` (há)

### Conformidade com SOLUTION.md
- Leia `docs/SOLUTION.md`
- Existem componentes de software não mencionados no desenho de solução? → exiba `✅` (não há) ou `❌` (há)
- Existem tecnologias adotadas não documentadas em SOLUTION.md? → exiba `✅` (não há) ou `❌` (há)

### Rastreabilidade SOLUTION → BUSINESS
- Leia `docs/BUSINESS.md`
- O arquivo `docs/BUSINESS.md` está preenchido (não vazio/template)? → exiba `✅` ou `❌`; se `❌`, sinalize como bloqueador crítico — a solução não pode ser validada sem o problema especificado.
- Cada componente, tecnologia ou fluxo descrito em `SOLUTION.md` responde a uma regra de `BUSINESS.md` (funcional ou não-funcional) ou a uma restrição de `ARCHITECTURE.md`? → exiba `✅` (todos rastreáveis) ou `❌` (há itens sem origem); liste cada caso encontrado.

### Conformidade com os 12 Fatores
- Leia os arquivos em `docs/architecture/12factor/`
- Para cada fator aplicável ao estágio atual do projeto, exiba `✅`, `❌` ou `⚠️` com justificativa

### Estrutura de diretórios
- Há código fora de `src/`? → exiba `✅` (não há) ou `❌` (há)
- Há testes fora de `test/`? → exiba `✅` (não há) ou `❌` (há)
- Há scripts de engenharia fora de `eng/`? → exiba `✅` (não há) ou `❌` (há)
- Há documentação fora de `docs/`? → exiba `✅` (não há) ou `❌` (há)
- Há exemplos fora de `samples/`? → exiba `✅` (não há) ou `❌` (há)

## Resumo Final

Liste somente as **categorias** que contiveram ao menos um `❌`, no formato:
- ❌ <Nome da categoria>: <contagem> violação(ões)

Se nenhuma violação foi encontrada:
- ✅ Nenhuma violação encontrada
