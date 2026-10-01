# HamiFund ? P0 Money Engine Contract

## Purpose

Define controlled movement of monetary value through HamiFund.

## Deposit

Represents incoming capital.

Request:

- deposit_id
- account_ref
- amount
- currency
- source_ref
- payment_reference
- idempotency_key
- correlation_id

Lifecycle:

Initiated
? Validating
? Authorized
? Posted
? Reconciled

Failure:

- Rejected
- Failed

A Deposit is not complete until required posting and
reconciliation rules are satisfied.

## Allocation

Moves available capital into an approved financial purpose.

Request:

- allocation_id
- source_account_ref
- target_ref
- amount
- currency
- purpose
- approval_ref
- idempotency_key
- correlation_id

Lifecycle:

Proposed
? Validating
? Authorized
? Posted
? Reconciled

Allocation must not exceed available eligible capital.

## Transfer

Moves financial value between defined accounts or
settlement destinations.

Request:

- transfer_id
- from_ref
- to_ref
- amount
- currency
- asset_ref
- destination_type
- idempotency_key
- correlation_id

Lifecycle:

Initiated
? Validating
? Authorized
? Processing
? Confirmed
? Reconciled

Failure:

- Rejected
- Failed
- Reversed

Transfer completion requires explicit confirmation.

## Redemption

Represents a request to convert an eligible position
or investment into a settlement amount.

Request:

- redemption_id
- account_ref
- position_ref
- requested_amount
- currency
- reason
- idempotency_key
- correlation_id

Lifecycle:

Requested
? Validating
? Approved
? Queued
? Settling
? Settled

Failure:

- Rejected
- Cancelled
- Failed

Redemption must respect:

- eligibility
- liquidity
- lock-up rules
- limits
- risk controls
- applicable policy

## Settlement

Represents completion of an external or internal
financial obligation.

Request:

- settlement_id
- transfer_ref
- payment_reference
- amount
- currency
- settlement_provider_ref
- idempotency_key
- correlation_id

Lifecycle:

Created
? Pending
? Processing
? Confirmed
? Reconciled

Failure:

- Failed
- Disputed

Settlement confirmation does not replace reconciliation.

## Treasury

Represents controlled liquidity and reserve positions.

Core fields:

- treasury_position_id
- asset_ref
- amount
- currency
- availability_status
- reserved_amount
- provider_ref
- updated_at
- version

Lifecycle:

Available
? Reserved
? InTransit
? Settled
? Reconciled

Treasury must maintain visibility into:

- available liquidity
- reserved liquidity
- pending settlement
- settlement exposure

## Money Flow

Deposit
? Available Capital
? Allocation
? Investment / Transfer
? Position / Settlement
? Redemption
? Settlement
? Reconciliation

Alternative:

Deposit
? Treasury
? Allocation
? Investment

## Financial Safety

Every money operation requires:

1. Identity
2. Authorization
3. Validation
4. Policy checks
5. Risk checks where applicable
6. Ledger posting
7. External execution where applicable
8. Reconciliation
9. Audit

## Balance Rule

Balances are projections.

Authoritative history comes from:

Financial Events
+
Ledger Entries

A balance must never be changed directly without
the corresponding financial event and ledger consequence.

## Insufficient Funds

A transaction must be rejected when:

available eligible balance
<
required amount

unless an explicitly authorized credit mechanism applies.

## Currency Rule

Every monetary operation must explicitly define:

- amount
- currency
- precision
- valuation timestamp where applicable

Implicit currency conversion is forbidden.

## Idempotency

All sensitive Money Engine mutations require
idempotency protection.

Same request replay:
? original result

Same key + different request:
? reject

## External Failure

External provider failure must not create a false
successful financial state.

The operation enters a controlled recovery/reconciliation
state.

## Money Engine Invariants

1. Money cannot move without an authorized command.
2. Direct balance mutation is forbidden.
3. Every accepted money mutation produces financial evidence.
4. External settlement requires reconciliation.
5. Failed external operations are recoverable.
6. Currency is always explicit.
7. Insufficient eligible capital blocks execution.
8. Sensitive operations are idempotent.
9. Treasury state is auditable.
10. Historical monetary evidence is never silently deleted.
