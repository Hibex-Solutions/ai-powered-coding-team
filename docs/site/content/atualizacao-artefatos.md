---
title: "Atualização"
weight: 4
---

{{% card title="Atualizando skills e stacks" %}}

Após criar um projeto com o template, as skills e stacks são copiadas para o repositório do seu projeto. Elas **não** são atualizadas automaticamente quando o template evolui. Para obter as últimas versões:

### Atualizar skills genéricas

Baixe as skills atualizadas diretamente do repositório do template e substitua o conteúdo em `.claude/skills/`:

```bash
# Baixe o pacote da versão desejada
curl -fsSL https://github.com/hibex-solutions/ai-powered-coding-team/releases/latest/download/template.zip -o template.zip
unzip template.zip -d /tmp/template

# Substitua as skills genéricas
cp -r /tmp/template/.claude/skills/c4model-architectural-designer .claude/skills/
cp -r /tmp/template/.claude/skills/architect-reviewer .claude/skills/
cp -r /tmp/template/.claude/skills/business-reviewer .claude/skills/
cp -r /tmp/template/.claude/skills/guideline-reviewer .claude/skills/
```

> **Atenção:** revise as mudanças antes de commitar. Skills são instruções para a IA — entenda o que foi alterado antes de aplicar no seu projeto.

### Atualizar skills de stack

O mesmo processo se aplica às skills de stack:

```bash
cp -r /tmp/template/stacks/aspnet/skills/aspnet-engineer .claude/skills/
```

### Verificar a versão atual

Para saber qual versão do template seu projeto usa, consulte o histórico de commits ou o arquivo de referência criado durante a instalação.

{{% /card %}}

{{% card title="Atualizando documentação de arquitetura" %}}

O diretório `docs/architecture/12factor/` contém os documentos do Twelve-Factor App (tradução pt-BR). Para atualizar a partir do repositório oficial:

```bash
# Linux/macOS
bash eng/update-12factor.sh

# Windows (PowerShell)
.\eng\update-12factor.ps1
```

Os scripts fazem clone raso do repositório `heroku/12factor` e copiam os arquivos da tradução `pt_br` para `docs/architecture/12factor/`, registrando o commit de origem em `docs/architecture/12factor.txt`.

Esses documentos são referências estáticas que raramente mudam. Atualize apenas se houver revisões significativas no conteúdo.

{{% /card %}}
