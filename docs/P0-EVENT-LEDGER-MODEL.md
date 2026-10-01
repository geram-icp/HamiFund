# HamiFund ? P0 Event & Ledger Model

## Financial Flow

Command
? Validation
? Authorization
? Financial Event
? Ledger Entry
? State Projection
? Audit
? Reconciliation

## Command

A command requests a state-changing operation.

Examples:
Deposit
Allocate
Invest
Redeem
Transfer
Settle
Distribute
Reinvest

A command must contain:
- command_id
- actor
- timestamp
- correlation_id
- idempotency_key
- payload

## Financial Event

An accepted business fact.

Examples:
DepositAuthorized
CapitalAllocated
InvestmentExecuted
RedemptionApproved
TransferExecuted
SettlementConfirmed
DistributionPosted

Event rules:
- immutable
- uniquely identified
- versioned
- auditable

## Ledger Entry

Financial effect of an event.

Minimum fields:
- ledger_entry_id
- event_id
- account_id
- asset_id
- amount
- direction
- currency
- timestamp
- reference

Ledger entries are append-oriented.

## Projection

Derived current state.

Examples:
Account balance
Portfolio position
Treasury balance
Available liquidity

Projection can be rebuilt from authoritative events/ledger.

## Reconciliation

Compares:
Internal Ledger
vs
External Settlement / Ledger / Provider

Differences create reconciliation cases.

## Audit Event

Records:
- actor
- action
- target
- result
- timestamp
- correlation_id
- source
- reason

## Core Invariants

1. No financial mutation without an authorized command.
2. Every accepted financial command creates an event.
3. Ledger entries are never silently overwritten.
4. Idempotency prevents duplicate financial execution.
5. External settlement is reconciled separately.
6. Projection is not the financial source of truth.
7. Audit data is retained independently.
