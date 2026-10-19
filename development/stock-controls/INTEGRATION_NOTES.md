# Feasterville stock controls — offline integration contract
Status: development only; no live database or POS changes.

This branch contains a Python offline prototype and contract tests. The code is **not** deployed, does not contain database credentials, and must not be treated as a production API.

Current validations:
- timestamped nonnegative physical counts for store and item
- recipes with positive finite quantities and known unique input codes
- manager-signed adjustments with audit metadata
- previous stock controls: transfers, reversals, duplicate movement prevention

Test command from the package folder: `python -m unittest discover -q`

31 tests passed on 19 Oct 2026 locally.

Release blockers: verified database backup/restore, proper manager authentication, production schema and POS JS integration, integration tests using a safe data copy or controlled synthetic data, handling future-dated counts / partial transfers, regressions for payments and cashups. No production deployment permitted yet.