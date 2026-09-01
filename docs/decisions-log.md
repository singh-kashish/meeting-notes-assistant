# Decisions Log

Lower-stakes choices, logged for traceability without the overhead of a
full ADR. Use an ADR instead when a decision has real competing
alternatives with meaningful long-term consequences (see `docs/adr/`).

| Decision | Chosen | Why (brief) |
|---|---|---|
| Auth provider | NextAuth / Auth.js | Free, industry-standard, built-in Google OAuth provider; Clerk was the alternative but is a hosted black box with less to show for it. |
| Local DB | Docker Compose Postgres | Fully offline local dev, no cloud dependency during development; Neon/Supabase remain options for a deployed environment later. |
