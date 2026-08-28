# The Personal Field Guides — Digital Prototype V1.0

V1.0 adds a real Field Session workflow.

## Field Session

A reader can:

- choose one or more source-supported specimens
- title and date the session
- record timed observations for each fragrance:
  - Opening / 0 minutes
  - 15 minutes
  - 1 hour
  - Later / drydown
  - Decision
- write a session-wide comparison note
- handwrite or draw a full session page with Apple Pencil / pen
- save and reopen previous sessions

## Integration

Saving a session writes a dated summary back into each selected specimen's field-record history. The session itself is also preserved as its own object, so cross-fragrance comparisons are not lost.

Personal and Will sessions are separate.

## Cloud

The connected Supabase backend now includes a row-level-secured `pfg_field_sessions` table.

Stored session data includes:

- date
- title
- selected specimen IDs
- timed observations
- comparison note
- Apple Pencil vector strokes

## Design principle

This workflow is intentionally observational rather than evaluative. It does not impose scores or fragrance-review jargon. The goal is to capture what changed, what appeared, and what one fragrance revealed about another.

## Next

The next product step should be **packaging and deployment**, so the prototype can be opened as a real HTTPS web app on iPad and laptop rather than only as a local ZIP.
