# P0-C22 ? Opportunity Engine Contract

## Purpose

The Opportunity Engine converts an externally referenced real-asset/project opportunity into a versioned, auditable HamiFund investment-readiness representation.

Core chain:

`Opportunity -> Verification -> Valuation -> Risk -> Investment Readiness`

The engine does not establish legal ownership, approve an investment, or guarantee financing or return.

## Opportunity

Minimum fields:

- opportunity_id
- title
- category
- jurisdiction
- external_asset_ref
- external_project_ref
- rights_ref
- verification_ref
- status
- owner_ref
- created_at
- updated_at
- version
- audit_ref

An Opportunity is a HamiFund representation of a potential investment target.

It is not an Investment, Position, Digital Asset, or legal title.

## Asset Reference

- asset_reference_id
- external_provider
- external_asset_id
- asset_type
- source_version
- captured_at
- status
- integrity_ref

External asset identifiers remain references and never become authoritative HamiFund ownership records.

## Rights Reference

- rights_reference_id
- external_provider
- external_right_id
- right_type
- beneficiary_ref
- scope_ref
- effective_from
- effective_until
- source_version
- captured_at
- status

A rights reference describes the externally supplied economic/legal-right context.

It does not by itself establish legal title inside HamiFund.

## Verification Snapshot

- verification_snapshot_id
- opportunity_ref
- verification_ref
- verification_status
- verification_method
- verification_version
- verified_at
- valid_until
- source_ref
- integrity_ref
- status

Verification is time-bound and source-specific.

An expired or revoked verification must not silently remain current.

## Valuation Snapshot

- valuation_snapshot_id
- opportunity_ref
- valuation_ref
- valuation_status
- valuation_method
- valuation_value
- currency
- valuation_at
- valid_until
- source_ref
- methodology_ref
- confidence_ref
- version

A valuation is a snapshot, not permanent truth.

Methodology, source, time and uncertainty must remain visible.

## Risk Snapshot

- risk_snapshot_id
- opportunity_ref
- risk_ref
- risk_status
- risk_level
- risk_version
- assessed_at
- valid_until
- methodology_ref
- source_ref
- status

Risk information is time-sensitive and must expose stale/expired state.

## Investment Readiness

- readiness_id
- opportunity_ref
- readiness_status
- required_capital
- capital_currency
- economic_model_ref
- legal_structure_ref
- data_room_ref
- verification_snapshot_ref
- valuation_snapshot_ref
- risk_snapshot_ref
- readiness_score_ref
- assessed_at
- valid_until
- version
- audit_ref

Suggested readiness states:

`Incomplete -> UnderReview -> Verified -> InvestmentReady -> Published -> Suspended -> Closed`

InvestmentReady means the required HamiFund readiness conditions have been satisfied for review/processing.

It does not mean an investment is approved or capital is guaranteed.

## Opportunity Lifecycle

`Draft -> PendingReview -> Verified -> InvestmentReady -> Published -> Suspended -> Closed`

Rules:

1. No arbitrary status jump.
2. Each transition requires an authorized command.
3. Verification, valuation and risk evidence must meet applicable validity requirements.
4. Suspended opportunities cannot enter restricted investment flows.
5. Closed opportunities are terminal unless an explicit reopening policy exists.
6. Every material transition is auditable.

## Readiness Rules

An Opportunity may be considered InvestmentReady only when applicable required evidence exists, including:

- valid identity/ownership references
- required project/asset documentation
- valid verification snapshot
- current valuation snapshot where required
- current risk snapshot where required
- defined economic model
- defined legal/financial structure reference
- required data-room references
- required governance/policy checks

Missing, stale, contradictory or invalid evidence prevents readiness unless an explicit policy permits an exception with documented approval.

## GERAM Boundary

GERAM information enters through the versioned GERAM Adapter and contract.

HamiFund may store:

- external opportunity/project/asset IDs
- certificate and verification references
- valuation and risk snapshots
- source/version/timestamp/integrity references

HamiFund must not import GERAM internal Motoko types or depend on GERAM `main.mo`.

A GERAM outage must not erase or corrupt an already stored valid HamiFund snapshot.

## Decision Boundary

Opportunity Engine may:

- normalize opportunity data
- validate completeness
- track evidence
- compare readiness requirements
- detect stale data
- assemble investment-readiness views
- generate decision-support signals

Opportunity Engine does not independently:

- approve investments
- move money
- alter the authoritative ledger
- establish legal ownership
- guarantee financing or return
- override governance policy

## Evidence Freshness

Every verification, valuation and risk snapshot must expose validity information.

If evidence is stale, expired, revoked or unavailable:

- status must reflect that condition
- readiness must be recalculated where applicable
- the stale condition must be auditable
- the system must not silently present the evidence as current

## Relationship to Investment

`Opportunity != Investment`

An Opportunity becomes an Investment only through the separately governed investment lifecycle:

`Proposed -> PendingApproval -> Approved -> Executing -> Active -> Suspended -> Closed -> Settled`

Opportunity readiness is an input to investment decision-making, not the decision itself.

## Relationship to Digital Asset

`Opportunity != Digital Asset`

A Digital Asset may reference an Opportunity when a separately defined right or economic representation is eligible for issuance.

Issuance requires its own authorization, policy and lifecycle.

## Relationship to Risk

Risk snapshots inform readiness and investment decision support.

Risk Engine remains responsible for risk assessment.

Opportunity Engine must not rewrite authoritative risk history.

## Audit Requirements

Material actions must preserve:

- actor
- action
- target
- timestamp
- correlation_id
- command_ref
- source_ref
- previous_status
- new_status
- result
- reason

## Core Invariants

1. Opportunity is not Investment.
2. Opportunity is not legal ownership.
3. External references are not authoritative Core IDs.
4. Verification is time-bound.
5. Valuation is a snapshot.
6. Risk data is time-sensitive.
7. InvestmentReady does not mean investment approval.
8. Readiness cannot silently ignore stale or missing evidence.
9. Opportunity data cannot mutate the authoritative ledger.
10. Every material readiness/status decision is auditable.
11. GERAM remains outside HamiFund Core.
12. External failure cannot corrupt stored HamiFund state.
