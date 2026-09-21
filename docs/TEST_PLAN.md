# Test Plan

## v1 success scenario (manual)
1. Open app URL as anonymous visitor → land on itinerary page
2. Verify all 5 days render: Day 1 (16 Dec) through Day 5 (20 Dec) with correct sessions
3. Verify "Learn. Source. Connect. Grow." banner visible
4. Click People → verify faculty (Vince Tan, Wais Mahbub, etc.), partners (Scalendo, BIBU), organisers (Cdr. Nazmul Hasan, etc.) all present
5. Click Digital Fair → see seeded exhibitor cards
6. Click Register → GoHighLevel form loads in iframe
7. Fill form → submit → verify participant record appears in DB (check Supabase table)
8. Click Tickets → see category cards with placeholder pricing
9. Open CRM → log a communication (email, subject, status) → save → verify it persists after refresh
10. Open Affiliates → update a referral status → verify it persists

## Empty state
- Delete all sessions → itinerary shows "No sessions scheduled yet" with add button
- No people → directory shows "No people listed yet"
- No exhibitors → fair shows "No exhibitors yet — add one"

## Error state
- Supabase unreachable → pages show error message, not blank screen
- Form submit fails → error toast with retry option
- Invalid data on create → validation message, no partial save

## Permission (v1)
- Anonymous user can read + create + edit all objects (demo-first)
- No data leaks across tables (each CRUD scoped to its own table)

## Post-build checklist
- [ ] All 5 itinerary days correct per brochure
- [ ] All faculty/partners/organisers from brochure seeded
- [ ] Registration form embed loads
- [ ] Participant record saves to DB on form submit
- [ ] Comms log CRUD works
- [ ] Affiliate referral status update works
- [ ] No secrets in frontend code
- [ ] Responsive: sidebar collapses on mobile