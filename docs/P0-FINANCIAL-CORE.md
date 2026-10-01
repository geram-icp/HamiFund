# HamiFund ? P0 Financial Core Contract

## Purpose

Define the authoritative financial-domain entities
before implementation.

## Account

Represents a financial relationship inside HamiFund.

Core fields:

- account_id
- identity_ref
- account_kind
- status
- base_currency
- created_at
- updated_at
- version
- audit_ref

Account is not a wallet.

## Capital

Represents capital available or committed
within a defined financial context.

Core fields:

- capital_id
- account_ref
- amount
- currency
- capital_type
- status
- source_ref
- effective_at
- version
- audit_ref

Capital movements must be represented through
authorized financial events.

## Investment

Represents an approved financial commitment
to an opportunity, asset or fund.

Core fields:

- investment_id
- investor_account_ref
- target_ref
- investment_type
- committed_amount
- currency
- status
- approval_ref
- effective_at
- version
- audit_ref

Investment is not a Position.

## Position

Represents an economic holding resulting from
an investment or allocation.

Core fields:

- position_id
- account_ref
- investment_ref
- asset_ref
- quantity
- cost_basis
- currency
- status
- effective_at
- version
- audit_ref

Position may change through authorized events.

## Portfolio

Groups positions under a defined investment context.

Core fields:

- portfolio_id
- owner_ref
- portfolio_type
- base_currency
- position_refs
- status
- valuation_ref
- version
- audit_ref

Portfolio value is derived from positions and
valuation data.

## Fund

Represents a managed financial structure.

Core fields:

- fund_id
- name
- structure_type
- base_currency
- status
- policy_ref
- governance_ref
- valuation_policy_ref
- version
- audit_ref

Fund rules must not be embedded inside individual
transaction records.

## NAV Snapshot

Represents a point-in-time valuation of a fund
or portfolio.

Core fields:

- nav_id
- target_ref
- gross_value
- liabilities
- net_value
- unit_value
- currency
- valuation_at
- methodology_ref
- status
- version
- audit_ref

NAV is a valuation snapshot, not a mutable account balance.

## Transaction

Represents a financial command/result reference
within the financial domain.

Core fields:

- transaction_id
- transaction_type
- source_account_ref
- destination_account_ref
- asset_ref
- amount
- currency
- status
- event_ref
- settlement_ref
- correlation_id
- idempotency_key
- created_at
- version
- audit_ref

A Transaction does not replace the authoritative
Financial Event or Ledger Entry.

## Relationships

Identity
? Account

Account
? Capital

Account
? Investment

Investment
? Position

Position
? Portfolio

Fund
? Portfolio / Investment

Portfolio
? NAV Snapshot

Transaction
? Financial Event
? Ledger Entry
? Settlement

## Financial Invariants

1. Account is not Wallet.
2. Investment is not Position.
3. Position is not Portfolio.
4. NAV is not Balance.
5. Transaction is not Ledger.
6. No financial mutation bypasses Event/Ledger rules.
7. Every financial mutation has an authorized actor.
8. Monetary calculations use deterministic representation.
9. Financial state transitions follow explicit state machines.
10. Historical financial records remain auditable.

## Ownership Boundary

A financial reference does not by itself establish
legal ownership of an underlying real asset.

Legal title, economic entitlement and custody must be
defined by their respective contracts and jurisdictions.

## External Asset Boundary

External assets may be referenced through:

- asset_ref
- opportunity_ref
- rights_ref
- verification_ref
- valuation_ref

External systems do not become authoritative
HamiFund financial state.

## Implementation Rule

Financial Core must remain independent from:

- GERAM implementation
- Marketplace implementation
- Wallet implementation
- Chain implementation
- Oracle implementation
- AI implementation
