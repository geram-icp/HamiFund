# HamiFund ? P0 Risk Engine Contract

## Purpose

Define identification, measurement, monitoring and control
of financial and operational risk.

## Risk Assessment

Core fields:

- risk_assessment_id
- target_ref
- assessment_type
- risk_level
- score_ref
- methodology_ref
- assessed_at
- valid_until
- status
- version

Risk assessment is decision support and does not itself
authorize or reject a transaction.

## Exposure

Measures economic exposure to an asset, issuer,
counterparty, market or other risk dimension.

Core fields:

- exposure_id
- portfolio_ref
- target_ref
- exposure_type
- amount
- currency
- percentage
- measured_at
- version

## Concentration

Measures concentration against defined limits.

Dimensions may include:

- asset
- issuer
- sector
- geography
- currency
- counterparty
- project
- strategy

Concentration checks may produce:

- within_limit
- warning
- limit_breached

A breach must trigger the applicable policy workflow.

## Liquidity

Measures ability to meet obligations.

Core fields:

- liquidity_id
- target_ref
- available_liquidity
- reserved_liquidity
- expected_inflows
- expected_outflows
- liquidity_horizon
- currency
- measured_at
- version

Liquidity analysis must support redemption and
settlement planning.

## Credit Risk

Evaluates ability of a borrower or obligated party
to meet financial commitments.

Core fields:

- credit_assessment_id
- counterparty_ref
- exposure_ref
- assessment_method
- rating_ref
- probability_ref
- loss_estimate_ref
- assessed_at
- valid_until
- version

## Counterparty Risk

Tracks exposure arising from external parties such as:

- financial providers
- custodians
- marketplaces
- settlement providers
- borrowers
- project entities
- technology providers

## Market Risk

May include:

- price risk
- interest-rate risk
- currency risk
- volatility risk
- correlation risk

Market assumptions must be time-stamped and sourced.

## Operational Risk

May include:

- process failure
- human error
- fraud indicators
- system failure
- provider failure
- data integrity failure
- cyber/security events

## Settlement Risk

Measures risk that a financial obligation
is not completed as expected.

Settlement risk must distinguish:

- pending
- delayed
- failed
- disputed
- reconciled

## Technology Risk

May include:

- smart-contract failure
- adapter failure
- dependency outage
- data corruption
- key compromise
- service interruption
- version incompatibility

## Stress Scenario

Represents a defined adverse scenario.

Core fields:

- scenario_id
- target_ref
- scenario_type
- assumptions_ref
- shock_definition
- projected_impact
- currency
- created_at
- version

Examples:

- price shock
- liquidity shock
- currency shock
- redemption surge
- counterparty default
- settlement interruption
- provider outage

## Risk Limits

Limits are governance-controlled rules.

Core fields:

- limit_id
- target_ref
- limit_type
- threshold
- currency_or_unit
- effective_from
- effective_until
- policy_ref
- status
- version

Risk Engine may detect a breach.

Governance/Policy determines the permitted response.

## Risk Decision Boundary

Risk Engine may:

- calculate
- measure
- detect
- alert
- simulate
- recommend

Risk Engine does not independently:

- authorize transactions
- approve investments
- alter the ledger
- override governance
- establish legal ownership

## Risk Flow

Data
? Exposure
? Assessment
? Limit Check
? Alert / Decision Support
? Governance Action
? Audit

## Stale Risk Data

Risk assessments must expose stale or expired data.

Stale risk information must not silently appear current.

## Risk Invariants

1. Risk data is time-sensitive.
2. Risk assessments have explicit validity.
3. Exposure is measurable and auditable.
4. Limits are governance-controlled.
5. Breaches are explicit.
6. Liquidity is monitored separately from accounting balance.
7. Stress tests do not predict certainty.
8. Risk Engine cannot bypass authorization.
9. Risk data does not mutate financial history.
10. Every material risk decision is auditable.
