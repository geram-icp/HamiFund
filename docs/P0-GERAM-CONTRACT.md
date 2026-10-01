# HamiFund ? P0 GERAM Adapter Contract

## Purpose

Receive standardized GERAM opportunity information
without importing GERAM internal types or source code.

## Opportunity Snapshot

- opportunity_id
- external_asset_id
- external_project_id
- external_certificate_id
- external_right_id
- external_verification_id
- title
- category
- jurisdiction
- status
- version
- snapshot_at

## Verification Snapshot

- verification_ref
- verification_status
- verification_version
- verified_at
- source_ref

## Valuation Snapshot

- valuation_ref
- valuation_status
- valuation_method
- valuation_value
- currency
- valuation_at

## Risk Snapshot

- risk_ref
- risk_status
- risk_level
- risk_version
- assessed_at

## Investment Readiness

- readiness_status
- required_capital
- capital_currency
- economic_model_ref
- legal_structure_ref
- data_room_ref

## Adapter Operations

getOpportunity
getSnapshot
verifyReference
refreshSnapshot
getAssetReference
getRightsReference
getVerificationReference
getValuationReference
getRiskReference

## Rules

1. No import of GERAM internal Motoko types.
2. No dependency on GERAM main.mo.
3. External IDs remain references.
4. Snapshots are versioned.
5. HamiFund can operate on a valid stored snapshot.
6. Temporary GERAM outage must not destroy HamiFund state.
7. Stale snapshots are detectable.
8. Every refresh is auditable.
9. GERAM data does not automatically authorize investment.
10. Investment requires HamiFund policy, risk and approval.
