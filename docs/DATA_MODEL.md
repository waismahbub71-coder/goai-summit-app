# Data Model

## participants
- id: uuid (pk)
- full_name: text
- email: text
- phone: text
- academy_affiliation: text (e.g. AI Academy Bangladesh / Australia / other)
- ticket_category: text
- registration_source: text (default 'goai_form')
- status: text (registered / confirmed / cancelled)
- user_id: uuid (nullable, for future owner-scoping)
- created_at: timestamptz
- **RLS:** v1 open read/write (demo-first)

## schedule_sessions
- id: uuid (pk)
- day_number: int (1–5)
- day_date: date
- day_label: text (e.g. "Day 1 — Wednesday, 16 Dec")
- start_time: text
- end_time: text
- title: text
- session_type: text (summit / fair / tour / break / meal / departure)
- location: text (e.g. Genting Highlands, Kuala Lumpur)
- speakers: text[] (names)
- theme: text
- sort_order: int
- user_id: uuid (nullable)
- created_at: timestamptz
- **RLS:** v1 open

## people
- id: uuid (pk)
- name: text
- category: text (faculty / partner / organiser / community)
- role_title: text
- organisation: text
- bio: text
- user_id: uuid (nullable)
- created_at: timestamptz
- **RLS:** v1 open

## digital_fair_exhibitors
- id: uuid (pk)
- product_name: text
- category: text (AI SaaS / digital product / service)
- description: text
- exhibitor_contact: text
- user_id: uuid (nullable)
- created_at: timestamptz
- **RLS:** v1 open

## tickets
- id: uuid (pk)
- category_name: text
- price_amount: numeric (nullable — pending confirmation)
- currency: text (default 'USD')
- inclusions: text
- refund_policy: text
- user_id: uuid (nullable)
- created_at: timestamptz
- **RLS:** v1 open

## communications_log
- id: uuid (pk)
- channel: text (email / phone / sms)
- subject: text
- audience_segment: text
- body_preview: text
- status: text (drafted / sent / failed)
- sent_at: timestamptz (nullable)
- user_id: uuid (nullable)
- created_at: timestamptz
- **RLS:** v1 open

## affiliate_referrals
- id: uuid (pk)
- affiliate_name: text
- referred_name: text
- referred_email: text
- sale_amount: numeric (nullable)
- currency: text (default 'USD')
- referral_status: text (applied / confirmed / pending)
- payout_status: text (pending / approved / paid)
- tax_note: text
- user_id: uuid (nullable)
- created_at: timestamptz
- **RLS:** v1 open

## Relationships
- participants.ticket_category → tickets.category_name (logical, no FK in v1)
- schedule_sessions.speakers[] → people.name (logical)
- No hard FKs in v1; all user_id nullable for demo-first.