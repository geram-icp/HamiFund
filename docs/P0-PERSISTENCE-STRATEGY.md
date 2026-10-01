# HamiFund ? P0 Persistence & Storage Strategy

## Purpose

Define authoritative storage, projections, snapshots,
external references, and recovery boundaries before implementation.

## Source of Truth

Authoritative financial history:

- Financial Events
- Ledger Entries
- Audit Events
- Reconciliation Records

These records are append-oriented and must not be silently overwritten.

## Derived State

The following are projections and may be rebuilt:

- Account Balance
- Available Capital
- Portfolio Position
- Portfolio Value
- Treasury Balance
- Liquidity Position
- Risk Exposure
- Marketplace Status
- Opportunity Status

Projection data is never treated as the authoritative financial history.

## Event Storage

Every financial event contains:

- event_id
- event_type
- event_version
- aggregate_id
- actor
- timestamp
- correlation_id
- idempotency_key
- payload
- source
- metadata

Rules:

1. Events are immutable.
2. Events are uniquely identifiable.
3. Event versions are explicit.
4. Events can be replayed.
5. Invalid events are never silently converted into valid events.

## Ledger Storage

Ledger entries contain at minimum:

- ledger_entry_id
- event_id
- account_id
- asset_id
- amount
- direction
- currency
- timestamp
- reference

Rules:

1. Ledger is append-oriented.
2. Historical entries are never silently edited.
3. Corrections use explicit compensating entries.
4. Every financial ledger entry references an event.
5. Ledger integrity can be independently audited.

## Projection Strategy

Projection flow:

Financial Event
? Ledger Update
? Projection Update
? Audit

A projection failure must not destroy the authoritative event.

Projections must support:

- rebuild
- replay
- version migration
- consistency checking

## Snapshot Strategy

Snapshots may be used for:

- GERAM Opportunity
- Verification
- Valuation
- Risk
- External Marketplace State
- External Provider State

Each snapshot includes:

- snapshot_id
- source_ref
- source_version
- captured_at
- valid_from
- valid_until
- status
- checksum/reference

Snapshots are references to external state,
not replacements for authoritative HamiFund financial history.

## On-Chain / Off-Chain Boundary

On-chain storage may contain:

- identifiers
- ownership references
- transaction references
- hashes
- public metadata
- digital asset state
- settlement proofs where appropriate

Off-chain storage may contain:

- sensitive documents
- KYC information
- private financial information
- detailed valuation models
- confidential contracts
- internal risk analysis
- operational data

Sensitive information must not be placed on a public chain
unless explicitly permitted by applicable policy and legal requirements.

## External Data

External data is stored as:

Reference
+ Source
+ Version
+ Timestamp
+ Status
+ Integrity Reference

External systems do not become HamiFund authoritative state.

## Backup

Backup must cover:

- Financial Events
- Ledger Entries
- Audit Events
- Reconciliation Records
- Critical Configuration
- Required Encryption/Key Metadata

Backups must be:

- versioned
- integrity checked
- access controlled
- recoverable
- periodically tested

## Recovery

Recovery sequence:

1. Restore authoritative event/ledger data.
2. Validate integrity.
3. Rebuild projections.
4. Restore external references/snapshots.
5. Reconcile external systems.
6. Run consistency checks.
7. Re-enable restricted operations.

## Data Integrity

Integrity mechanisms may include:

- checksums
- event hashes
- sequence validation
- duplicate detection
- idempotency records
- reconciliation checks
- projection consistency checks

## Retention

Retention policies must distinguish:

- financial records
- audit records
- legal/compliance records
- personal data
- operational logs
- temporary/cache data

Deletion of data must never silently destroy
legally or financially required history.

## Storage Invariants

1. Ledger is not a mutable balance table.
2. Projection is not the source of truth.
3. External state is not authoritative Core state.
4. Snapshot is not ownership.
5. Cache loss must not cause financial loss.
6. Projection loss must be recoverable.
7. Financial history must remain auditable.
8. Recovery must include reconciliation.
9. Sensitive data must have explicit storage boundaries.
10. Storage technology may change without changing Core business rules.
