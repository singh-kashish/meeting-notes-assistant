# ADR-0001: Turborepo monorepo with a split Next.js frontend and Node backend

## Status
Accepted

## Context
The product needs a live WebSocket connection for streaming transcripts and
a background worker (BullMQ) for post-meeting AI processing. Next.js API
routes are built around short-lived serverless/edge functions and don't
support long-lived WS connections cleanly on a standard Vercel deploy —
doing so requires a custom server that fights the framework's deployment
model.

Separately, both the frontend (form validation, WS message shapes) and the
backend (API validation, WS message shapes, job payloads) need the same
Zod schemas. Duplicating them invites drift; publishing a private npm
package for a solo two-to-three-week project is more process than the
problem needs.

## Decision
Use a Turborepo monorepo:

```
apps/
  web/     - Next.js frontend (Vercel)
  server/  - Fastify backend: REST API, WebSocket server, BullMQ worker (Railway/Render/Fly)
packages/
  shared/  - Zod schemas + shared TS types, imported by both apps
  db/      - Prisma schema + generated client, imported by apps/server
```

## Alternatives considered
- **Single Next.js app.** Rejected — WS/long-lived-connection support is
  the blocking constraint; would require a custom server that undermines
  the reason to use Next.js API routes in the first place.
- **Two separate repos (frontend, backend), schemas duplicated or
  published as an npm package.** Rejected — duplication risks drift; a
  published package adds versioning/publish overhead disproportionate to
  a solo project on a short timeline.
- **Nx instead of Turborepo.** Rejected — Nx's plugin system and generators
  are built for larger orgs; Turborepo's simpler pipeline/cache model is a
  better fit for two apps and two packages.

## Consequences
- Two deployables instead of one: `apps/web` to Vercel, `apps/server` to a
  host that supports persistent connections (Railway/Render/Fly — not
  Vercel serverless).
- `packages/shared` and `packages/db` need to be wired into the Turborepo
  pipeline (`turbo.json`) so builds/tests run in the right dependency order.
- Slightly more setup cost on day 1 than a single app, in exchange for
  avoiding a rewrite when the WS requirement would otherwise force one in
  Phase 2.
