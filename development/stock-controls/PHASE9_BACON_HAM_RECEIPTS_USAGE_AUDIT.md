# Phase 9 — Bacon/Ham Receipt and Usage Unit Audit
Audit date: 2026-10-19. READ ONLY. No balance or receipt changes.

## Confirmed current standard
RAW-012 HAM and RAW-013 BACON: 1 EA = 1 slice at all Feasterville branches. Current active recipes use 1 slice per mapped meal.

## Historical receipts: important conflicts
- NDAYENI RAW-012 HAM: 2026-09-05 qty 6 KG; 2026-09-09 qty 20 KG. Master is currently EA (slices). Do not silently interpret either KG quantity as a slice count.
- SIVANA RAW-012 HAM: 2026-09-05 qty 12 KG; 2026-10-19 15 EA and 5 EA under common invoice reference INV-33-104929-20261019-HAM.
- NDAYENI RAW-013 BACON: 2026-10-19 5 EA and 15 EA with same invoice reference INV-33-104929-20261019-BACON.
- Two receipt rows sharing one invoice reference are NOT necessarily duplicate receipts: verify source document, intent and line-item quantities before changing them.

## Fractional usage rows flagged
- NDAYENI ham RAW-012: 8 rows of fractional used_qty, Sept 9 to Oct 6, e.g. 2.01, 1.01, 4.03.
- NDAYENI bacon RAW-013: 8 fractional rows, Sept 8 to Oct 9, e.g. 1.02, 0.01.
- SIVANA ham RAW-012: 1 fractional row, Sept 27, 1.01.
- SIVANA bacon RAW-013: 1 fractional row, Sept 14, 0.01.
- These values do not align with indivisible slice consumption. Historical records require source verification, not automatic rounding.

## Required corrections / prevention
1. Capture supplier invoices and the actual purchased unit for legacy ham entries. Ask for package size and slice quantities, do not assume KG-to-slice conversion.
2. Review invoice INV-33-104929-20261019 and confirm whether 5+15 slices and 15+5 slices represent actual line items or duplicate capture.
3. Audit historical fractional deduction sources and original mapping versions.
4. Future EA slice receipts/counts/recipes: positive whole numbers only, with a separate source-unit + conversion record for kg/pack purchases.
5. Preserve original transactions via audit trail; do not delete or overwrite verified source entries in place.
6. Reconcile actual physical slices as of a timestamp before adjusting opening balance.

No production edits, schema changes or inventory adjustments made.
