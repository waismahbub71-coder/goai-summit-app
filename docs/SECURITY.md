# Security

## v1 (demo-first)
- No auth wall; all pages viewable by anonymous visitors
- RLS enabled but policies are permissive (open read/write) so demo works
- No secrets in code; Supabase keys via environment variables only
- GoHighLevel registration form is an iframe embed — no API keys in frontend

## Later (lock-down sprint)
- Per-user RLS: `auth.uid() = user_id` on all tables
- Admin role gate on CRM/Affiliate/Communications pages
- Rate-limiting on registration form submission
- PII fields (email, phone) masked in public views

## Approved-tools rule
Any external tool call (GoHighLevel, email, payment) uses a named, narrowly-scoped server action — never raw API passthrough. Structured errors with retryable vs terminal flags.

## Audit principle
Every meaningful state change (status transition, payout approval, comms send) logs actor + before/after. v1 stores created_at only; later sprint adds full audit_logs table.

## What could NOT be verified in v1
- Payment security (no payment processing in v1)
- Email sending (comms are manual status only)
- PII exposure prevention (demo data is synthetic; real data only after lock-down)