# Phase 10 — Bacon and Ham legacy receipts: evidence and safeguards
Date: 2026-10-19
READ ONLY. No inventory writes.

## Findings verified from production SELECT statements
- NDAYENI HAM RAW-012: Sept 5 qty 6, KG, unit cost R80; Sept 9 qty 20, KG, unit cost R80 (entered Sept 12); both lack supplier and reference.
- SIVANA HAM RAW-012: Sept 5 qty 12, KG, unit cost R80; lacks supplier and reference.
- Oct 19 NDAYENI BACON RAW-013: 5 EA @ R5.49 and 15 EA @ R5.50; same invoice reference; recorded same timestamp.
- Oct 19 SIVANA HAM RAW-012: 15 EA @ R3.75 and 5 EA @ R3.74; same invoice reference; recorded same timestamp.
- Multiple rows under the same receipt reference do not, alone, prove double receipt. Seek source invoice and compare line items.

## Distinct historical issues
| Store | Input | Fractional opening count rows | Fractional usage rows | Fractional receipt quantity rows | Fractional physical count rows |
| --- | --- | ---: | ---: | ---: | ---: |
| NDAYENI | Ham | 14 | 8 | 0 | 0 |
| NDAYENI | Bacon | 10 | 8 | 0 | 0 |
| SIVANA | Ham | 0 | 1 | 0 | 0 |
| SIVANA | Bacon | 5 | 1 | 0 | 1 |

## Safeguards to implement after backup and tests
1. For HAM RAW-012 and BACON RAW-013, canonical inventory quantity is integer *slices* (EA).
2. Receipt capture must require purchase-unit and canonical slice count; if external unit is KG or pack, a documented per-line conversion must be supplied, not inferred.
3. Reject blank supplier/invoice evidence for retrospective entries. For new receipts, preserve invoice ID and line ID separately so two legitimate line items can share an invoice reference.
4. Reject fractional canonical slice quantities on NEW receipts, physical counts, transfers, stock recipes and adjustments; preserve older fractional records for audit.
5. Record original source quantity, original unit, conversion details, actor, approval and timestamp on new transactions.
6. Flag ambiguous legacy KG entries for document review; do not convert or delete them in bulk.
7. Compute historical sales usage using immutable sale-time recipe snapshots, not current recipes.
8. Reconcile stock against a timestamped physical slice count before manager-authorised corrective entry.

## Owner confirmation still required
Were the legacy Sept 5 and 9 ham entries 6, 20 and 12 individual slices, or was KG deliberate? Do not decide based only on the R80 cost. Exact source invoices/stock count evidence will be needed.

No live POS changes, no paid branch, no deployment, no stock adjustments.
