#Requires -Version 5.1
<#
.SYNOPSIS
    Gera um pacote de liberação de versão do software.

.DESCRIPTION
    Determina a versão via GitVersion, copia os arquivos do diretório templates/
    e empacota tudo em um arquivo ZIP em dist/.

.EXAMPLE
    .\eng\release.ps1

.NOTES
    Pré-requisitos:
      - git        (https://git-scm.com)
      - PowerShell 5.1 ou superior (nativo no Windows 10+)
      - GitVersion é baixado automaticamente do GitHub em .GitVersion.Tool\
        caso não esteja disponível no PATH do sistema.
#>
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$ScriptDir            = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ProjectRoot          = Split-Path -Parent $ScriptDir
$DistDir              = Join-Path $ProjectRoot "dist"
$PackageDir           = Join-Path $DistDir "package"
$SrcDir         = Join-Path $ProjectRoot "src"
$GitVersionLocalDir   = Join-Path $ProjectRoot ".GitVersion.Tool"
$GitVersionMinMajor   = 6
$GitVersionMinMinor   = 7

# ---------------------------------------------------------------------------
# Validação de pré-requisitos básicos
# ---------------------------------------------------------------------------

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "ERRO: git não encontrado. Instale em https://git-scm.com"
    exit 1
}

# ---------------------------------------------------------------------------
# Funções auxiliares do GitVersion
# ---------------------------------------------------------------------------

function Get-OsArch {
    $arch = switch ($env:PROCESSOR_ARCHITECTURE) {
        "AMD64" { "x64"   }
        "ARM64" { "arm64" }
        default {
            Write-Error "ERRO: arquitetura não suportada: $($env:PROCESSOR_ARCHITECTURE)"
            exit 1
        }
    }
    return "win-$arch"
}

function Install-GitVersionLocal {
    param([string]$OsArch)

    Write-Host "==> GitVersion não encontrado no sistema. Baixando do GitHub..."

    $ApiUrl     = "https://api.github.com/repos/GitTools/GitVersion/releases/latest"
    $ReleaseJson = Invoke-RestMethod -Uri $ApiUrl -UseBasicParsing

    $TagVersion = $ReleaseJson.tag_name
    $AssetName  = "gitversion-$OsArch-$TagVersion.zip"
    $Asset      = $ReleaseJson.assets | Where-Object { $_.name -eq $AssetName } | Select-Object -First 1

    if (-not $Asset) {
        Write-Error "ERRO: asset '$AssetName' não encontrado na release $TagVersion."
        exit 1
    }

    $DownloadUrl = $Asset.browser_download_url

    Write-Host "==> Versão: $TagVersion | Asset: $AssetName"
    Write-Host "==> URL: $DownloadUrl"

    if (-not (Test-Path $GitVersionLocalDir)) {
        New-Item -ItemType Directory -Path $GitVersionLocalDir | Out-Null
    }

    $TmpZip = [System.IO.Path]::GetTempFileName() + ".zip"
    try {
        Invoke-WebRequest -Uri $DownloadUrl -OutFile $TmpZip -UseBasicParsing
        Expand-Archive -Path $TmpZip -DestinationPath $GitVersionLocalDir -Force
    } finally {
        Remove-Item -Force $TmpZip -ErrorAction SilentlyContinue
    }

    Write-Host "==> GitVersion instalado em $GitVersionLocalDir\gitversion.exe"
}

function Test-GitVersionOk {
    param([string]$Bin)

    try {
        $output = & $Bin /version 2>$null
        $match  = [regex]::Match(($output -join "`n"), '\d+\.\d+\.\d+')
        if (-not $match.Success) { return $false }

        $parts = $match.Value.Split('.')
        $major = [int]$parts[0]
        $minor = [int]$parts[1]

        if ($major -gt $GitVersionMinMajor -or
           ($major -eq $GitVersionMinMajor -and $minor -ge $GitVersionMinMinor)) {
            return $true
        }

        Write-Host "==> GitVersion $($match.Value) é inferior ao mínimo exigido (>= $GitVersionMinMajor.$GitVersionMinMinor)." -ForegroundColor Yellow
        return $false
    } catch {
        return $false
    }
}

# ---------------------------------------------------------------------------
# Determina o binário do GitVersion (sistema ou instalação local)
# ---------------------------------------------------------------------------

$OsArch        = Get-OsArch
$GitVersionBin = $null

$SystemGv = Get-Command gitversion -ErrorAction SilentlyContinue
if ($SystemGv) {
    if (Test-GitVersionOk -Bin $SystemGv.Source) {
        $GitVersionBin = $SystemGv.Source
        Write-Host "==> Usando GitVersion do sistema: $GitVersionBin"
    } else {
        Write-Host "==> Versão do sistema não atende ao requisito — usando instalação local."
    }
}

if (-not $GitVersionBin) {
    $LocalBin = Join-Path $GitVersionLocalDir "gitversion.exe"
    if (-not (Test-Path $LocalBin) -or -not (Test-GitVersionOk -Bin $LocalBin)) {
        Install-GitVersionLocal -OsArch $OsArch
    } else {
        Write-Host "==> Usando GitVersion local em $LocalBin"
    }
    $GitVersionBin = $LocalBin
}

# ---------------------------------------------------------------------------
# Determina a versão via GitVersion
# ---------------------------------------------------------------------------

Write-Host "==> Determinando versão com GitVersion..."

Push-Location $ProjectRoot
try {
    $Version = & $GitVersionBin /showvariable SemVer
} finally {
    Pop-Location
}

Write-Host "==> Versão: $Version"

$PackageZip = Join-Path $DistDir "v$Version.zip"

# ---------------------------------------------------------------------------
# Prepara diretório de saída
# ---------------------------------------------------------------------------

Write-Host "==> Preparando diretório de pacote..."
if (Test-Path $PackageDir) {
    Remove-Item -Recurse -Force $PackageDir
}
New-Item -ItemType Directory -Path $PackageDir | Out-Null

# ---------------------------------------------------------------------------
# Copia arquivos de templates/ para o diretório de pacote
# ---------------------------------------------------------------------------

if (-not (Test-Path $SrcDir)) {
    Write-Error "ERRO: diretório $SrcDir não encontrado."
    exit 1
}

Write-Host "==> Copiando arquivos para $PackageDir..."

Get-ChildItem -Path $SrcDir -Recurse -File | ForEach-Object {
    $fullPath     = $_.FullName
    $relativePath = $fullPath.Substring($SrcDir.Length).TrimStart('\', '/')

    $destFile = Join-Path $PackageDir $relativePath
    $destDir  = Split-Path $destFile -Parent
    if (-not (Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir | Out-Null
    }
    Copy-Item -Path $fullPath -Destination $destFile -Force
}

# ---------------------------------------------------------------------------
# Gera arquivo ZIP
# ---------------------------------------------------------------------------

Write-Host "==> Gerando $PackageZip..."

if (Test-Path $PackageZip) {
    Remove-Item -Force $PackageZip
}

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::CreateFromDirectory(
    $PackageDir,
    $PackageZip,
    [System.IO.Compression.CompressionLevel]::Optimal,
    $false
)

Write-Host "==> Pacote gerado: $PackageZip"
