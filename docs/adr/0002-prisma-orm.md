# ADR-0002: Prisma as the ORM, isolated in packages/db

## Status
Accepted

## Context
The project needs schema migrations and type-safe DB access for meetings,
transcripts, and action items, shared by `apps/server` (and potentially a
future worker). The build timeline is 1–3 weeks with the author learning
several new tools concurrently (WebSockets, BullMQ, Chrome extensions),
so tooling with the least incidental friction is worth more right now
than tooling that is marginally more "correct."

## Decision
Use Prisma, with the schema and generated client living in `packages/db`
so `apps/server` (and any future worker package) import a single typed
client rather than each defining their own.

## Alternatives considered
- **Drizzle.** More SQL-literal, lighter runtime, and arguably a better
  long-term skill to have — but more manual query-building to learn
  alongside everything else on the roadmap. Genuinely a fine choice;
  rejected here specifically for time-budget reasons, not because Prisma
  is objectively better.

## Consequences
- `prisma migrate dev` is the source of truth for schema changes; migration
  files are committed under `packages/db/prisma/migrations`.
- Prisma's generated client adds a build step `packages/db` must run before
  `apps/server` can build — wired into the Turborepo pipeline per ADR-0001.
- Revisit if a future phase needs raw-SQL-level control Prisma makes
  awkward (unlikely at this project's scale).
