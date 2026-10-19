# Controlled ham receipt unit correction — PREPARED, NOT EXECUTED
Confirmed owner instruction: quantities 6, 20, 12 are individual ham slices (EA), not KG.
Verified primary keys from live read-only query:
- id 44 NDAYENI 2026-09-05 qty 6.000 unit KG
- id 105 NDAYENI 2026-09-09 qty 20.000 unit KG
- id 65 SIVANA 2026-09-05 qty 12.000 unit KG
All are RAW-012, with historical unit_cost 80.00, which should NOT be changed without further review.

## Blockers
A verified restorable backup has not been established. Do not run the UPDATE before backup/restore testing and explicit deployment approval. Preserve the previous KG value and owner confirmation in a durable audit log. Confirm that changing receipt.unit does not retrigger inventory calculations unexpectedly.

## Read-only preflight
```sql
SELECT id,store_code,input_code,receipt_date,qty,unit,unit_cost,created_at
FROM public.pos_stock_receipts WHERE id IN (44,65,105) ORDER BY id;
```

## Proposed correction — NOT RUN
Execute only after gates cleared and audited transaction design confirmed:
```sql
BEGIN;
-- Require exact old values to prevent accidental edits to other receipts
UPDATE public.pos_stock_receipts
SET unit='EA'
WHERE (id=44 AND store_code='NDAYENI' AND receipt_date='2026-09-05' AND qty=6 AND unit='KG' AND input_code='RAW-012')
   OR (id=105 AND store_code='NDAYENI' AND receipt_date='2026-09-09' AND qty=20 AND unit='KG' AND input_code='RAW-012')
   OR (id=65 AND store_code='SIVANA' AND receipt_date='2026-09-05' AND qty=12 AND unit='KG' AND input_code='RAW-012')
RETURNING id,store_code,receipt_date,qty,unit;
-- Check exactly 3 returned records before COMMIT; otherwise ROLLBACK.
-- Existing original receipt values must be captured in durable audit records
-- as part of an approved operational change process before commit.
ROLLBACK; -- deliberately safe default; replace only in a supervised approved migration
```

## Post-update check and fallback
1. Confirm all three units EA and qty unchanged; sum=38 slices.
2. Verify input ledgers for both stores, unchanged cashups and financial reports.
3. If unexpected stock or report changes occur, stop and use the approved, audited rollback strategy; database restoration is not a substitute for reversing later transactions.
No changes to production were made preparing this file.
