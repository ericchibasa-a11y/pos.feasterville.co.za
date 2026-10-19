# Phase 2 — Stock Controls Test Plan

Status: planned, NOT deployed.

## Prerequisites
1. Verify full production Supabase backup and restore procedure.
2. Get explicit cost approval for development database. Supabase reported $0.01344 USD per hour, other charges may apply.
3. Clone production schema into isolated database and seed **synthetic** test stock/sales (production data is not copied automatically).

## Checks
- Opening stock and time-stamped morning count as separate concepts.
- Reconcile quantity as-of 09:30 and deduct only sales and stock movements after count time.
- Ensure previous count corrections to Ndayini BOX-20, CTN-01 and Sivana BOX-20 are retained.
- Preserve one-time sale and receipt posting; test repeat requests.
- Flag negative balances and require supervisor review; never create fictitious receipts.
- Validate recipe before reactivating inactive menu products with empty recipes.
- Validate every store independently and every payment workflow.
- Regression tests: sales, refunds, cashups, transfers, reports, printouts, role permissions.

## Release gate
Do not push migrations to production before recovery proof, passing tests and explicit deployment review.
