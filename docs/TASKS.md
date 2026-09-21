# Task Plan

## Sprint 1 — Itinerary + People (core engine)
**Goal:** The 5-day itinerary and people directory are live and editable.
- [ ] Set up Next.js + Supabase + Tailwind + sidebar shell + Learn.Source.Connect.Grow banner
- [ ] Create DB tables: schedule_sessions, people (migration)
- [ ] Seed all 5 days of sessions from brochure + all faculty/partners/organisers
- [ ] Itinerary page: sessions grouped by day, sorted by time
- [ ] People page: cards grouped/filtered by category
- [ ] Admin CRUD: add/edit/delete session and person
- **DoD:** Stranger visits URL → sees full 5-day itinerary + browses all people; can add/edit a session and person; changes persist after refresh.

## Sprint 2 — Digital Fair + Registration (v1 functional milestone)
**Goal:** AI Digital Fair listing + participant registration working.
- [ ] Create DB tables: digital_fair_exhibitors, participants, tickets
- [ ] Seed demo exhibitors + ticket categories (placeholders)
- [ ] Fair page: exhibitor cards + CRUD
- [ ] Register page: GoHighLevel iframe embed + save participant record on submit
- [ ] Tickets page: category cards with price/inclusion placeholders
- **DoD:** Stranger views fair exhibitors, fills registration form → record saved to DB; admin can add exhibitor and edit tickets.

## Sprint 3 — CRM + Affiliates (breadth)
**Goal:** Communications log and affiliate referral tracker live.
- [ ] Create DB tables: communications_log, affiliate_referrals
- [ ] Seed demo comms + referral rows
- [ ] CRM page: comms log table + add/log communication
- [ ] Affiliates page: referral table + status updates
- **DoD:** Admin logs a communication and updates a referral status; both persist after refresh.

## Sprint 4 — Lock it down (later)
**Goal:** Auth + per-user RLS + admin role gate.
- [ ] Supabase Auth (email/password)
- [ ] RLS policies: `auth.uid() = user_id` on all tables
- [ ] Admin role check on CRM/Affiliate/Comms pages
- [ ] Public pages remain open (itinerary, people, fair, register)
- [ ] PII masking on public views
- **DoD:** Logged-out user sees public pages; CRM/comms/affiliates redirect to login; seeded demo rows still visible on public pages.

## Gantt
```
Sprint 1: [==Itinerary==][==People==]
Sprint 2: [==Fair==][==Register==][==Tickets==]  ← v1 functional
Sprint 3: [==CRM==][==Affiliates==]
Sprint 4: [==Auth==][==RLS==][==Lock down==]
```