<p align="center">
  <img src=".github/assets/banner.png" alt="AI Powered Coding Team" width="100%"/>
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/licença-MIT-4f6ef7?style=flat-square" alt="Licença MIT"/></a>
  <img src="https://img.shields.io/badge/AI-powered-a855f7?style=flat-square" alt="AI Powered"/>
  <a href="CONTRIBUTING.md"><img src="https://img.shields.io/badge/contribuição-bem--vinda-10b981?style=flat-square" alt="Contribuições bem-vindas"/></a>
  <img src="https://img.shields.io/badge/Open_Source-♥-ff6b6b?style=flat-square" alt="Open Source"/>
</p>

<br/>

> **O poder aprimorado por IA de uma equipe inteira de desenvolvimento, com ou sem uma equipe.**

**AI Powered Coding Team** é um modelo de projeto que estrutura papéis, responsabilidades e fluxos de trabalho para desenvolvimento guiado por IA. Funciona em dois modos:

- **Solo** — um único engenheiro sênior assume todos os papéis (arquiteto, analista, designer, engenheiro) e delega a execução para a IA sob sua supervisão.
- **Time** — cada profissional atua com sua própria expertise, usando a IA para ampliar individualmente sua capacidade de entrega, com a mesma base estrutural compartilhada entre todos.

Em ambos os casos, o modelo garante que **nenhum código seja escrito sem especificação**, que **nenhuma decisão técnica seja tomada sem documentação** e que **toda implementação seja validada contra regras de negócio e diretrizes de marca**.

---

## Início rápido

**1. Instale o template** no diretório do seu novo projeto:

```bash
curl -fsSL https://hibex-solutions.github.io/ai-powered-coding-team/install.sh | bash -s -- meu-projeto
```

**2. Especifique antes de implementar** — preencha os documentos do projeto seguindo o fluxo de quatro etapas: **engenheiro (objetivo) → analista (problema) → projeção paralela por designer e arquiteto (marca + arquitetura + solução) → engenheiro (implementação)**. Antes de qualquer linha de código:

- `docs/GOAL.md` — objetivo do projeto, fase atual e critérios de aceite *(engenheiro, etapa 1)*
- `docs/BUSINESS.md` — **problema** e regras de negócio *(analista, etapa 2)*
- `docs/GUIDELINE.md` — padrões de marca, UI e UX *(designer, etapa 3 — em paralelo com arquitetura e solução)*
- `docs/ARCHITECTURE.md` — decisões arquiteturais e regras invioláveis *(arquiteto, etapa 3)*
- `docs/SOLUTION.md` — **solução** para o problema: componentes, tecnologias e desenho *(arquiteto, etapa 3)*

Os três artefatos da etapa 3 são projetados em conjunto — por profissionais distintos ou por um único profissional acumulando os papéis.

**3. Delegue para a IA** — com as especificações em mãos, inicie seu assistente de IA (ex: `claude` para Claude Code):

```bash
cd meu-projeto && claude
```

O `CLAUDE.md` do projeto já instrui a IA com todas as regras e especificações — sem precisar repetir contexto a cada sessão.

---

## Documentação completa

Instalação com stacks, boas práticas, skills disponíveis e mais em:

**https://hibex-solutions.github.io/ai-powered-coding-team/**

Para visualizar a documentação localmente, é necessário ter o [Hugo Extended v0.147+](https://gohugo.io/installation/) instalado:

```bash
hugo server --source docs/site
```

Acesse em `http://localhost:1313`.

---

## Contribuindo

Veja [CONTRIBUTING.md](CONTRIBUTING.md) para as responsabilidades de cada perfil e as regras de colaboração com o projeto.

Contribuições são bem-vindas — especialmente melhorias nas instruções da IA, novas skills de revisão, e suporte a outros assistentes além do Claude Code.

---

## Licença

Este projeto é distribuído sob a licença [MIT](LICENSE).

Copyright © 2026 [Hibex Solutions](https://github.com/hibex-solutions)

---

<p align="center">
  <sub>Feito com ♥ por <a href="https://github.com/hibex-solutions">Hibex Solutions</a></sub>
</p>
