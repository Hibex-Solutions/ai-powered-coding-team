# Guia de Contribuição

Este documento descreve as responsabilidades e ações esperadas de cada perfil que contribui com o projeto.
Toda contribuição deve respeitar as regras definidas em `docs/ARCHITECTURE.md`.

---

## Arquiteto de soluções

**Documentos sob sua responsabilidade:** `docs/ARCHITECTURE.md`, `docs/SOLUTION.md`

**Ações esperadas:**

- Validar a arquitetura com o Claude Code — revisar aderência às regras primárias invioláveis antes de qualquer mudança estrutural
- Atualizar as definições do Twelve-Factor App em `docs/architecture/12factor/` sempre que houver mudança na stack ou no modelo de implantação
- Manter `docs/SOLUTION.md` atualizado conforme a solução evolui, garantindo que componentes e tecnologias adotados estejam documentados
- Garantir que nenhuma tecnologia ou componente seja adotado sem estar registrado no desenho de solução

### Tarefas de engenharia disponíveis

| Script (Linux/macOS) | Script (Windows) | Descrição |
|---|---|---|
| `eng/update-12factor.sh` | `eng/update-12factor.ps1` | Atualiza os documentos de `docs/architecture/12factor/` a partir do repositório oficial `heroku/12factor` (pt_br). |

---

## Analista de negócio

**Documentos sob sua responsabilidade:** `docs/BUSINESS.md`

**Ações esperadas:**

- Documentar regras de negócio em `docs/BUSINESS.md` antes de qualquer implementação de funcionalidade
- Garantir que toda funcionalidade proposta tenha correspondência negocial documentada

---

## Designer

**Documentos sob sua responsabilidade:** `docs/GUIDELINE.md`

**Ações esperadas:**

- Documentar padrões visuais, de marca e de experiência do usuário em `docs/GUIDELINE.md`
- Atualizar o Guideline sempre que houver evolução nas diretrizes de marca ou UX
- Garantir que nenhum comportamento de interface viole as regras estabelecidas no Guideline

