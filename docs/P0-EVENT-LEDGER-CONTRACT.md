# HamiFund ? P0 Event & Ledger Contract

## Purpose

Define the authoritative financial event and ledger model.

## Command

A Command requests a state-changing operation.

Core fields:

- command_id
- command_type
- actor_ref
- target_ref
- payload_ref
- timestamp
- correlation_id
- causation_id
- idempotency_key
- version

A Command is a request, not proof that the operation succeeded.

## Command Lifecycle

Proposed
? Validated
? Authorized
? Executed
? Completed

Failure states:

- Rejected
- Failed
- Cancelled

Invalid commands must not produce successful financial events.

## Financial Event

A Financial Event records an accepted business fact.

Core fields:

- event_id
- event_type
- aggregate_id
- aggregate_type
- actor_ref
- timestamp
- effective_at
- correlation_id
- causation_id
- command_ref
- version
- payload_ref
- audit_ref

Examples:

- CapitalDeposited
- CapitalAllocated
- InvestmentApproved
- InvestmentExecuted
- PositionCreated
- PositionAdjusted
- RedemptionApproved
- TransferExecuted
- DistributionPosted
- SettlementConfirmed

## Event Rules

1. Events are immutable.
2. Events are uniquely identifiable.
3. Events are versioned.
4. Events are append-oriented.
5. Events can be replayed.
6. Events contain sufficient references for audit.
7. An event represents an accepted fact, not a request.

## Ledger Entry

A Ledger Entry records the accounting consequence
of an applicable Financial Event.

Core fields:

- ledger_entry_id
- event_ref
- account_ref
- asset_ref
- amount
- currency
- direction
- entry_type
- timestamp
- effective_at
- reference
- version

## Ledger Rules

1. Every applicable financial mutation produces ledger entries.
2. Ledger entries are append-oriented.
3. Historical entries are never silently overwritten.
4. Corrections use compensating entries.
5. Debit/credit or equivalent accounting direction is explicit.
6. Currency is explicit.
7. Amount representation is deterministic.
8. Ledger entries reference their originating event.

## Double-Entry Boundary

Where double-entry accounting is applicable:

One business event may produce multiple ledger entries.

The accounting system must enforce:

Total Debits
=
Total Credits

for each balanced accounting transaction.

The exact chart of accounts is defined separately.

## Projection

A Projection is derived state generated from events and ledger data.

Examples:

- account balance
- available capital
- portfolio position
- treasury balance
- liquidity
- exposure

Projection rules:

1. Projection is not authoritative history.
2. Projection can be rebuilt.
3. Projection failures do not delete events.
4. Projection version is explicit.
5. Rebuild must be deterministic.

## Reconciliation

Reconciliation compares:

Internal Ledger
vs
External Settlement / Provider / Chain / Financial System

Core fields:

- reconciliation_id
- internal_ref
- external_ref
- expected_value
- observed_value
- currency
- status
- difference
- detected_at
- resolved_at
- resolution_ref

Differences create explicit reconciliation cases.

They must not be silently corrected.

## Audit Event

Audit Event records operational evidence.

Core fields:

- audit_id
- actor_ref
- action
- target_ref
- result
- reason
- timestamp
- correlation_id
- source
- command_ref
- event_ref

## Complete Financial Flow

Command
? Validation
? Authorization
? Financial Event
? Ledger Entry
? Projection
? Audit
? Reconciliation

## Failure Boundary

If external execution fails:

Core financial state must not be marked completed.

If ledger posting fails:

The accepted event must remain recoverable
and the operation must enter a controlled failure/recovery state.

If projection fails:

Authoritative events and ledger entries remain intact.

## Idempotency

Financial commands must use idempotency keys.

Repeated requests:

Same key + same payload
? return original result.

Same key + different payload
? reject.

## Core Invariants

1. No financial mutation without an authorized command.
2. Command is not Event.
3. Event is not Ledger Entry.
4. Ledger is not Projection.
5. Projection is rebuildable.
6. External settlement requires reconciliation.
7. Corrections are explicit compensating entries.
8. Historical financial evidence is preserved.
9. Every sensitive operation is auditable.
10. No adapter may bypass this flow.
