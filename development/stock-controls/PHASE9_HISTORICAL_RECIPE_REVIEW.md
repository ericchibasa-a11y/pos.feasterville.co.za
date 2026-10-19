# FEASTERVILLE PHASE 9 — HISTORICAL USAGE INVESTIGATION AND PREVENTION
Date: 2026-10-19
Status: Read-only review. No production edits or stock adjustments.

## Verified findings
- Current input master lists RAW-007 Russian, RAW-012 Ham, RAW-013 Bacon, BRD-01 Kota Bread and ICI-022 Banana Split in unit EA at NDAYENI, SIVANA and BIRCH_ACRES.
- Russian-and-chips recipe records RC1/RC2/RC3/RC4 on NDAYENI and SIVANA show updated_at 2026-09-19T20:24:26Z; some sales occurred before this date. The currently visible recipe cannot prove the historical recipe at sale time.
- Phase 8 comparisons flagged e.g. NDAYENI Banana Split 26 units (net recorded minus current projected usage), Bacon -12.870, Ham -11.880, Kota Bread +8.500; SIVANA Russian -9. Treat these as investigation flags, not confirmed shortages. Mixed unit history and mapping changes may contribute.

## Proposed safe technical change — NOT DEPLOYED
1. At sale creation, persist immutable per-sale item recipe_snapshot including mapping version, input code, unit, qty per sellable unit, and sale item qty; post stock movement ids with unique (sale_item_id,input_code) deduplication.
2. Reversals must reference original movement IDs, never recalculate from current recipes.
3. Keep recipe version effective_at history and manager-reviewed changes.
4. Make master units explicit and immutable without a conversion migration. Bacon/ham EA must be operationally documented as slice or another defined unit. Do not silently interpret legacy decimal consumption as slices.
5. Flag exceptions by store, input, sale date, and evidence, with status NEW/REVIEWED/APPROVED/CLOSED; block auto backdating.
6. Count snapshots must record local offset-aware timestamp and deduct only subsequent movements.
7. Verification and rollout depend on external verified DB backup/restore, regression tests, code review and approval.

## Immediate store procedures
- Capture timed daily count for core ingredients and consumables.
- Agree bacon, ham, bread and burger/bread packaging stock units per store.
- Investigate historical ice-cream consolidation with SKU equivalence audit rather than imposing today's recipe on old sales.
- Do not create purchase receipts or stock adjustments simply to erase historical report discrepancies.

## Rollback and safety
Development branch only. No production DDL, recipe changes, adjustments or sale reprocessing.
