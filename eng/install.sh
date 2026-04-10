#!/usr/bin/env bash
set -euo pipefail

# Instala o AI Powered Coding Team em um diretório novo.
#
# Uso: ./eng/install.sh <diretório-destino> [--version <tag>] [--stack <nome>]
#
# Ou diretamente via curl:
#   curl -fsSL https://hibex-solutions.github.io/ai-powered-coding-team/install.sh | bash -s -- <diretório-destino> [--version <tag>] [--stack <nome>]
#
# Argumentos:
#   <diretório-destino>  Caminho onde o template será instalado (obrigatório)
#   [--version <tag>]    Tag da release a instalar, ex: v1.2.0 (opcional; padrão: última)
#   [--stack <nome>]     Stack tecnológica a inicializar, ex: dotnet (opcional)
#                        Quando omitido, apenas os arquivos agnósticos de stack são instalados.
#
# Pré-requisitos:
#   - git   (https://git-scm.com)
#   - curl  (https://curl.se)
#   - unzip

REPO="hibex-solutions/ai-powered-coding-team"

# ---------------------------------------------------------------------------
# Parâmetros: diretório de destino (obrigatório), versão e stack (opcionais)
# ---------------------------------------------------------------------------

if [[ $# -lt 1 || -z "${1:-}" ]]; then
    echo "Uso: $0 <diretório-destino> [--version <tag>] [--stack <nome>]" >&2
    echo "" >&2
    echo "  Exemplos:" >&2
    echo "    $0 ~/meu-projeto                                    # instala a última versão (sem stack)" >&2
    echo "    $0 ~/meu-projeto --version v1.2.0                   # versão específica (sem stack)" >&2
    echo "    $0 ~/meu-projeto --stack dotnet                     # última versão com stack .NET" >&2
    echo "    $0 ~/meu-projeto --version v1.2.0 --stack dotnet    # versão específica com stack .NET" >&2
    exit 1
fi

TARGET_DIR="${1}"
REQUESTED_VERSION=""
REQUESTED_STACK=""

# Parseia os argumentos restantes
shift
while [[ $# -gt 0 ]]; do
    case "${1}" in
        --version)
            if [[ $# -lt 2 || -z "${2:-}" ]]; then
                echo "ERRO: --version requer uma tag de versão." >&2
                exit 1
            fi
            REQUESTED_VERSION="${2}"
            shift 2
            ;;
        --stack)
            if [[ $# -lt 2 || -z "${2:-}" ]]; then
                echo "ERRO: --stack requer um nome de stack." >&2
                exit 1
            fi
            REQUESTED_STACK="${2}"
            shift 2
            ;;
        *)
            echo "ERRO: argumento ou opção desconhecida '${1}'." >&2
            exit 1
            ;;
    esac
done

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

DOWNLOAD_URL="$(echo "${RELEASE_JSON}" | grep '"browser_download_url"' | grep '\.zip"' | head -1 | sed 's/.*"browser_download_url": *"\([^"]*\)".*/\1/')"
ASSET_NAME="$(basename "${DOWNLOAD_URL}")"

if [[ -z "${DOWNLOAD_URL}" ]]; then
    echo "ERRO: nenhum asset .zip encontrado na release ${VERSION}." >&2
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
# Resolução e validação da stack
# ---------------------------------------------------------------------------

# Deriva as stacks disponíveis a partir dos diretórios em stacks/
AVAILABLE_STACKS=()
STACKS_SRC="${TARGET_DIR}/stacks"

if [[ -d "${STACKS_SRC}" ]]; then
    for stack_dir in "${STACKS_SRC}"/*/; do
        if [[ -d "${stack_dir}" ]]; then
            stack_name="$(basename "${stack_dir}")"   # ex: aspnet
            AVAILABLE_STACKS+=("${stack_name}")
        fi
    done
fi

if [[ -n "${REQUESTED_STACK}" ]]; then
    # Valida se a stack solicitada existe no pacote
    STACK_VALID=false
    if [[ ${#AVAILABLE_STACKS[@]} -gt 0 ]]; then
        for s in "${AVAILABLE_STACKS[@]}"; do
            if [[ "${s}" == "${REQUESTED_STACK}" ]]; then
                STACK_VALID=true
                break
            fi
        done
    fi

    if [[ "${STACK_VALID}" == false ]]; then
        echo "ERRO: stack '${REQUESTED_STACK}' não encontrada nesta versão do template." >&2
        if [[ ${#AVAILABLE_STACKS[@]} -gt 0 ]]; then
            echo "  Stacks disponíveis: ${AVAILABLE_STACKS[*]}" >&2
        else
            echo "  Nenhuma stack disponível nesta versão." >&2
        fi
        rm -r "${TARGET_DIR}"
        exit 1
    fi
fi

# ---------------------------------------------------------------------------
# Instalação da stack selecionada
# ---------------------------------------------------------------------------

echo "==> Ajustando arquivos para stack: ${REQUESTED_STACK:-"(nenhuma — agnóstico)"}..."

if [[ -d "${STACKS_SRC}" ]]; then
    if [[ -n "${REQUESTED_STACK}" ]]; then
        SKILLS_DST="${TARGET_DIR}/.claude/skills"
        STACK_DIR="${STACKS_SRC}/${REQUESTED_STACK}"

        # Copia todas as skills da stack para .claude/skills/ (cada subdiretório de skills/ é uma skill)
        SKILLS_SRC="${STACK_DIR}/skills"
        if [[ -d "${SKILLS_SRC}" ]]; then
            for skill_dir in "${SKILLS_SRC}"/*/; do
                [[ -d "${skill_dir}" ]] && cp -r "${skill_dir}" "${SKILLS_DST}/"
            done
        fi

        # Copia documentação da stack para docs/ (SOLUTION obrigatório; BUSINESS e GUIDELINE opcionais)
        DOCS_SRC="${STACK_DIR}/docs"
        if [[ -d "${DOCS_SRC}" ]]; then
            cp "${DOCS_SRC}/SOLUTION.md" "${TARGET_DIR}/docs/SOLUTION.md"
            [[ -f "${DOCS_SRC}/BUSINESS.md" ]] && \
                cp "${DOCS_SRC}/BUSINESS.md" "${TARGET_DIR}/docs/BUSINESS.md"
            [[ -f "${DOCS_SRC}/GUIDELINE.md" ]] && \
                cp "${DOCS_SRC}/GUIDELINE.md" "${TARGET_DIR}/docs/GUIDELINE.md"
        fi
    fi

    # Remove diretório stacks/ do target (usado apenas para distribuição)
    rm -r "${STACKS_SRC}"
fi

# ---------------------------------------------------------------------------
# Mescla docs/CLAUDE.md no .claude/CLAUDE.md instalado
# ---------------------------------------------------------------------------

DOCS_CLAUDE="${TARGET_DIR}/docs/CLAUDE.md"
if [[ -f "${DOCS_CLAUDE}" ]]; then
    cat "${DOCS_CLAUDE}" >> "${TARGET_DIR}/.claude/CLAUDE.md"
    rm "${DOCS_CLAUDE}"
fi

# ---------------------------------------------------------------------------
# Inicialização do repositório Git
# ---------------------------------------------------------------------------

echo "==> Inicializando repositório Git..."
git -C "${TARGET_DIR}" init --initial-branch=main

# ---------------------------------------------------------------------------
# Instruções finais
# ---------------------------------------------------------------------------

STACK_INFO=""
if [[ -n "${REQUESTED_STACK}" ]]; then
    STACK_INFO=" | stack: ${REQUESTED_STACK}"
fi

echo ""
echo "================================================================"
echo " AI Powered Coding Team ${VERSION} instalado em:"
echo " ${TARGET_DIR}${STACK_INFO}"
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
