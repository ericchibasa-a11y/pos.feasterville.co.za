# Phase 6 — deployment gates (offline-only)

- **No production deployment, no database migration and no paid test branch.**
- Existing 20 offline Node.js tests rerun and passed.
- Critical recovery blocker: code backup branch is NOT a database backup. Production DB export and restore rehearsal required before changing live schema or stock calculations.
- Existing POS sales have `sale_date` (date), `sale_time` (time without timezone) and `created_at` (timestamp with timezone). Establish reliable event times and South Africa timezone treatment before comparing stock to 09:30 counts.
- Stock count `counted_at` is timestamp with timezone; compare only movements after count as-of cutoff.
- Transfers have `status` and `transfer_date`; only confirmed received movements should post inbound, with cancellation and retry idempotence.
- Zero physical counts are valid data, not missing records.
- Manager approval must be authenticated and checked server-side; the JS test approval properties are only placeholders.
- Rollout strategy: read-only adapter -> discrepancy comparison -> reviewed staging simulation -> backed up approved feature-flagged pilot -> production rollout.
- Rollback: disable new feature, restore prior POS code, reconcile post-backup live transactions before any database restore.
- Current scope is planning and offline logic only. Do not store customer data, credentials, private reports or database dumps in this public GitHub repository.
