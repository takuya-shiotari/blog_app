#!/usr/bin/env bash
# Fast iteration loop: lint + tests only. Not a substitute for `bin/ci`,
# which additionally runs bundler-audit / importmap audit / Brakeman and
# is the required gate before merge.
set -euo pipefail

bin/rubocop
bin/rails test
