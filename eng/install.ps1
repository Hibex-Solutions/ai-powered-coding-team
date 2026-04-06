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
    .\eng\install.ps1 meu-projeto v1.2.0
    .\eng\install.ps1 meu-projeto -Stack dotnet
    .\eng\install.ps1 meu-projeto v1.2.0 -Stack dotnet

.NOTES
    Pré-requisitos:
      - git        (https://git-scm.com)
      - PowerShell 5.1 ou superior (nativo no Windows 10+)
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$TargetDir,

    [Parameter(Mandatory = $false, Position = 1)]
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

    $SkillsDir = Join-Path $TargetDir ".claude\skills"

    # Deriva as stacks disponíveis a partir dos diretórios stack-* no pacote extraído
    $AvailableStacks = @()

    if (Test-Path $SkillsDir) {
        Get-ChildItem -Path $SkillsDir -Directory -Filter "stack-*" | ForEach-Object {
            $SkillName  = $_.Name                          # ex: stack-dotnet-engineer
            $StackPart  = $SkillName -replace '^stack-','' # ex: dotnet-engineer
            $StackName  = ($StackPart -split '-')[0]       # ex: dotnet
            if ($AvailableStacks -notcontains $StackName) {
                $AvailableStacks += $StackName
            }
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
    # Filtragem de arquivos por stack
    # ---------------------------------------------------------------------------

    $StackLabel = if ($Stack -ne "") { $Stack } else { "(nenhuma — agnóstico)" }
    Write-Host "==> Ajustando arquivos para stack: $StackLabel..."

    if (Test-Path $SkillsDir) {
        Get-ChildItem -Path $SkillsDir -Directory -Filter "stack-*" | ForEach-Object {
            $SkillDir   = $_.FullName
            $SkillName  = $_.Name                          # ex: stack-dotnet-engineer
            $StackPart  = $SkillName -replace '^stack-','' # ex: dotnet-engineer
            $StackName  = ($StackPart -split '-')[0]       # ex: dotnet

            if ($Stack -eq "" -or $StackName -ne $Stack) {
                # Sem stack ou stack diferente: remove o diretório
                Remove-Item -Recurse -Force $SkillDir
            } else {
                # Stack correspondente: renomeia removendo o prefixo "stack-"
                # stack-dotnet-engineer → dotnet-engineer
                $NewPath = Join-Path $SkillsDir $StackPart
                Rename-Item -Path $SkillDir -NewName $StackPart
            }
        }
    }

    # Mescla SOLUTION-{stack}.md em SOLUTION.md (se stack foi selecionada)
    $SolutionBase = Join-Path $TargetDir "docs\SOLUTION.md"
    if ($Stack -ne "") {
        $SolutionStack = Join-Path $TargetDir "docs\SOLUTION-$Stack.md"
        if (Test-Path $SolutionStack) {
            Add-Content -Path $SolutionBase -Value ""
            Get-Content $SolutionStack | Add-Content -Path $SolutionBase
        }
    }

    # Remove todos os arquivos SOLUTION-*.md
    Get-ChildItem -Path (Join-Path $TargetDir "docs") -Filter "SOLUTION-*.md" -File |
        Remove-Item -Force

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
