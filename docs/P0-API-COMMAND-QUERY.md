# P0-C25 ? API Command / Query Boundary

## Purpose

Define the external API boundary of HamiFund.

The API exposes commands and queries without owning Core business rules, financial authority, ledger history or authoritative balances.

Core flow:

`API -> Command/Query -> Validation -> Authorization -> Core -> Event/Ledger -> Projection`

## API Principles

1. API is a boundary, not the business engine.
2. Commands represent requested state changes.
3. Queries read derived or explicitly queryable state.
4. API cannot directly mutate authoritative financial state.
5. API cannot bypass Governance.
6. API cannot bypass Risk controls.
7. API cannot write Ledger entries directly.
8. API cannot directly modify balances.
9. Every sensitive command carries correlation and idempotency data.
10. External API versions are explicit.

## Command

Minimum fields:

- command_id
- command_type
- actor_ref
- target_ref
- payload_ref
- timestamp
- correlation_id
- causation_id
- idempotency_key
- api_version
- command_version

Examples:

- CreateAccount
- DepositCapital
- AllocateCapital
- ProposeInvestment
- ApproveInvestment
- ExecuteInvestment
- RequestRedemption
- ExecuteTransfer
- CreateListing
- CreateOffer
- ExecuteMarketplaceTransfer
- ConfirmSettlement
- RequestDistribution
- ReinvestDistribution
- MoveTreasury

A command is a request.

A command is not evidence that execution occurred.

## Command Lifecycle

`Received -> Validated -> Authorized -> Executing -> Completed`

Failure states:

`Rejected -> Failed -> Cancelled`

A command may not enter execution without required validation and authorization.

## Command Processing

The command path is:

`API Request`
`-> Input Validation`
`-> Identity Resolution`
`-> Authorization`
`-> Policy Check`
`-> Limit Check`
`-> Compliance Check`
`-> Risk Check where applicable`
`-> Idempotency Check`
`-> Core Execution`
`-> Financial Event where applicable`
`-> Ledger where applicable`
`-> Projection`
`-> Audit`
`-> API Response`

The exact checks depend on command type.

## Query

Minimum fields:

- query_id
- query_type
- actor_ref
- target_ref
- parameters_ref
- timestamp
- correlation_id
- api_version
- query_version

Examples:

- GetAccount
- GetAccountBalance
- GetPortfolio
- GetPosition
- GetNAV
- GetInvestment
- GetOpportunity
- GetRiskAssessment
- GetDigitalAsset
- GetListing
- GetOffer
- GetSettlement
- GetTransactionHistory
- GetTreasuryPosition
- GetAuditRecord

Queries do not mutate authoritative state.

## Query Boundary

Queries may read:

- projections
- approved snapshots
- validated external references
- marketplace state
- opportunity state
- risk views
- valuation views
- audit views according to access policy

Queries must not:

- create financial events
- create ledger entries
- alter balances
- approve operations
- execute transfers
- change ownership
- modify governance

## Balance Query

An API balance is a projection.

It is not the authoritative source of financial history.

Authoritative financial evidence remains:

`Financial Events + Ledger Entries`

A balance query must expose appropriate:

- account_ref
- asset/currency
- available_amount
- reserved_amount where applicable
- as_of
- projection_version

## API Authorization

Every protected API request resolves:

`Actor -> Identity -> Role -> Permission -> Policy -> Authorization Decision`

Default:

`No authorization -> Deny`

The API must not infer permission from:

- URL access
- wallet possession
- marketplace identity
- external provider role
- AI recommendation
- previous successful request

## API Authentication vs Authorization

Authentication establishes who is making the request.

Authorization determines whether that actor may perform the requested operation.

These are separate controls.

## Idempotency

Sensitive API commands require:

- idempotency_key
- actor_ref
- command_type
- request_hash
- correlation_id

Rules:

Same key + same request:

`Return original result`

Same key + different request:

`Reject`

Retries must not duplicate:

- deposits
- allocations
- transfers
- investments
- redemptions
- settlements
- distributions
- listings
- offers
- digital-asset issuance

## Correlation

Every request should preserve:

- correlation_id
- causation_id where applicable
- command_id
- actor_ref

This allows tracing:

`API Request -> Command -> Event -> Ledger -> Projection -> Audit`

## API Versioning

External API versions must be explicit.

Example:

`/api/v1/...`

A version change must distinguish:

- backward-compatible changes
- breaking changes

Core domain versions and API versions are independent.

An API adapter may translate an older API contract into the current Core command contract.

## Error Boundary

API errors must expose controlled domain results.

Examples:

- Unauthorized
- Forbidden
- InvalidInput
- InvalidState
- LimitExceeded
- ComplianceRejected
- RiskRestriction
- InsufficientFunds
- DuplicateRequest
- StaleData
- ExternalProviderFailure
- SettlementPending
- ReconciliationRequired
- EmergencyRestriction

Internal implementation details and sensitive information must not leak through API errors.

## External Failure

If an external provider fails:

`External Failure -> Controlled Core Result -> Recovery/Reconciliation`

The API must not falsely report financial completion.

Examples:

- marketplace timeout
- payment provider timeout
- chain transaction pending
- oracle unavailable
- GERAM adapter unavailable

The resulting state must distinguish:

- completed
- pending
- failed
- unknown/reconciliation-required

## Pagination

Large query results should use explicit pagination.

Minimum pagination fields:

- cursor
- limit
- next_cursor
- snapshot/reference timestamp where required

Pagination must not silently change the meaning of financial history.

## Query Consistency

Financial and audit queries should expose the relevant:

- as_of timestamp
- projection version
- data status
- freshness indicator where applicable

Stale external data must not silently appear current.

## Sensitive Data

API responses must follow data classification and access policy.

Sensitive information may include:

- identity data
- KYC information
- private financial information
- confidential contracts
- internal risk analysis
- security metadata
- private keys/secrets

Sensitive data must not be exposed merely because an actor can query a related public entity.

## API and Marketplace

Marketplace API requests follow:

`API -> Command -> Authorization -> Marketplace Core -> Adapter`

The API does not call a marketplace provider directly for authoritative state changes.

## API and GERAM

GERAM-related requests follow:

`API -> Opportunity Core -> GERAM Contract/Adapter`

The API does not import GERAM internal types.

GERAM availability does not determine whether already stored valid HamiFund snapshots remain usable.

## API and AI

AI services may be called by Core workflows for decision support.

AI results are inputs, not authorization.

The API cannot convert an AI recommendation into an automatic financial approval unless an explicit governance policy independently authorizes that behavior.

## Read vs Write Boundary

Read path:

`API -> Query -> Authorization -> Projection/View`

Write path:

`API -> Command -> Validation -> Authorization -> Policy/Risk -> Core -> Event -> Ledger -> Projection -> Audit`

The two paths must remain conceptually distinct.

## Direct Mutation Prohibition

The following are forbidden:

`API -> Balance Mutation`

`API -> Ledger Mutation`

`API -> Ownership Mutation`

`API -> Governance Bypass`

`API -> External Provider Direct Mutation`

`API -> AI Authority`

All state-changing operations must pass through the appropriate Core command path.

## Rate Limiting

API protection may include:

- request rate limits
- command rate limits
- account rate limits
- IP/session limits where appropriate
- marketplace operation limits
- authentication failure limits

Rate limiting must not be treated as a substitute for authorization.

## Replay Protection

Sensitive commands should reject:

- reused expired request signatures where applicable
- duplicate command identifiers
- duplicate idempotency keys with different payloads
- expired authorization contexts
- stale approval references

Replay protection must preserve legitimate retry behavior.

## Audit

Material API actions record:

- audit_id
- actor_ref
- endpoint/operation
- command_ref or query_ref
- target_ref
- timestamp
- correlation_id
- authorization_result
- execution_result
- reason
- api_version
- source

Queries may be audited according to data sensitivity and governance policy.

## API Adapter Boundary

External clients may have different formats.

Translation occurs at the boundary:

`External API Contract -> API Adapter -> HamiFund Command/Query Contract`

The Core must not depend on client-specific formats.

## Core Invariants

1. API is not Core business logic.
2. API cannot directly mutate the ledger.
3. API cannot directly mutate authoritative balances.
4. API cannot bypass authorization.
5. API cannot bypass policy.
6. API cannot bypass applicable risk controls.
7. Query does not mutate financial state.
8. Sensitive commands are idempotent.
9. API versions are explicit.
10. External failures cannot be reported as successful financial completion.
11. AI output is not authorization.
12. External provider IDs are not Core IDs.
13. Audit tracing connects API actions to Core events.
14. Financial state changes follow the Command/Event/Ledger flow.
