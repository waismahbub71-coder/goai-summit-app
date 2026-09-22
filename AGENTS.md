# goai-summit-app

<!-- Managed by Launchpad. Edits here may be overwritten on next sync. -->

## Stack & commands

- Framework: Next.js
- `dev`: `next dev --turbopack`
- `build`: `next build`
- `lint`: `next lint`
- `start`: `next start`

## Decisions

- Editing is restricted to admin users only
- Signup flow now includes community registration (beyond individual user registration).

## Notes

- Project has implemented: editable itinerary, people directory, fair registration, ticket workflows, CRM, affiliate management, and hardened registration with demo seed persistence.
- Commit was a trivial deployment trigger (chore), no functional changes.
- Deployment now explicitly uses Bun as declared package manager (packageManager field in package.json)
- commit fixes ordering of live itinerary sessions by time
- Added signup flow (user registration) and admin-only editing capability
- Added fair partner organization and community signup features.
- Summit ticket packages and pricing have been updated.
