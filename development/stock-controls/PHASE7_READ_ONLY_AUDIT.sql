-- PHASE 7: READ-ONLY STOCK COMPARISON
-- Run in Supabase SQL editor. No writes, no DDL, no state changes.
-- This compares CURRENT recipe mappings with historical sale items.
-- Recipe changes over time cannot be reconstructed without versions.
WITH mapped_sales AS (
 SELECT s.store_code, s.sale_date, e->>'inputCode' AS input_code,
        SUM(i.qty * (e->>'qty')::numeric) AS expected_used
 FROM public.pos_sales s
 JOIN public.pos_sale_items i ON i.sale_id=s.id
 JOIN public.pos_store_product_recipes r
   ON r.store_code=s.store_code AND r.product_code=i.code
 CROSS JOIN LATERAL jsonb_array_elements(r.recipe) e
 WHERE e->>'inputCode' IN ('CTN-01','BOX-20')
 GROUP BY s.store_code,s.sale_date,e->>'inputCode'
)
SELECT c.store_code,c.input_code,c.count_date,
       c.opening_qty,c.received_qty,c.used_qty,
       c.opening_qty+c.received_qty-c.used_qty AS calculated_closing,
       c.physical_count,c.counted_at,c.count_type,
       COALESCE(ms.expected_used,0) AS recipe_based_usage,
       c.used_qty-COALESCE(ms.expected_used,0) AS usage_difference,
       CASE
         WHEN c.opening_qty+c.received_qty-c.used_qty<0 THEN 'NEGATIVE_BALANCE'
         WHEN c.used_qty<>COALESCE(ms.expected_used,0) THEN 'USAGE_MISMATCH'
         WHEN c.counted_at IS NOT NULL THEN 'COUNT_SNAPSHOT_PRESENT'
         ELSE 'MATCH_NO_COUNT'
       END AS review_status
FROM public.pos_store_input_counts c
LEFT JOIN mapped_sales ms ON ms.store_code=c.store_code
 AND ms.sale_date=c.count_date AND ms.input_code=c.input_code
WHERE c.input_code IN ('CTN-01','BOX-20')
ORDER BY c.count_date DESC,c.store_code,c.input_code;
