#Requires -Version 5.1
<#
.SYNOPSIS
    Atualiza os documentos da especificação "The Twelve-Factor App" (pt_br).

.DESCRIPTION
    Clona de forma esparsa o repositório oficial heroku/12factor e copia os
    arquivos Markdown da tradução pt_br para docs/architecture/12factor/.
    Registra metadados (commit SHA e data) em docs/architecture/12factor.txt.

.EXAMPLE
    .\eng\update-12factor.ps1

.NOTES
    Pré-requisitos:
      - git        (https://git-scm.com)
      - PowerShell 5.1 ou superior (nativo no Windows 10+)
#>
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$RepoUrl     = "https://github.com/heroku/12factor.git"
$ContentPath = "content/pt_br"
$ScriptDir   = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ProjectRoot = Split-Path -Parent $ScriptDir
$TargetDir   = Join-Path $ProjectRoot "docs\architecture\12factor"
$MetaFile    = Join-Path $ProjectRoot "docs\architecture\12factor.txt"

# ---------------------------------------------------------------------------
# Validação de pré-requisitos
# ---------------------------------------------------------------------------

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "ERRO: git não encontrado. Instale em https://git-scm.com"
    exit 1
}

# ---------------------------------------------------------------------------
# Clone esparso em diretório temporário
# ---------------------------------------------------------------------------

Write-Host "==> Atualizando especificação 12factor (pt_br)..."

$TempDir = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), [System.IO.Path]::GetRandomFileName())
New-Item -ItemType Directory -Path $TempDir | Out-Null

try {
    Write-Host "==> Clonando repositório (sparse, depth=1)..."
    git clone `
        --depth=1 `
        --filter=blob:none `
        --sparse `
        --no-tags `
        --quiet `
        $RepoUrl `
        $TempDir

    git -C $TempDir sparse-checkout set $ContentPath

    $CommitSha = git -C $TempDir rev-parse HEAD
    $UpdatedAt = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

    Write-Host "==> Commit: $CommitSha"

    # ---------------------------------------------------------------------------
    # Copia arquivos para o diretório de destino
    # ---------------------------------------------------------------------------

    Write-Host "==> Copiando arquivos para $TargetDir..."

    if (-not (Test-Path $TargetDir)) {
        New-Item -ItemType Directory -Path $TargetDir | Out-Null
    }

    # Remove arquivos .md existentes
    Get-ChildItem -Path $TargetDir -Filter "*.md" -File | Remove-Item -Force

    $SourceDir = Join-Path $TempDir ($ContentPath.Replace('/', '\'))
    Copy-Item -Path (Join-Path $SourceDir "*.md") -Destination $TargetDir -Force

    # ---------------------------------------------------------------------------
    # Grava metadados
    # ---------------------------------------------------------------------------

    Write-Host "==> Gravando metadados em $MetaFile..."

    $repoBaseUrl = $RepoUrl -replace '\.git$', ''

    @"
Última atualização: $UpdatedAt
Repositório: $repoBaseUrl
Commit: $CommitSha
Diretório origem: $ContentPath
"@ | Set-Content -Path $MetaFile -Encoding UTF8

    $count = (Get-ChildItem -Path $TargetDir -Filter "*.md" -File).Count
    Write-Host "==> Concluído. $count arquivos atualizados."

} finally {
    Remove-Item -Recurse -Force $TempDir -ErrorAction SilentlyContinue
}
