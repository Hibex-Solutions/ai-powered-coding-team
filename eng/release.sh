#!/usr/bin/env bash
set -euo pipefail

# Gera um pacote de liberação de versão do software.
#
# Uso: ./eng/release.sh
# Executar a partir da raiz do projeto ou de qualquer diretório.
#
# Pré-requisitos:
#   - git   (https://git-scm.com)
#   - curl  (https://curl.se)
#   - GitVersion é baixado automaticamente do GitHub em .GitVersion.Tool/
#     caso não esteja disponível no PATH do sistema.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
DIST_DIR="${PROJECT_ROOT}/dist"
PACKAGE_DIR="${DIST_DIR}/package"
RELEASEIGNORE="${PROJECT_ROOT}/.releaseignore"
GITVERSION_LOCAL_DIR="${PROJECT_ROOT}/.GitVersion.Tool"
GITVERSION_MIN_MAJOR=6
GITVERSION_MIN_MINOR=7

# ---------------------------------------------------------------------------
# Validação de pré-requisitos básicos
# ---------------------------------------------------------------------------

if ! command -v git &>/dev/null; then
    echo "ERRO: git não encontrado. Instale em https://git-scm.com" >&2
    exit 1
fi

if ! command -v curl &>/dev/null; then
    echo "ERRO: curl não encontrado. Instale em https://curl.se" >&2
    exit 1
fi

# ---------------------------------------------------------------------------
# Resolve o binário do GitVersion (sistema ou instalação local)
# ---------------------------------------------------------------------------

_gitversion_resolve_os_arch() {
    local os arch

    case "$(uname -s)" in
        Linux*)  os="linux" ;;
        Darwin*) os="osx"   ;;
        *)
            echo "ERRO: sistema operacional não suportado: $(uname -s)" >&2
            exit 1
            ;;
    esac

    case "$(uname -m)" in
        x86_64)          arch="x64"   ;;
        aarch64|arm64)   arch="arm64" ;;
        *)
            echo "ERRO: arquitetura não suportada: $(uname -m)" >&2
            exit 1
            ;;
    esac

    echo "${os}-${arch}"
}

_gitversion_install_local() {
    local os_arch="$1"

    echo "==> GitVersion não encontrado no sistema. Baixando do GitHub..."

    local api_url="https://api.github.com/repos/GitTools/GitVersion/releases/latest"
    local release_json
    release_json="$(curl -fsSL "${api_url}")"

    local version
    version="$(echo "${release_json}" | grep '"tag_name"' | head -1 | sed 's/.*"tag_name": *"\([^"]*\)".*/\1/')"

    local asset_name="gitversion-${os_arch}-${version}.tar.gz"
    local download_url
    download_url="$(echo "${release_json}" | grep "\"browser_download_url\"" | grep "${asset_name}" | head -1 | sed 's/.*"browser_download_url": *"\([^"]*\)".*/\1/')"

    if [[ -z "${download_url}" ]]; then
        echo "ERRO: asset '${asset_name}' não encontrado na release ${version}." >&2
        exit 1
    fi

    echo "==> Versão: ${version} | Asset: ${asset_name}"
    echo "==> URL: ${download_url}"

    mkdir -p "${GITVERSION_LOCAL_DIR}"
    local tmp_archive
    tmp_archive="$(mktemp --suffix=".tar.gz")"
    trap 'rm -f "${tmp_archive}"' RETURN

    curl -fsSL -o "${tmp_archive}" "${download_url}"
    tar -xzf "${tmp_archive}" -C "${GITVERSION_LOCAL_DIR}"
    chmod +x "${GITVERSION_LOCAL_DIR}/gitversion"

    echo "==> GitVersion instalado em ${GITVERSION_LOCAL_DIR}/gitversion"
}

# Verifica se uma versão de GitVersion atende ao requisito mínimo
_gitversion_version_ok() {
    local bin="$1"
    local raw
    raw="$("${bin}" /version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1 || true)"
    [[ -z "${raw}" ]] && return 1

    local major minor
    major="$(echo "${raw}" | cut -d. -f1)"
    minor="$(echo "${raw}" | cut -d. -f2)"

    if (( major > GITVERSION_MIN_MAJOR )) || \
       (( major == GITVERSION_MIN_MAJOR && minor >= GITVERSION_MIN_MINOR )); then
        return 0
    fi

    echo "==> GitVersion ${raw} é inferior ao mínimo exigido (>= ${GITVERSION_MIN_MAJOR}.${GITVERSION_MIN_MINOR})." >&2
    return 1
}

# Determina o binário a usar
OS_ARCH="$(_gitversion_resolve_os_arch)"
GITVERSION_BIN=""

if command -v gitversion &>/dev/null; then
    if _gitversion_version_ok "$(command -v gitversion)"; then
        GITVERSION_BIN="$(command -v gitversion)"
        echo "==> Usando GitVersion do sistema: ${GITVERSION_BIN}"
    else
        echo "==> Versão do sistema não atende ao requisito — usando instalação local."
    fi
fi

if [[ -z "${GITVERSION_BIN}" ]]; then
    if [[ ! -x "${GITVERSION_LOCAL_DIR}/gitversion" ]] || \
       ! _gitversion_version_ok "${GITVERSION_LOCAL_DIR}/gitversion"; then
        _gitversion_install_local "${OS_ARCH}"
    else
        echo "==> Usando GitVersion local em ${GITVERSION_LOCAL_DIR}/gitversion"
    fi
    GITVERSION_BIN="${GITVERSION_LOCAL_DIR}/gitversion"
fi

# ---------------------------------------------------------------------------
# Determina a versão via GitVersion
# ---------------------------------------------------------------------------

echo "==> Determinando versão com GitVersion..."

cd "${PROJECT_ROOT}"
VERSION="$("${GITVERSION_BIN}" /showvariable SemVer)"
echo "==> Versão: ${VERSION}"

PACKAGE_ZIP="${DIST_DIR}/v${VERSION}.zip"

# ---------------------------------------------------------------------------
# Prepara diretório de saída
# ---------------------------------------------------------------------------

echo "==> Preparando diretório de pacote..."
rm -rf "${PACKAGE_DIR}"
mkdir -p "${PACKAGE_DIR}"

# ---------------------------------------------------------------------------
# Lê padrões do .releaseignore
# ---------------------------------------------------------------------------

IGNORE_PATTERNS=()

if [[ -f "${RELEASEIGNORE}" ]]; then
    while IFS= read -r line || [[ -n "${line}" ]]; do
        # Ignora linhas vazias e comentários
        [[ -z "${line}" || "${line}" =~ ^[[:space:]]*# ]] && continue
        IGNORE_PATTERNS+=("${line}")
    done < "${RELEASEIGNORE}"
fi

# ---------------------------------------------------------------------------
# Monta argumentos de exclusão para rsync
# ---------------------------------------------------------------------------

RSYNC_EXCLUDES=()
for pattern in "${IGNORE_PATTERNS[@]}"; do
    RSYNC_EXCLUDES+=("--exclude=${pattern}")
done

# Sempre exclui o próprio diretório dist, cache local e artefatos de controle
RSYNC_EXCLUDES+=(
    "--exclude=dist/"
    "--exclude=.GitVersion.Tool/"
    "--exclude=.git/"
    "--exclude=.gitignore"
    "--exclude=.releaseignore"
)

# ---------------------------------------------------------------------------
# Copia arquivos para o diretório de pacote
# ---------------------------------------------------------------------------

echo "==> Copiando arquivos para ${PACKAGE_DIR}..."
rsync -a --no-links \
    "${RSYNC_EXCLUDES[@]}" \
    "${PROJECT_ROOT}/" \
    "${PACKAGE_DIR}/"

# ---------------------------------------------------------------------------
# Gera arquivo ZIP
# ---------------------------------------------------------------------------

echo "==> Gerando ${PACKAGE_ZIP}..."
rm -f "${PACKAGE_ZIP}"
(cd "${PACKAGE_DIR}" && zip -r "${PACKAGE_ZIP}" . -x "*.DS_Store" "*/Thumbs.db")

echo "==> Pacote gerado: ${PACKAGE_ZIP}"
