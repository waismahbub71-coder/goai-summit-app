# Intelligence Layer

## v1: No AI required
Itinerary, directory, fair, registration, tickets, comms, referrals are all structured DB CRUD. The app fully works without any AI.

## Later: auto-structure and score
**Messy inputs:** Participant free-text registrations, comms log notes, affiliate referral descriptions.

**Auto-structure schema (participant tagging):**
```json
{
  "tags": ["vip", "bd", "repeat_attendee"],
  "academy": "AI Academy Bangladesh",
  "interest_pillars": ["Learn", "Source"],
  "priority_score": 0.82,
  "source": "ai_tagger",
  "confidence": 0.82,
  "review_status": "unreviewed"
}
```

**Events to track:** registration submitted, session viewed, exhibitor contacted, communication logged, referral status changed.

**Scoring rules (start rule-based):**
- Affiliate referral: confirmed sale = +1.0, pending = +0.3, applied = +0.1
- Participant priority: VIP ticket category = +0.5, academy member = +0.3, confirmed = +0.2
- Comms urgency: unresponded email >3 days = +0.4

**What gets ranked:** Participants by priority_score; referrals by sale_amount + payout_status.

## v1 vs later
- **v1:** All manual CRUD, no AI fields.
- **Later:** Auto-tag participants, suggest comms segments, rank referrals, draft comms from template.