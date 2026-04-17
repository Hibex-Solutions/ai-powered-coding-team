#Requires -Version 5.1
<#
.SYNOPSIS
    Instala o AI Powered Coding Team em um diretório novo.

.DESCRIPTION
    Baixa e extrai o template a partir de uma release do GitHub e inicializa
    um repositório Git no diretório de destino.

.PARAMETER TargetDir
    Caminho onde o template será instalado (obrigatório).

.PARAMETER Version
    Tag da release a instalar, ex: v1.2.0 (opcional; padrão: última disponível).

.PARAMETER Stack
    Stack tecnológica a inicializar, ex: dotnet (opcional).
    Quando omitido, apenas os arquivos agnósticos de stack são instalados.

.EXAMPLE
    .\eng\install.ps1 meu-projeto
    .\eng\install.ps1 meu-projeto -Version v1.2.0
    .\eng\install.ps1 meu-projeto -Stack dotnet
    .\eng\install.ps1 meu-projeto -Version v1.2.0 -Stack dotnet

.NOTES
    Pré-requisitos:
      - git        (https://git-scm.com)
      - PowerShell 5.1 ou superior (nativo no Windows 10+)
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$TargetDir,

    [Parameter(Mandatory = $false)]
    [string]$Version = "",

    [Parameter(Mandatory = $false)]
    [string]$Stack = ""
)

$ErrorActionPreference = 'Stop'

$Repo = "hibex-solutions/ai-powered-coding-team"

# ---------------------------------------------------------------------------
# Validação de pré-requisitos
# ---------------------------------------------------------------------------

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "ERRO: git não encontrado. Instale em https://git-scm.com"
    exit 1
}

# ---------------------------------------------------------------------------
# Resolve a versão a instalar (solicitada ou a última disponível)
# ---------------------------------------------------------------------------

if ($Version -ne "") {
    Write-Host "==> Buscando versão $Version em github.com/$Repo..."
    $ApiUrl = "https://api.github.com/repos/$Repo/releases/tags/$Version"
} else {
    Write-Host "==> Consultando última versão em github.com/$Repo..."
    $ApiUrl = "https://api.github.com/repos/$Repo/releases/latest"
}

try {
    $ReleaseJson = Invoke-RestMethod -Uri $ApiUrl -UseBasicParsing
} catch {
    Write-Error "ERRO: não foi possível acessar a API do GitHub: $_"
    exit 1
}

$ResolvedVersion = $ReleaseJson.tag_name

if (-not $ResolvedVersion) {
    if ($Version -ne "") {
        Write-Error "ERRO: versão '$Version' não encontrada em github.com/$Repo."
    } else {
        Write-Error "ERRO: não foi possível determinar a última versão."
    }
    exit 1
}

Write-Host "==> Versão encontrada: $ResolvedVersion"

$Asset = $ReleaseJson.assets | Where-Object { $_.name -like "*.zip" } | Select-Object -First 1

if (-not $Asset) {
    Write-Error "ERRO: nenhum asset .zip encontrado na release $ResolvedVersion."
    exit 1
}

$DownloadUrl = $Asset.browser_download_url
$AssetName   = $Asset.name

# ---------------------------------------------------------------------------
# Download para diretório temporário
# ---------------------------------------------------------------------------

$TmpDir = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), [System.IO.Path]::GetRandomFileName())
New-Item -ItemType Directory -Path $TmpDir | Out-Null

try {
    $TmpZip = Join-Path $TmpDir $AssetName

    Write-Host "==> Baixando $AssetName..."
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $TmpZip -UseBasicParsing

    # ---------------------------------------------------------------------------
    # Extração para o diretório de destino
    # ---------------------------------------------------------------------------

    if (-not (Test-Path $TargetDir)) {
        New-Item -ItemType Directory -Path $TargetDir | Out-Null
    }

    Write-Host "==> Extraindo para $TargetDir..."
    Expand-Archive -Path $TmpZip -DestinationPath $TargetDir -Force

    # ---------------------------------------------------------------------------
    # Resolução e validação da stack
    # ---------------------------------------------------------------------------

    $StacksSrc = Join-Path $TargetDir "stacks"

    # Deriva as stacks disponíveis a partir dos diretórios em stacks/
    $AvailableStacks = @()

    if (Test-Path $StacksSrc) {
        Get-ChildItem -Path $StacksSrc -Directory | ForEach-Object {
            $AvailableStacks += $_.Name   # ex: aspnet
        }
    }

    if ($Stack -ne "") {
        if ($AvailableStacks -notcontains $Stack) {
            $StackList = if ($AvailableStacks.Count -gt 0) { $AvailableStacks -join ", " } else { "(nenhuma)" }
            Write-Host "ERRO: stack '$Stack' não encontrada nesta versão do template." -ForegroundColor Red
            Write-Host "  Stacks disponíveis: $StackList" -ForegroundColor Red
            Remove-Item -Recurse -Force $TargetDir -ErrorAction SilentlyContinue
            exit 1
        }
    }

    # ---------------------------------------------------------------------------
    # Instalação da stack selecionada
    # ---------------------------------------------------------------------------

    $StackLabel = if ($Stack -ne "") { $Stack } else { "(nenhuma — agnóstico)" }
    Write-Host "==> Ajustando arquivos para stack: $StackLabel..."

    if (Test-Path $StacksSrc) {
        if ($Stack -ne "") {
            $SkillsDir = Join-Path $TargetDir ".claude\skills"
            $StackDir  = Join-Path $StacksSrc $Stack

            # Copia todas as skills da stack para .claude/skills/ (cada subdiretório de skills/ é uma skill)
            $SkillsSrc = Join-Path $StackDir "skills"
            if (Test-Path $SkillsSrc) {
                Get-ChildItem -Path $SkillsSrc -Directory | ForEach-Object {
                    Copy-Item -Path $_.FullName -Destination $SkillsDir -Recurse -Force
                }
            }

            # Copia documentação da stack para docs/ (SOLUTION obrigatório; BUSINESS e GUIDELINE opcionais)
            $DocsSrc = Join-Path $StackDir "docs"
            if (Test-Path $DocsSrc) {
                Copy-Item -Path (Join-Path $DocsSrc "SOLUTION.md") -Destination (Join-Path $TargetDir "docs\SOLUTION.md") -Force

                $BusinessMd = Join-Path $DocsSrc "BUSINESS.md"
                if (Test-Path $BusinessMd) {
                    Copy-Item -Path $BusinessMd -Destination (Join-Path $TargetDir "docs\BUSINESS.md") -Force
                }

                $GuidelineMd = Join-Path $DocsSrc "GUIDELINE.md"
                if (Test-Path $GuidelineMd) {
                    Copy-Item -Path $GuidelineMd -Destination (Join-Path $TargetDir "docs\GUIDELINE.md") -Force
                }
            }
        }

        # Remove diretório stacks/ do target (usado apenas para distribuição)
        Remove-Item -Recurse -Force $StacksSrc
    }

    # ---------------------------------------------------------------------------
    # Mescla eng/templates/CLAUDE.fragment.md no .claude/CLAUDE.md instalado
    # ---------------------------------------------------------------------------

    $ClaudeFragment = Join-Path $TargetDir "eng\templates\CLAUDE.fragment.md"
    if (Test-Path $ClaudeFragment) {
        $ClaudeMdPath = Join-Path $TargetDir ".claude\CLAUDE.md"
        Get-Content $ClaudeFragment | Add-Content $ClaudeMdPath
    }

    # ---------------------------------------------------------------------------
    # Inicialização do repositório Git
    # ---------------------------------------------------------------------------

    Write-Host "==> Inicializando repositório Git..."
    git -C $TargetDir init --initial-branch=main

    # ---------------------------------------------------------------------------
    # Instruções finais
    # ---------------------------------------------------------------------------

    $StackInfo = if ($Stack -ne "") { " | stack: $Stack" } else { "" }

    Write-Host ""
    Write-Host "================================================================"
    Write-Host " AI Powered Coding Team $ResolvedVersion instalado em:"
    Write-Host " $TargetDir$StackInfo"
    Write-Host "================================================================"
    Write-Host ""
    Write-Host "Próximos passos:"
    Write-Host ""
    Write-Host "  1. Configure seu nome e e-mail no Git local do projeto:"
    Write-Host ""
    Write-Host "       cd $TargetDir"
    Write-Host "       git config user.name  `"Seu Nome`""
    Write-Host "       git config user.email `"seu@email.com`""
    Write-Host ""
    Write-Host "  2. Faça o primeiro commit:"
    Write-Host ""
    Write-Host "       git add ."
    Write-Host "       git commit -m `"chore: inicializa projeto a partir do template $ResolvedVersion`""
    Write-Host ""
    Write-Host "  3. Especifique seu software nos documentos abaixo antes de"
    Write-Host "     qualquer linha de código:"
    Write-Host ""
    Write-Host "       docs/ARCHITECTURE.md  <- decisões arquiteturais e regras invioláveis"
    Write-Host "       docs/SOLUTION.md      <- componentes, tecnologias e desenho da solução"
    Write-Host "       docs/BUSINESS.md      <- regras de negócio e requisitos funcionais"
    Write-Host "       docs/GUIDELINE.md     <- padrões de marca, UI e UX"
    Write-Host ""
    Write-Host "  4. Inicie o Claude Code e comece a construir:"
    Write-Host ""
    Write-Host "       claude"
    Write-Host ""
} finally {
    Remove-Item -Recurse -Force $TmpDir -ErrorAction SilentlyContinue
}
