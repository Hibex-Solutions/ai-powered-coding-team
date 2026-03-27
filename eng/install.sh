#!/usr/bin/env bash
set -euo pipefail

# Instala o AI Powered Coding Team em um diretório novo.
#
# Uso: ./eng/install.sh <diretório-destino> [versão]
#
# Ou diretamente via curl:
#   curl -fsSL https://raw.githubusercontent.com/hibex-solutions/ai-powered-coding-team/main/eng/install.sh | bash -s -- <diretório-destino> [versão]
#
# Argumentos:
#   <diretório-destino>  Caminho onde o template será instalado (obrigatório)
#   [versão]             Tag da release a instalar, ex: v1.2.0 (opcional; padrão: última)
#
# Pré-requisitos:
#   - git   (https://git-scm.com)
#   - curl  (https://curl.se)
#   - unzip

REPO="hibex-solutions/ai-powered-coding-team"

# ---------------------------------------------------------------------------
# Parâmetros: diretório de destino (obrigatório) e versão (opcional)
# ---------------------------------------------------------------------------

if [[ $# -lt 1 || -z "${1:-}" ]]; then
    echo "Uso: $0 <diretório-destino> [versão]" >&2
    echo "" >&2
    echo "  Exemplos:" >&2
    echo "    $0 ~/meu-projeto           # instala a última versão" >&2
    echo "    $0 ~/meu-projeto v1.2.0    # instala uma versão específica" >&2
    exit 1
fi

TARGET_DIR="${1}"
REQUESTED_VERSION="${2:-}"

# ---------------------------------------------------------------------------
# Validação de pré-requisitos
# ---------------------------------------------------------------------------

if ! command -v git &>/dev/null; then
    echo "ERRO: git não encontrado. Instale em https://git-scm.com" >&2
    exit 1
fi

if ! command -v curl &>/dev/null; then
    echo "ERRO: curl não encontrado. Instale em https://curl.se" >&2
    exit 1
fi

if ! command -v unzip &>/dev/null; then
    echo "ERRO: unzip não encontrado. Instale via gerenciador de pacotes do sistema." >&2
    exit 1
fi

# ---------------------------------------------------------------------------
# Resolve a versão a instalar (solicitada ou a última disponível)
# ---------------------------------------------------------------------------

if [[ -n "${REQUESTED_VERSION}" ]]; then
    echo "==> Buscando versão ${REQUESTED_VERSION} em github.com/${REPO}..."
    API_URL="https://api.github.com/repos/${REPO}/releases/tags/${REQUESTED_VERSION}"
else
    echo "==> Consultando última versão em github.com/${REPO}..."
    API_URL="https://api.github.com/repos/${REPO}/releases/latest"
fi

RELEASE_JSON="$(curl -fsSL "${API_URL}")"

VERSION="$(echo "${RELEASE_JSON}" | grep '"tag_name"' | head -1 | sed 's/.*"tag_name": *"\([^"]*\)".*/\1/')"

if [[ -z "${VERSION}" ]]; then
    if [[ -n "${REQUESTED_VERSION}" ]]; then
        echo "ERRO: versão '${REQUESTED_VERSION}' não encontrada em github.com/${REPO}." >&2
    else
        echo "ERRO: não foi possível determinar a última versão." >&2
    fi
    exit 1
fi

echo "==> Versão encontrada: ${VERSION}"

ASSET_NAME="${VERSION}.zip"
DOWNLOAD_URL="$(echo "${RELEASE_JSON}" | grep '"browser_download_url"' | grep "${ASSET_NAME}" | head -1 | sed 's/.*"browser_download_url": *"\([^"]*\)".*/\1/')"

if [[ -z "${DOWNLOAD_URL}" ]]; then
    echo "ERRO: asset '${ASSET_NAME}' não encontrado na release ${VERSION}." >&2
    exit 1
fi

# ---------------------------------------------------------------------------
# Download para diretório temporário
# ---------------------------------------------------------------------------

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

TMP_ZIP="${TMP_DIR}/${ASSET_NAME}"

echo "==> Baixando ${ASSET_NAME}..."
curl -fsSL -o "${TMP_ZIP}" "${DOWNLOAD_URL}"

# ---------------------------------------------------------------------------
# Extração para o diretório de destino
# ---------------------------------------------------------------------------

mkdir -p "${TARGET_DIR}"

echo "==> Extraindo para ${TARGET_DIR}..."
unzip -q "${TMP_ZIP}" -d "${TARGET_DIR}"

# ---------------------------------------------------------------------------
# Inicialização do repositório Git
# ---------------------------------------------------------------------------

echo "==> Inicializando repositório Git..."
git -C "${TARGET_DIR}" init --initial-branch=main

# ---------------------------------------------------------------------------
# Instruções finais
# ---------------------------------------------------------------------------

echo ""
echo "================================================================"
echo " AI Powered Coding Team ${VERSION} instalado em:"
echo " ${TARGET_DIR}"
echo "================================================================"
echo ""
echo "Próximos passos:"
echo ""
echo "  1. Configure seu nome e e-mail no Git local do projeto:"
echo ""
echo "       cd ${TARGET_DIR}"
echo "       git config user.name  \"Seu Nome\""
echo "       git config user.email \"seu@email.com\""
echo ""
echo "  2. Faça o primeiro commit:"
echo ""
echo "       git add ."
echo "       git commit -m \"chore: inicializa projeto a partir do template ${VERSION}\""
echo ""
echo "  3. Especifique seu software nos documentos abaixo antes de"
echo "     qualquer linha de código:"
echo ""
echo "       docs/ARCHITECTURE.md  ← decisões arquiteturais e regras invioláveis"
echo "       docs/SOLUTION.md      ← componentes, tecnologias e desenho da solução"
echo "       docs/BUSINESS.md      ← regras de negócio e requisitos funcionais"
echo "       docs/GUIDELINE.md     ← padrões de marca, UI e UX"
echo ""
echo "  4. Inicie o Claude Code e comece a construir:"
echo ""
echo "       claude"
echo ""
