# Meeting Notes Assistant — Requirements (v1)

## Problem statement
Real-time meeting transcription and AI-generated summaries/action items for Google Meet,
built to demonstrate full-stack product engineering: real-time systems, background
job processing, AI integration, and a browser extension — with the process (issues,
ADRs, TDD, reviews) as visible as the product itself.

## Core scope (v1 — must ship)

**Functional**
- FR1: User signs in with Google (NextAuth).
- FR2: User starts/stops a live transcription session from browser mic input.
- FR3: Live transcript renders in real time with speaker labels.
- FR4: On meeting end, a background job generates a structured summary + action
  items (Claude) and emails formatted notes within ~60s.
- FR5: User can browse meeting history and open a past meeting's transcript,
  summary, and action items.
- FR6: A Chrome extension captures Google Meet tab audio (all participants,
  not just the local mic) and renders a live-transcript overlay inside the
  Meet window itself.

**Non-functional**
- NFR1: CI-enforced tests on business logic — parsing, validation, retry
  logic, structured-output schemas.
- NFR2: Live transcript latency under ~3s end to end.
- NFR3: Post-processing survives a server/worker restart (queue-backed, not
  in-memory).
- NFR4: No secrets committed; all config via environment variables.
- NFR5: Every consequential architecture choice has a written ADR
  (`docs/adr/`) — context, options considered, decision, consequences.
- NFR6: README states the consent/legal caveat around capturing meeting
  audio from other participants.

## Explicitly out of scope for v1
- RAG "ask your meeting" chat (pgvector + retrieval)
- Translation
- PDF export
- Bot-joins-as-a-participant capture mode

Cut for time and signal-density, not because they're hard — noted here so
scope decisions are visible, not accidental.

## Demo script (what "done" looks like)
1. Sign in → "New Meeting" → title + agenda.
2. Start capture → live transcript streams in, speaker-labeled.
3. End meeting → email arrives within 60s with summary + action items.
4. Dashboard shows the meeting with full transcript, summary, checkable
   action items.
5. Chrome extension installed → join a real Meet → floating overlay shows
   live transcript for all participants, not just the host.
