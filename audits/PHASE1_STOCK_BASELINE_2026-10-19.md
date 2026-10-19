# FEASTERVILLE POS — PHASE 1 BASELINE AUDIT
Date: 2026-10-19
Status: READ-ONLY DIAGNOSTICS — NO LIVE DEPLOYMENT

## Safety and recovery
- Snapshot of POS application code retained as GitHub branch `backup-2026-10-19-pre-stock-controls`, created from main before any application changes.
- This Git branch is NOT a Supabase database backup.
- Before schema migrations or application releases: obtain and verify a recoverable external/Supabase database backup and establish tested rollback.
- Do not deploy changes directly to main without test and approval.

## Production references
- Feasterville POS database: Supabase project `sflyjcgbxbcwspfuzone`.
- Branch codes: NDAYENI, SIVANA, BIRCH_ACRES.

## Recipe baseline
- NDAYENI: 143 recipes; 24 have empty JSON recipe arrays.
- SIVANA: 204 recipes; 5 have empty JSON recipe arrays.
- BIRCH_ACRES: 141 recipes; 24 have empty JSON recipe arrays.
Empty recipes need classification: sellable item without production inputs vs incomplete meal recipe. Do NOT automatically populate.
- S40 containers are input CTN-01; R20 boxes are BOX-20.
- Previous comparison: CTN-01 usage Ndayini 365, Sivana 132, matches mapped sales across recorded dates. Birch Acres has no recorded usage.
- Existing 2026-10-19 owner-confirmed stock baseline: Ndayini BOX-20 morning 56, subsequent calculated closing 47 based on nine sales; Ndayini CTN-01 morning 33, subsequent calculated closing 24 based on nine sales. Sivana BOX-20 morning 21, subsequent consumption can change as new orders arrive. Preserve these unit reset corrections.
- SIVANA CTN-01 indicated negative balance -25 at prior inspection: requires physical count and receipt verification, not guessed correction.
- Note: daily stock-count generated variance compares morning counts and end-of-day calculated stock; redesign to compare like timestamps.
- Receipts currently recorded: Ndayini 159, Sivana 74, Birch Acres 9.

## Required tests before modification
1. Receipt capture exactly once, proper store and purchase date.
2. Sale recorded exactly once, recipe consumption exactly once (with return/reversal handling).
3. Opening + receipts + transfers in - usage - transfers out +/- adjustments = stock ledger closing.
4. Counts timestamp-aware. Never mistake morning count for closing count.
5. Negative stock alerts, missing receipts, stale stock balances.
6. Unclosed cash-ups; cash/card/Mr D/Uber Eats/Paystack payment checks.
7. Production inputs stock mapping across all menu codes and stores, including sales channels.
8. Store separation and manager/stock-controller permissions.
9. Daily backups, restore rehearsal, reporting consistency, POS printer and session recovery.

## Phased release gates
Phase 1: baseline/read-only audit + backup verification.
Phase 2: ledger/reconciliation corrections in isolated test environment.
Phase 3: stock workflow and recipe gap fixes after review.
Phase 4: cashups/financial dashboards and expense controls.
Phase 5: operational KPI and sales workflow improvements.
No production migration until database recovery route and regression tests pass.

## Outstanding
- Obtain verified DB backup / restore.
- Classify empty recipes; verify active vs inactive sellables.
- Confirm Birch Acres live sale/source configuration.
- Obtain physical S40 count at Sivana; do not fabricate positive receipts.
