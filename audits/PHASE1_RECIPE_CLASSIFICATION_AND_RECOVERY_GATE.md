# FEASTERVILLE POS — PHASE 1 RECIPE CLASSIFICATION & RECOVERY GATE
Date: 2026-10-19
Production Supabase project: sflyjcgbxbcwspfuzone

## Classification result
All 53 empty recipe rows belong to INACTIVE sellable products. Active empty recipes: zero.
- NDAYENI: 24 empty, 0 active.
- SIVANA: 5 empty, 0 active.
- BIRCH_ACRES: 24 empty, 0 active.
Action: no automatic recipe modifications. When reactivating a discontinued product, require validation that its recipe is complete or appropriately stock-linked before sale.

## Recovery verification
- GitHub original code preserved via branch backup-2026-10-19-pre-stock-controls (branch created from main).
- Supabase list_branches returned no existing development database branches.
- No direct backup/export/restore operation is exposed through connected Supabase tools. No full DB backup was created or verified.
- Stop sign: do not deploy production migrations or high-risk stock-control rewrites until a recovery copy and restore procedure are verified, with user approval for any branch costs.

## Next implementation design
1. Add timestamp-aware counted_at, baseline_at, counted_qty and ledger computed as-of count timestamp rather than comparing counts with all-day consumption. Maintain morning physical versus closing theoretical balances separately.
2. Hard validation when INACTIVE product with empty recipe becomes ACTIVE.
3. Automated alert for negative stock and absent receipts; never silently fabricate supplier purchases.
4. Idempotent posting safeguards for receipts/sales, traceable stock adjustments and audit history.
5. Verify open/cash-up consistency, staff permissions and cross-store isolation after all stock changes.

Production deployment: none.
