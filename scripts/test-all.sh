#!/bin/bash
# Runs terraform validate + tflint across every Terraform working directory
# in this repo. Modules are lint-only, since terraform validate requires
# a provider-configured root module and modules don't have one standalone.

set -e

ROOT_MODULES=(
  "web-server/environments/dev"
  "web-server/environments/staging"
  "dns-server"
  "dhcp-server"
)

LINT_ONLY_DIRS=(
  "modules/ubuntu-vm"
)

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FAILED=0

echo "=================================================="
echo "Lint-only checks (shared modules)"
echo "=================================================="
for dir in "${LINT_ONLY_DIRS[@]}"; do
  echo "--- $dir ---"
  cd "$ROOT_DIR/$dir"
  tflint --init > /dev/null
  if ! tflint; then
    echo "FAILED: tflint in $dir"
    FAILED=1
  fi
  echo ""
done

for dir in "${ROOT_MODULES[@]}"; do
  echo "=================================================="
  echo "Checking: $dir"
  echo "=================================================="

  cd "$ROOT_DIR/$dir"

  echo "--- terraform validate ---"
  if ! terraform validate; then
    echo "FAILED: terraform validate in $dir"
    FAILED=1
  fi

  echo "--- tflint ---"
  tflint --init > /dev/null
  if ! tflint; then
    echo "FAILED: tflint in $dir"
    FAILED=1
  fi

  echo ""
done

cd "$ROOT_DIR"

if [ "$FAILED" -eq 0 ]; then
  echo "All checks passed across all directories."
else
  echo "One or more checks failed. See output above."
  exit 1
fi
