# Phase 9 — Bacon and ham active-recipe verification
Date: 2026-10-19
Scope: all active sellable recipes using RAW-012 (Ham) or RAW-013 (Bacon).

Owner-confirmed unit: 1 EA = 1 slice for both products at NDAYENI, SIVANA, BIRCH_ACRES.

## Read-only results
| Store | Ham mappings | Bacon mappings | Fractional/nonpositive entries |
| --- | ---: | ---: | ---: |
| NDAYENI | 7 | 5 | 0 |
| SIVANA | 12 | 7 | 0 |
| BIRCH_ACRES | 7 | 5 | 0 |
| TOTAL | 26 | 17 | 0 |

All 43 active mappings have qty 1 per sellable item (a distinct mapping could exist for ham and bacon in the same meal).
Includes add-on items, kota, burgers, wraps, rib burgers and Sivana Mr D recipes.

## Limitations
- Only validates active recipe quantities and unit plausibility; does NOT validate historical mappings, physical portion size or consumption posting at the time of sale.
- Historical decimal differences remain unresolved; do not reprocess sales or force balances.
- Purchases and physical counts must consistently use slices. Verify prior receipts and counts before any unit conversion.

## Actions
- No live recipe changes necessary.
- Keep original POS and production inventory untouched.
- Proposed controls on development branch only: enforce positive whole-number slice qty on new/edit recipes, retain sale-time immutable recipe snapshot, approval-audit adjustments.
