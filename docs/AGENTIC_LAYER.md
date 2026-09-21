# Agentic Layer

## Draftable actions (low risk — auto)
- Auto-fill session sort orders from day/time
- Auto-tag participant academy affiliation from email domain
- Summarise comms log into weekly digest
- Draft communication from template + participant context

## Executable after approval (medium risk)
- Create/update a marketing campaign
- Update participant status (registered → confirmed)
- Update referral payout status (pending → approved)
- Add a new exhibitor listing

## Human-only (high/critical risk)
- Delete a participant record
- Process a refund
- Send a live communication (email/SMS) to real recipients
- Modify ticket pricing or refund policy
- Approve affiliate payout for payment

## Named tools
- `draft_communication` — generates comms draft from template
- `tag_participant` — assigns tags from registration data
- `summarise_comms` — weekly comms digest
- `update_participant_status` — status transition (requires approval)
- `update_referral_payout` — payout status change (requires approval)

## Audit log fields
- action: text, actor: text, target_table: text, target_id: uuid, before: jsonb, after: jsonb, created_at: timestamptz

## v1 vs later
- **v1:** No agentic actions — all manual CRUD.
- **Later:** Draft comms, auto-tag, summarise, with approval workflow + audit log table.