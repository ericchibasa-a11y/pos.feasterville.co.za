# Phase 8 — full production-input audit (READ ONLY)
Date: 2026-10-19
No production stock balance, recipe or receipt changes were made.

## Coverage
Daily stock-count rows: NDAYENI 1283, SIVANA 1078, BIRCH_ACRES 4.
Rows where stored used quantity differs from usage recalculated from CURRENT recipes: NDAYENI 106 (29 inputs), SIVANA 21 (14 inputs), BIRCH_ACRES 0 (insufficient records).
Totals are differences in assorted units; do NOT aggregate as inventory loss or Rand value.

## Priority review
- NDAYENI ICI-022 Banana Split: 7 days, +26 usage units recorded versus current recipe projection.
- NDAYENI ICI-039 Grandelch: 7 days, +17.
- NDAYENI ICI-016 Jolly Jelly Ice Cream: 5 days, 13 units total absolute difference.
- NDAYENI RAW-013 Bacon: 8 days, -12.870 in recorded units compared to projection. Verify unit changes/slices and historical mapping.
- NDAYENI RAW-012 Ham: 8 days, -11.880. Verify unit changes/slices.
- NDAYENI BRD-01 Kota Bread: 9 days, 9.500 total absolute difference.
- SIVANA RAW-007 Russian: 3 days, -9 units.
- NDAYENI RAW-007 Russian: 1 day, -8 units.

## Interpretation
This is NOT confirmed stock shortage. Current recipe mapping may differ from recipe mapping at historical sale time; some SKUs have been consolidated or changed units. Distinguish historic posting from today's recipe calculation. Do not backdate extra deductions without timestamped recipe history and approval.

## Next controls
1. For each flagged (store,input,date), identify sales line and historical recipe version, count row updates, receipts, transfers, unit definition.
2. Mark findings as recipe change / recording mistake / missing data / unexplained; require manager sign-off.
3. Obtain today's physical counts for high-risk items; reject inventory adjustments based solely on the projection.
4. Add recipe version snapshots at sale time to prevent this audit ambiguity in future.
5. Birch Acres requires proper daily count and transaction completeness checks before accuracy claims.

## Reproducible SQL
```sql
WITH mapped AS (
 SELECT s.store_code,s.sale_date,e->>'inputCode' input_code,
 SUM(i.qty*(e->>'qty')::numeric) expected_used
 FROM public.pos_sales s
 JOIN public.pos_sale_items i ON i.sale_id=s.id
 JOIN public.pos_store_product_recipes r ON r.store_code=s.store_code AND r.product_code=i.code
 CROSS JOIN LATERAL jsonb_array_elements(r.recipe) e
 GROUP BY 1,2,3
)
SELECT c.store_code,c.input_code,c.count_date,c.used_qty,
 COALESCE(m.expected_used,0) current_recipe_projection,
 c.used_qty-COALESCE(m.expected_used,0) difference
FROM public.pos_store_input_counts c
LEFT JOIN mapped m ON m.store_code=c.store_code AND m.sale_date=c.count_date AND m.input_code=c.input_code
WHERE abs(c.used_qty-COALESCE(m.expected_used,0))>0.0001
ORDER BY c.store_code,c.count_date DESC,c.input_code;
```
