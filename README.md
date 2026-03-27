<p align="center">
  <img src=".github/assets/banner.svg" alt="AI Powered Coding Team" width="100%"/>
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/licença-MIT-4f6ef7?style=flat-square" alt="Licença MIT"/></a>
  <a href="https://www.anthropic.com/claude-code"><img src="https://img.shields.io/badge/Claude_Code-compatible-a855f7?style=flat-square&logo=anthropic" alt="Claude Code"/></a>
  <a href="CONTRIBUTING.md"><img src="https://img.shields.io/badge/contribuição-bem--vinda-10b981?style=flat-square" alt="Contribuições bem-vindas"/></a>
  <img src="https://img.shields.io/badge/Open_Source-♥-ff6b6b?style=flat-square" alt="Open Source"/>
</p>

<br/>

> **Um engenheiro sênior com o poder de uma equipe inteira de desenvolvimento.**
> Este projeto entrega um modelo de governança para desenvolvimento de software guiado por inteligência artificial — estruturando papéis, responsabilidades e fluxos de trabalho para que um único profissional sênior opere com a capacidade produtiva e qualidade de um time completo.

---

## O que é

**AI Powered Coding Team** é um modelo de projeto (_project template_) que define a estrutura, os papéis e as instruções necessárias para que um engenheiro de software sênior utilize IA — inicialmente Claude Code — como uma equipe completa de desenvolvimento.

O engenheiro deixa de atuar apenas como desenvolvedor e passa a assumir todos os papéis de um time:

| Papel | Responsabilidade |
|---|---|
| **Arquiteto de Soluções** | Define arquitetura, tecnologias e governança técnica |
| **Analista de Negócio** | Especifica regras de negócio e requisitos funcionais |
| **Designer** | Define diretrizes de marca, UI e UX |
| **Engenheiro de Software** | Implementa, testa e entrega o software |

A IA executa sob a supervisão e gestão ativa do engenheiro — que direciona, revisa e decide. A autonomia técnica permanece humana; o volume e a velocidade de execução são amplificados pela IA.

---

## Como funciona

```
Engenheiro Sênior
      │
      ├── atua como ──► Arquiteto  ──► docs/ARCHITECTURE.md
      │                                docs/SOLUTION.md
      │
      ├── atua como ──► Analista   ──► docs/BUSINESS.md
      │
      ├── atua como ──► Designer   ──► docs/GUIDELINE.md
      │
      └── delega para ─► IA (Claude Code)
                              │
                              ├── lê as especificações
                              ├── implementa o software
                              ├── escreve os testes
                              ├── revisa a arquitetura
                              └── valida regras de negócio
```

O modelo garante que **nenhum código seja escrito sem especificação**, que **nenhuma decisão técnica seja tomada sem documentação** e que **toda implementação seja validada contra regras de negócio e diretrizes de marca** — mantendo a qualidade de uma equipe madura mesmo com um único operador.

---

## Pré-requisitos

- [Claude Code](https://www.anthropic.com/claude-code) instalado e configurado
- [Git](https://git-scm.com) instalado localmente
- [GitVersion](https://gitversion.net) — necessário para geração de pacotes de liberação. Se não estiver disponível no sistema, o script `eng/release.sh` baixa e instala automaticamente o binário em `.GitVersion.Tool/` a partir da última release no GitHub.
- Conhecimento sólido de engenharia de software (o modelo foi projetado para profissionais sênior)

---

## Iniciando um novo projeto

### 1. Instale o template

```bash
curl -fsSL https://raw.githubusercontent.com/hibex-solutions/ai-powered-coding-team/main/eng/install.sh | bash -s -- meu-projeto
```

Para instalar uma versão específica, informe a tag como segundo argumento:

```bash
curl -fsSL https://raw.githubusercontent.com/hibex-solutions/ai-powered-coding-team/main/eng/install.sh | bash -s -- meu-projeto latest
```

O script baixa automaticamente a versão solicitada (ou a última disponível) e inicializa o diretório como repositório Git. Após a instalação, configure o Git local e faça o primeiro commit:

```bash
cd meu-projeto

# Configure o Git local (obrigatório — não use as configurações globais)
git config user.name "Seu Nome"
git config user.email "seu@email.com"

git add .
git commit -m "chore: inicializa projeto a partir do template"
```

### 2. Especifique antes de implementar

Antes de qualquer linha de código, o engenheiro documenta:

```
docs/ARCHITECTURE.md  ← decisões arquiteturais e regras invioláveis
docs/SOLUTION.md      ← componentes, tecnologias e desenho da solução
docs/BUSINESS.md      ← regras de negócio e requisitos funcionais
docs/GUIDELINE.md     ← padrões de marca, UI e UX
```

### 3. Delegue para a IA

Com as especificações em mãos, use o Claude Code para implementar:

```bash
claude
```

O CLAUDE.md do projeto já instrui a IA com as regras arquiteturais, a especificação negocial e as diretrizes de marca — sem necessidade de repetir contexto a cada sessão.

---

## Estrutura do projeto

```
.
├── .claude/                    # Configurações do Claude Code
│   ├── CLAUDE.md               # Instruções para a IA
│   └── commands/               # Comandos customizados
│       ├── review-architecture.md
│       ├── review-business.md
│       └── review-guideline.md
│
├── docs/                       # Toda a documentação
│   ├── ARCHITECTURE.md         # Especificação arquitetural
│   ├── SOLUTION.md             # Especificação da solução
│   ├── BUSINESS.md             # Especificação negocial
│   ├── GUIDELINE.md            # Guideline de marca e UX
│   └── architecture/
│       └── 12factor/           # Referência: The Twelve-Factor App
│
├── src/                        # Código-fonte
├── test/                       # Testes
├── eng/                        # Scripts de engenharia e CI/CD
├── samples/                    # Exemplos de uso
│
├── CLAUDE.md                   # Ponto de entrada das instruções para IA
├── CONTRIBUTING.md             # Guia de contribuição por perfil
└── LICENSE
```

---

## Comandos disponíveis

O projeto inclui comandos Claude prontos para revisão de conformidade. Execute dentro do Claude Code:

| Comando | O que faz |
|---|---|
| `/review-architecture` | Revisa o projeto em busca de violações arquiteturais |
| `/review-business` | Revisa violações das regras de negócio |
| `/review-guideline` | Revisa violações das diretrizes de marca e UX |

Esses comandos listam problemas **sem corrigir nada** — a decisão e a correção são sempre do engenheiro.

---

## Regras fundamentais do modelo

- **Especificação antes de implementação** — nenhuma funcionalidade sem regra de negócio documentada
- **Nenhuma tecnologia sem registro** — toda stack deve estar em `docs/SOLUTION.md`
- **Testes guiados por negócio** — cobertura 100% das regras especificadas
- **Secrets nunca no código** — sempre configuráveis por ambiente
- **The Twelve-Factor App** — software aderente aos doze fatores
- **Commits são humanos** — a IA propõe, o engenheiro commita

---

## Contribuindo

Veja [CONTRIBUTING.md](CONTRIBUTING.md) para entender as responsabilidades de cada perfil e as regras de colaboração com o projeto.

Contribuições são bem-vindas — especialmente melhorias nas instruções da IA, novos comandos de revisão, e suporte a outros assistentes além do Claude Code.

---

## Licença

Este projeto é distribuído sob a licença [MIT](LICENSE).

Copyright © 2026 [Hibex Solutions](https://github.com/hibex-solutions)

---

<p align="center">
  <sub>Feito com ♥ por <a href="https://github.com/hibex-solutions">Hibex Solutions</a></sub>
</p>
