#!/usr/bin/env bash
set -euo pipefail

# Atualiza os dados do site estático para GitHub Pages.
#
# Uso: bash eng/update-site-data.sh <base-url>
#
# Argumentos:
#   <base-url>  URL base do GitHub Pages (ex: https://hibex-solutions.github.io/ai-powered-coding-team)
#
# O que faz:
#   1. Copia eng/install.sh para docs/site/install.sh
#   2. Substitui o placeholder @@INSTALL_BASE_URL@@ no docs/site/index.html pela URL informada
#
# Pré-condição: docs/site/index.html deve existir com o placeholder @@INSTALL_BASE_URL@@

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
SITE_DIR="${PROJECT_ROOT}/docs/site"

if [[ $# -lt 1 || -z "${1:-}" ]]; then
    echo "Erro: URL base não informada." >&2
    echo "Uso: $0 <base-url>" >&2
    echo "  Exemplo: $0 https://hibex-solutions.github.io/ai-powered-coding-team" >&2
    exit 1
fi

BASE_URL="${1%/}"

if [[ ! -f "${SITE_DIR}/index.html" ]]; then
    echo "Erro: ${SITE_DIR}/index.html não encontrado." >&2
    echo "Execute primeiro a skill /generate-github-site para gerar o site." >&2
    exit 1
fi

echo "==> Copiando install.sh para o site..."
cp "${PROJECT_ROOT}/eng/install.sh" "${SITE_DIR}/install.sh"

echo "==> Atualizando URL de instalação (${BASE_URL})..."
sed -i "s|@@INSTALL_BASE_URL@@|${BASE_URL}|g" "${SITE_DIR}/index.html"

echo "==> Site atualizado em ${SITE_DIR}/"
echo "    URL base: ${BASE_URL}"
