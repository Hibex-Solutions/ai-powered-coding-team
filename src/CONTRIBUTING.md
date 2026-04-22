# Guia de Contribuição

Este documento descreve as responsabilidades e ações esperadas de cada perfil que contribui com este projeto.

Toda contribuição deve respeitar as regras definidas em `docs/ARCHITECTURE.md`, em especial as *Regras primárias invioláveis*.

---

## Fluxo de trabalho

O projeto é desenvolvido em quatro etapas. As duas primeiras são sequenciais — objetivo e problema. A terceira é uma **etapa de projeção paralela** em que designer e arquiteto produzem três artefatos coordenados. A quarta é a implementação. Cada etapa é pré-requisito da seguinte para o escopo em questão — pular etapas viola as regras primárias invioláveis.

| Etapa | Perfil | Documento entregue | O que é especificado |
|---|---|---|---|
| 1 | Engenheiro de Software | `docs/GOAL.md` | Objetivo do projeto, fase atual e critérios de aceite |
| 2 | Analista de negócio | `docs/BUSINESS.md` | **Problema** a ser resolvido e regras de negócio |
| 3 (projeção, paralela) | Designer + Arquiteto de soluções | `docs/GUIDELINE.md` (designer) + `docs/ARCHITECTURE.md` e `docs/SOLUTION.md` (arquiteto) | Diretrizes de marca/UX, regras arquiteturais invioláveis e **solução** técnica para o problema — os três artefatos são elaborados em conjunto |
| 4 | Engenheiro de Software | `src/`, `test/` | Implementação aderente à solução, com cobertura das regras de negócio |

> `BUSINESS.md` descreve o **problema**; `SOLUTION.md` descreve a **solução** para esse problema. Toda decisão em `SOLUTION.md` deve ter origem rastreável em `BUSINESS.md` ou em `ARCHITECTURE.md`.

> Os papéis da etapa 3 podem ser distribuídos entre profissionais distintos (designer e arquiteto separados) ou acumulados em um único profissional que assume os dois papéis. Em ambos os casos, os três artefatos se coordenam entre si.

---

## Analista de negócio

**Documentos sob sua responsabilidade:** `docs/BUSINESS.md`

**Etapa no fluxo:** 2 — especificação do **problema**.

**Ações esperadas:**

- Supervisionar a produção de `docs/BUSINESS.md` pela IA, garantindo que problema e regras de negócio estejam documentados antes de qualquer projeto de solução ou implementação. A IA propõe o conteúdo; o analista revisa, ajusta e commita.
- Atribuir identificador estável e testável a cada regra, para que `business-reviewer` possa rastreá-la na implementação e nos testes.
- Garantir que toda funcionalidade proposta tenha correspondência negocial documentada.
- Usar `/business-reviewer` para validar cobertura de todas as regras em `docs/BUSINESS.md` pela implementação e pelos testes.

---

## Designer

**Documentos sob sua responsabilidade:** `docs/GUIDELINE.md`

**Etapa no fluxo:** 3 — parte da etapa de projeção paralela, em coordenação com o arquiteto (que produz `ARCHITECTURE.md` e `SOLUTION.md`). Entra após `BUSINESS.md` estar consolidado para o escopo.

**Ações esperadas:**

- Supervisionar a produção de `docs/GUIDELINE.md` pela IA, garantindo que padrões visuais, de marca e de experiência do usuário estejam documentados. A IA propõe o conteúdo; o designer revisa, ajusta e commita.
- Manter o Guideline atualizado sempre que houver evolução nas diretrizes de marca ou UX, em sessões supervisionadas com a IA.
- Garantir que nenhum comportamento de interface viole as regras estabelecidas no Guideline.
- Usar `/guideline-reviewer` para validar conformidade das interfaces com `docs/GUIDELINE.md`.

---

## Arquiteto de soluções

**Documentos sob sua responsabilidade:** `docs/ARCHITECTURE.md`, `docs/SOLUTION.md`

**Etapa no fluxo:** 3 — parte da etapa de projeção paralela, em coordenação com o designer (que produz `GUIDELINE.md`). Entra após `BUSINESS.md` estar consolidado para o escopo.

**Ações esperadas:**

- Supervisionar a produção e manutenção de `docs/ARCHITECTURE.md` pela IA, garantindo que as regras arquiteturais invioláveis que atuam sobre toda a solução estejam atualizadas. A IA propõe o conteúdo; o arquiteto revisa, ajusta e commita.
- Supervisionar a projeção da solução em `docs/SOLUTION.md` pela IA, somente após `BUSINESS.md` estar consolidado para o escopo; cada componente e tecnologia ali deve responder a uma regra de `BUSINESS.md` ou a uma restrição de `ARCHITECTURE.md`.
- Usar `/c4model-architectural-designer` para criar e manter os diagramas C4Model inline em `docs/SOLUTION.md` (ou em `docs/solution/` quando forem diagramas complementares), documentando contexto, containers e componentes da solução.
- Garantir que nenhuma tecnologia ou componente seja adotado sem estar registrado no desenho de solução.
- Usar `/architect-reviewer` para validar conformidade com `docs/ARCHITECTURE.md`, os doze fatores e a rastreabilidade SOLUTION → BUSINESS antes de mudanças estruturais ou de release.

---

## Engenheiro de Software

**Documentos sob sua responsabilidade:** `docs/GOAL.md` e código em `src/` e `test/`.

**Etapa no fluxo:** 1 (GOAL, antes de tudo) e 4 (implementação, após a etapa 3 de projeção estar consolidada).

**Ações esperadas:**

- Supervisionar a produção e manutenção de `docs/GOAL.md` pela IA, garantindo que objetivo, fase atual e critérios de aceite estejam sempre presentes (nunca no estado de template vazio). Essa é a primeira etapa do fluxo — antes do analista começar a especificar o problema, o engenheiro precisa ter deixado claro qual objetivo está em curso.
- A IA é a produtora de **todos** os artefatos (documentos normativos e código), em todas as etapas — não há um momento em que se "delega à IA depois das especificações prontas". Cada papel humano abre sua própria sessão (no momento, na máquina e com a ferramenta que preferir) para supervisionar a produção do artefato sob sua responsabilidade.
- Na etapa 4, supervisionar a IA produzindo a implementação, revisando e validando cada entrega antes de commitar.
- Garantir que toda implementação tenha cobertura de testes baseada nas regras de negócio documentadas.
- Nunca commitar artefato (documento normativo ou código) sem revisão — a IA propõe; o papel humano correspondente decide e commita.
- Quando o projeto tiver sido inicializado com uma stack específica, usar a skill de engenheiro correspondente (ver tabela abaixo) para manter a implementação aderente às convenções da stack.

---

## Skills disponíveis

Cada skill faz a IA assumir um perfil especializado — não são comandos avulsos, mas contextos de atuação que a IA assume durante a sessão. Para ativar, use `/nome-da-skill` no seu assistente de IA.

| Skill | Perfil assumido | Disponibilidade |
|---|---|---|
| `/c4model-architectural-designer` | Designer de arquitetura — cria diagramas C4Model com sintaxe Mermaid em `docs/solution/` | Sempre |
| `/architect-reviewer` | Arquiteto revisor — valida conformidade com `docs/ARCHITECTURE.md` e os doze fatores | Sempre |
| `/business-reviewer` | Revisor de negócio — valida cobertura das regras em `docs/BUSINESS.md` | Sempre |
| `/guideline-reviewer` | Revisor de UX — valida conformidade das interfaces com `docs/GUIDELINE.md` | Sempre |
| `/aspnet-engineer` | Engenheiro ASP.NET — implementa componentes seguindo a arquitetura limpa (TheCleanArch) | Somente se inicializado com `--stack aspnet` |

> Skills marcadas como stack-específicas são incluídas no projeto apenas quando o script de inicialização do framework foi executado com a opção `--stack <nome>` correspondente. Se a stack não foi selecionada no início do projeto, a skill não estará disponível.

> **Produção vs. validação.** As skills `*-reviewer` são de **validação** — ativadas após a produção do respectivo documento ou da implementação. `c4model-architectural-designer` é a única skill **produtora** distribuída por padrão e atua dentro da etapa 3 sobre os diagramas inline em `SOLUTION.md`. A produção do **texto** dos documentos normativos (GOAL, BUSINESS, GUIDELINE, ARCHITECTURE, SOLUTION) é feita pela IA na sessão padrão do assistente, sem skill especializada, sob supervisão do papel humano correspondente.
