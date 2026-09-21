# GOAI Summit Malaysia 2026 — Planner & CRM

## Problem
The GOAI Summit (16–20 Dec 2026, Genting Highlands & KL) needs a centralised system to manage participant registration, a 5-day itinerary, a people directory (faculty/partners/organisers), an AI Digital Fair exhibitor listing, and CRM communications — all referenced against the brochure which is the single source of truth.

## Target user
Three roles: **Public visitor** (views itinerary, directory, fair, registers), **Organiser/Admin** (manages CRM, comms, campaigns, affiliate data), **Affiliate** (tracks referrals & payouts). v1 is demo-first: all pages viewable without login; admin tools seed-editable.

## Core objects
1. **Participants** — registration form (embed GoHighLevel), profile, academy affiliation, ticket category.
2. **Schedule sessions** — day, date, time, title, location, speakers, type (summit/fair/tour/break).
3. **People** — name, role, category (faculty/partner/organiser/community), bio, affiliation.
4. **Digital fair exhibitors** — product name, category, description, exhibitor contact.
5. **Tickets** — category, price, currency, inclusions, refund policy note.
6. **Communications log** — channel, subject, audience segment, status, timestamp.
7. **Affiliate referrals** — affiliate name, referral status, sale amount, payout status.

## MVP (v1) — checklist
- [ ] 5-day itinerary page with all sessions from brochure, grouped by day
- [ ] People directory (faculty + partners + organisers, filterable by category)
- [ ] AI Digital Fair exhibitor listing (CRUD)
- [ ] Registration page with GoHighLevel form embed + participant record saved
- [ ] Ticket categories table with seeded pricing placeholders
- [ ] Communications log view (seeded demo rows)
- [ ] Affiliate referral tracker (seeded demo rows)
- [ ] Admin CRUD for all objects (no auth wall in v1 — seed-editable)
- [ ] "Learn. Source. Connect. Grow." banner persistent on every page

## Non-goals (v1)
- Authentication / per-user login (later sprint)
- Payment processing (ticket prices are placeholders until confirmed)
- Live email sending (comms log is manual status)
- Facebook ad account / pixel integration
- Real GoHighLevel API sync (form embed only)

## Success criteria
A stranger visiting the URL sees the full 5-day itinerary, browses faculty/partners/organisers, views the AI Digital Fair exhibitors, fills the registration form (record saved to DB), and an admin can edit any session/person/exhibitor — all without signing in.