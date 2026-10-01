# P0-C23 ? Digital Asset & Marketplace Core Contract

## Purpose

Define the HamiFund-native Digital Asset and Marketplace domain independently from any specific marketplace, blockchain, wallet or token standard.

Core flow:

`Opportunity -> Defined Rights -> Digital Asset -> Listing / Offer -> Transfer -> Settlement`

A Digital Asset is a digital representation of defined rights or economic references.

It is not automatically the underlying real asset, legal title, investment, or financial account.

## Digital Asset

Minimum fields:

- digital_asset_id
- opportunity_ref
- asset_reference
- rights_reference
- issuer_ref
- ownership_ref
- metadata_ref
- collection_ref
- asset_type
- status
- version
- created_at
- updated_at
- audit_ref

## Digital Asset Meaning

A Digital Asset may represent:

- a defined economic right
- a participation right
- a contractual right
- a claim/reference
- an investment-related digital representation
- another explicitly defined right approved by policy

The meaning and legal/economic scope of the Digital Asset must be explicit.

A token identifier alone does not define legal ownership or economic entitlement.

## Asset Boundary

The following are distinct:

`Real Asset != Opportunity != Right != Digital Asset != Investment != Position`

A Digital Asset may reference:

- underlying asset
- project
- opportunity
- legal/economic rights
- verification
- valuation
- risk
- external chain record

These references do not automatically transfer the underlying real asset.

## Metadata

Minimum metadata reference:

- metadata_id
- asset_ref
- schema_version
- title
- description_ref
- category
- jurisdiction
- source_ref
- integrity_ref
- created_at
- updated_at
- version

Sensitive documents should remain outside public blockchain storage unless explicitly permitted.

Public or on-chain metadata should contain only information appropriate for that environment.

## Collection

Minimum fields:

- collection_id
- name
- description_ref
- issuer_ref
- policy_ref
- metadata_schema_ref
- status
- version
- created_at
- updated_at
- audit_ref

A Collection groups compatible Digital Assets.

Collection membership does not establish ownership.

## Digital Asset Lifecycle

`Draft -> Defined -> Issued -> Active -> Frozen -> Transferred -> Retired`

Rules:

1. Draft assets cannot be publicly traded.
2. Defined assets must have valid required references.
3. Issuance requires explicit authorization.
4. Frozen assets cannot undergo restricted transfers.
5. Transfer requires authorization and required settlement conditions.
6. Retired assets cannot be reused.
7. Invalid state transitions are rejected.
8. Every material transition is auditable.

## Issuance

Issuance requires:

- valid Digital Asset definition
- valid rights reference
- valid issuer authorization
- applicable governance policy
- required verification
- metadata integrity
- idempotency protection
- audit evidence

Issuance does not itself move financial capital.

## Ownership Reference

Ownership reference fields may include:

- owner_ref
- ownership_type
- effective_at
- source_ref
- version

Ownership semantics must be defined by the governing legal/financial structure.

A wallet address is not automatically the legal owner.

## Listing

Minimum fields:

- listing_id
- digital_asset_ref
- seller_ref
- marketplace_ref
- price
- currency
- expiration
- status
- external_listing_ref
- idempotency_key
- correlation_id
- created_at
- updated_at
- version
- audit_ref

Listing lifecycle:

`Draft -> Active -> Paused -> Sold -> Cancelled -> Expired`

Rules:

1. Listing requires an eligible Digital Asset.
2. Seller authorization must be validated.
3. Price and currency are explicit.
4. Listing does not transfer ownership.
5. External marketplace IDs remain references.
6. Listing mutations are idempotent.
7. Marketplace failure cannot corrupt Core state.

## Offer

Minimum fields:

- offer_id
- digital_asset_ref
- buyer_ref
- marketplace_ref
- price
- currency
- expiration
- status
- external_offer_ref
- idempotency_key
- correlation_id
- created_at
- updated_at
- version
- audit_ref

Offer lifecycle:

`Created -> Open -> Accepted -> Rejected -> Cancelled -> Expired`

An accepted Offer is not necessarily completed ownership transfer.

Transfer and settlement must still satisfy applicable conditions.

## Transfer

Minimum fields:

- transfer_id
- digital_asset_ref
- from_ref
- to_ref
- transfer_type
- authorization_ref
- external_transfer_ref
- settlement_ref
- status
- idempotency_key
- correlation_id
- created_at
- completed_at
- version
- audit_ref

Transfer lifecycle:

`Initiated -> Authorized -> Processing -> Confirmed -> Reconciled`

Failure states:

`Rejected -> Failed -> Reversed`

Transfer rules:

1. Sender authorization is required.
2. Receiver eligibility is validated where required.
3. Asset status must permit transfer.
4. Applicable settlement conditions must be satisfied.
5. Transfer is not complete until confirmation.
6. External transfer references are not authoritative by themselves.
7. Transfer is idempotent.
8. Transfer creates auditable financial/event evidence where applicable.

## Settlement

Minimum fields:

- settlement_id
- transfer_ref
- payment_reference
- amount
- currency
- settlement_provider_ref
- status
- reconciliation_ref
- idempotency_key
- correlation_id
- created_at
- completed_at
- version
- audit_ref

Settlement lifecycle:

`Created -> Pending -> Processing -> Confirmed -> Reconciled`

Failure states:

`Failed -> Disputed`

Settlement is separate from marketplace listing.

Settlement is also separate from the authoritative HamiFund ledger.

External settlement must be reconciled before it is treated as confirmed financial completion.

## Marketplace Activity

Minimum fields:

- activity_id
- marketplace_ref
- digital_asset_ref
- activity_type
- external_activity_ref
- external_timestamp
- observed_at
- payload_ref
- status
- version
- integrity_ref

Examples:

- ListingCreated
- ListingCancelled
- OfferCreated
- OfferAccepted
- TransferInitiated
- TransferConfirmed
- SettlementConfirmed

External activity is evidence/reference data until validated and mapped into HamiFund state.

## Marketplace Boundary

The Marketplace layer may:

- create listing requests
- create offer requests
- receive marketplace activity
- request transfers
- request settlement confirmation
- synchronize external state

The Marketplace layer may not:

- directly modify authoritative balances
- directly rewrite the ledger
- bypass authorization
- establish legal ownership independently
- approve investments
- bypass risk or governance controls

## Adapter Boundary

Marketplace implementations connect through:

`Marketplace Adapter -> Marketplace Contract -> HamiFund Core`

Possible external implementations include:

- ICP marketplace
- EVM marketplace
- institutional marketplace
- private marketplace
- future marketplace implementation

The Core must not import implementation-specific marketplace types.

## External Marketplace Reference

Every external marketplace object should preserve:

- provider
- external_id
- external_type
- external_version
- captured_at
- status
- integrity_ref

External IDs must never replace HamiFund Core IDs.

## Pricing

Marketplace price must contain:

- amount
- currency
- pricing_timestamp
- pricing_source where applicable

Implicit currency conversion is forbidden.

If conversion is required, the conversion source, rate and timestamp must be explicit.

## Financial Boundary

Marketplace activity does not automatically create financial state.

Financial mutation follows:

`Command -> Authorization -> Financial Event -> Ledger -> Projection -> Audit`

A marketplace event may trigger a HamiFund command, but cannot bypass this flow.

## Ownership Boundary

The following are distinct:

`Listing != Offer != Transfer != Settlement != Legal Ownership`

A marketplace listing does not prove ownership.

An external transfer confirmation does not automatically establish legal title unless the applicable legal/financial structure explicitly gives it that meaning.

## Risk Boundary

Marketplace operations may be subject to:

- liquidity limits
- counterparty limits
- concentration limits
- transfer restrictions
- jurisdiction restrictions
- settlement risk
- technology risk
- fraud/security controls

Risk Engine provides risk information.

Governance determines applicable response.

Marketplace Core cannot override Risk or Governance.

## Emergency Controls

Governance may impose:

- marketplace freeze
- asset freeze
- listing freeze
- offer freeze
- transfer freeze
- settlement freeze

Emergency actions must be:

- authorized
- explicit
- auditable
- reversible only under defined policy

## Idempotency

Sensitive operations must carry:

- idempotency_key
- actor_ref
- command_type
- request_hash
- correlation_id

Same key + same request:

`Return original result`

Same key + different request:

`Reject`

Retry must never create duplicate listing, offer, transfer or settlement.

## Reconciliation

External marketplace state must be periodically compared with HamiFund state.

Examples:

- Core listing vs external listing
- Core offer vs external offer
- Core transfer vs external transfer
- Core settlement vs provider settlement

Differences create explicit reconciliation cases.

No silent correction is permitted.

## AI Boundary

AI may:

- analyze marketplace activity
- detect anomalies
- analyze pricing
- identify suspicious patterns
- summarize marketplace conditions
- provide decision support

AI may not independently:

- authorize transfers
- approve investments
- modify ownership
- alter the ledger
- bypass risk controls
- override governance

## Core Invariants

1. Digital Asset is not the underlying Real Asset.
2. Digital Asset is not automatically legal ownership.
3. Digital Asset is not an Investment.
4. Listing is not ownership transfer.
5. Offer is not completed settlement.
6. Transfer is not complete without required confirmation.
7. Settlement is independently reconciled.
8. Marketplace cannot directly mutate authoritative financial state.
9. External IDs remain references.
10. Sensitive marketplace operations are idempotent.
11. Marketplace failure cannot corrupt Core state.
12. Every material marketplace state change is auditable.
13. Governance and risk controls cannot be bypassed.
14. AI has no independent financial authority.
