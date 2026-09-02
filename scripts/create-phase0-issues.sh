#!/usr/bin/env bash
# Bulk-create Phase 0 issues via GitHub CLI.
# Prereqs: `gh auth login` already done, run from inside the repo (or pass --repo owner/name).
# Labels must exist first — create them via `gh label create` or the GitHub UI:
#   phase-0, infra, arch-decision, docs

set -euo pipefail

gh issue create --title "Scaffold Turborepo monorepo structure" \
  --label "phase-0,infra" \
  --body "See docs/issues/phase-0.md #1. Acceptance: turbo run build succeeds clean; apps/server /health returns 200."

gh issue create --title "Shared tooling: TS config, ESLint, Prettier, Husky" \
  --label "phase-0,infra" \
  --body "See docs/issues/phase-0.md #2. Acceptance: lint violations blocked pre-commit; no duplicated config."

gh issue create --title "CI pipeline (GitHub Actions)" \
  --label "phase-0,infra" \
  --body "See docs/issues/phase-0.md #3. Acceptance: turbo run lint test build green on first PR; branch protection requires it."

gh issue create --title "Local Postgres via Docker Compose" \
  --label "phase-0,infra" \
  --body "See docs/issues/phase-0.md #4. Acceptance: fresh clone + docker compose up -d + prisma migrate dev works with no extra steps."

gh issue create --title "Prisma schema + initial migration" \
  --label "phase-0" \
  --body "See docs/issues/phase-0.md #5. Acceptance: migration runs clean; seed script creates one user + meeting."

gh issue create --title "NextAuth Google OAuth in apps/web" \
  --label "phase-0" \
  --body "See docs/issues/phase-0.md #6. Acceptance: sign-in creates/links a User row; protected route redirect covered by a test."

gh issue create --title "Meeting CRUD API on apps/server, TDD" \
  --label "phase-0" \
  --body "See docs/issues/phase-0.md #7. Acceptance: tests written first for all three routes, success + validation-failure cases."

gh issue create --title "Repo process docs: CONTRIBUTING.md + PR/issue templates" \
  --label "phase-0,docs" \
  --body "See docs/issues/phase-0.md #8. Acceptance: PR template checklist filled out on first real PR."

gh issue create --title "README skeleton" \
  --label "phase-0,docs" \
  --body "See docs/issues/phase-0.md #9. Acceptance: a stranger can get local dev running from the README alone."

echo "Phase 0 issues created."
