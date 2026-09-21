# Architecture

## Stack
Next.js 14 (App Router) + Supabase (Postgres) + Vercel. Tailwind for UI. GoHighLevel form embedded via iframe for registration.

## Build now vs later
**Now (v1):** Itinerary, People directory, Digital Fair, Registration, Tickets, Comms log, Affiliate tracker — all public/demo, seeded, editable.
**Later:** Auth + per-user RLS, real GoHighLevel API sync, payment integration, email sending, Facebook ad/pixel, admin approval workflows.

## Key user action flow
1. Visitor lands on itinerary page → sees 5-day schedule grouped by day (seeded from brochure)
2. Browses People directory → filters by faculty/partner/organiser
3. Views AI Digital Fair exhibitors
4. Clicks Register → GoHighLevel form opens in iframe → on submit, participant record saved to `participants` table
5. Admin opens CRM tab → edits session, adds exhibitor, logs a communication, views referrals

## Responsive nav shell
Left sidebar on desktop (Itinerary · People · Digital Fair · Register · Tickets · CRM · Affiliates). Collapses to hamburger on mobile. Persistent "Learn. Source. Connect. Grow." header banner.

## Layer plan
1. **Data layer** (`lib/data/`) — all Supabase reads/writes, one module per object
2. **App logic** (`lib/actions/`) — server actions for CRUD, form submissions
3. **UI** (`app/` + `components/`) — pages and components, no direct DB calls
4. **Smart features** (`lib/ai/`) — later: auto-tag participants, suggest comms segments

## Why core runs without AI
Itinerary, directory, fair, registration, tickets, comms log, referrals are all structured DB CRUD. No AI needed for v1. AI tagging/segmentation is additive, added later.

## Repo structure
```
app/
  itinerary/page.tsx
  people/page.tsx
  fair/page.tsx
  register/page.tsx
  tickets/page.tsx
  crm/page.tsx
  affiliates/page.tsx
  layout.tsx
  page.tsx
components/
  Sidebar.tsx
  Banner.tsx
  SessionCard.tsx
  PersonCard.tsx
lib/
  data/
    participants.ts
    sessions.ts
    people.ts
    exhibitors.ts
    tickets.ts
    communications.ts
    referrals.ts
  actions/
    (server actions per object)
  ai/
    (later)
supabase/
  migrations/
```

## Module map
| Module | Responsibility | Owns | Build order |
|---|---|---|---|
| sessions | 5-day itinerary display + CRUD | schedule_sessions | 1st |
| people | Directory display + CRUD | people | 2nd |
| exhibitors | Digital fair listing + CRUD | digital_fair_exhibitors | 3rd |
| participants | Registration + profile | participants | 4th |
| tickets | Ticket categories | tickets | 5th |
| communications | Comms log view + CRUD | communications_log | 6th |
| referrals | Affiliate tracker + CRUD | affiliate_referrals | 7th |