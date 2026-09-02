# Phase 0 — Foundations: Issue Drafts

Labels used: `phase-0`, `infra`, `arch-decision`, `docs`

---

### 1. Scaffold Turborepo monorepo structure
**Labels:** phase-0, infra
Create `apps/web` (Next.js, TS, App Router), `apps/server` (Fastify, TS),
`packages/shared`, `packages/db`. Wire `turbo.json` pipeline (`build`,
`lint`, `test`, `dev`). Root `package.json` workspaces configured.
**Acceptance criteria:**
- `turbo run build` succeeds across all apps/packages from a clean clone.
- `apps/server` boots with a `/health` route returning 200.

---

### 2. Shared tooling: TS config, ESLint, Prettier, Husky
**Labels:** phase-0, infra
Shared `tsconfig.base.json`, ESLint + Prettier config in a shared package,
Husky pre-commit running lint + typecheck on staged files.
**Acceptance criteria:**
- Committing a lint violation is blocked locally.
- `apps/web` and `apps/server` both extend the shared config, no duplicated
  rules.

---

### 3. CI pipeline (GitHub Actions)
**Labels:** phase-0, infra
`turbo run lint test build` on every PR and on push to `main`. Cache
Turborepo remote cache if convenient, but not required for v1.
**Acceptance criteria:**
- CI is green on the first PR that adds it (even with placeholder tests).
- `main` branch protection requires this check to pass before merge.

---

### 4. Local Postgres via Docker Compose
**Labels:** phase-0, infra
`docker-compose.yml` at root running Postgres, `.env.example` with the
connection string, documented in README ("run `docker compose up -d`
before `prisma migrate dev`").
**Acceptance criteria:**
- Fresh clone + `docker compose up -d` + `prisma migrate dev` gets a
  working local DB with no manual steps beyond that.

---

### 5. Prisma schema + initial migration
**Labels:** phase-0
`packages/db`: `User`, `Meeting`, `Transcript`, `ActionItem` models per
`docs/requirements.md`. Generated client exported for `apps/server`.
**Acceptance criteria:**
- `prisma migrate dev` runs clean against the Docker Postgres from #4.
- A basic seed script creates one user and one meeting for local dev.

---

### 6. NextAuth Google OAuth in apps/web
**Labels:** phase-0
Google provider configured, session available in server components,
protected route redirects unauthenticated users to sign-in.
**Acceptance criteria:**
- Signing in with Google creates/links a `User` row in Postgres.
- A protected page 302s to sign-in when logged out (covered by a test).

---

### 7. Meeting CRUD API on apps/server, TDD
**Labels:** phase-0
`POST /meetings`, `GET /meetings`, `GET /meetings/:id` — Zod-validated
request/response using schemas from `packages/shared`.
**Acceptance criteria:**
- Tests written first (Vitest + supertest or equivalent) for each route,
  covering success + validation-failure cases, before implementation.
- All three routes pass their tests in CI.

---

### 8. Repo process docs: CONTRIBUTING.md + PR/issue templates
**Labels:** phase-0, docs
Document the Plan → Code → Review loop explicitly (mirrors `AGENTS.md`
config used by Kilo Code/Antigravity), PR template with a self-review
checklist (architecture / security / tests), issue template for new work.
**Acceptance criteria:**
- PR template checklist is non-trivial (not just "tests pass") and gets
  filled out on the very first real PR.

---

### 9. README skeleton
**Labels:** phase-0, docs
Problem statement, architecture diagram placeholder, local dev setup
steps, link to `docs/adr/` and `docs/requirements.md`, the meeting-audio
consent caveat from NFR6.
**Acceptance criteria:**
- A stranger can clone the repo and get local dev running using only the
  README.
