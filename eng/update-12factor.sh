#!/usr/bin/env bash
set -euo pipefail

# Atualiza os documentos da especificação "The Twelve-Factor App" (pt_br)
# a partir do repositório oficial: https://github.com/heroku/12factor
#
# Uso: ./eng/update-12factor.sh
# Executar a partir da raiz do projeto ou de qualquer diretório.

REPO_URL="https://github.com/heroku/12factor.git"
CONTENT_PATH="content/pt_br"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TARGET_DIR="${PROJECT_ROOT}/docs/architecture/12factor"
METADATA_FILE="${PROJECT_ROOT}/docs/architecture/12factor.txt"

echo "==> Atualizando especificação 12factor (pt_br)..."

TEMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TEMP_DIR}"' EXIT

echo "==> Clonando repositório (sparse, depth=1)..."
git clone \
    --depth=1 \
    --filter=blob:none \
    --sparse \
    --no-tags \
    --quiet \
    "${REPO_URL}" \
    "${TEMP_DIR}"

git -C "${TEMP_DIR}" sparse-checkout set "${CONTENT_PATH}"

COMMIT_SHA="$(git -C "${TEMP_DIR}" rev-parse HEAD)"
UPDATED_AT="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

echo "==> Commit: ${COMMIT_SHA}"

echo "==> Copiando arquivos para ${TARGET_DIR}..."
mkdir -p "${TARGET_DIR}"
find "${TARGET_DIR}" -maxdepth 1 -name "*.md" -delete

cp "${TEMP_DIR}/${CONTENT_PATH}/"*.md "${TARGET_DIR}/"

echo "==> Gravando metadados em ${METADATA_FILE}..."
cat > "${METADATA_FILE}" <<EOF
Última atualização: ${UPDATED_AT}
Repositório: ${REPO_URL%.git}
Commit: ${COMMIT_SHA}
Diretório origem: ${CONTENT_PATH}
EOF

echo "==> Concluído. $(find "${TARGET_DIR}" -maxdepth 1 -name "*.md" | wc -l) arquivos atualizados."
