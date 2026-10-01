# HamiFund ? P0 Marketplace Adapter Contract

## Purpose

Connect HamiFund Digital Assets to external marketplaces
without coupling Core to a specific marketplace.

## Digital Asset Input

- digital_asset_id
- underlying_asset_ref
- rights_ref
- metadata_ref
- issuer_ref
- ownership_ref
- status
- version

## Listing

Request:
- listing_id
- digital_asset_id
- marketplace_ref
- seller_ref
- price
- currency
- expiration
- idempotency_key

Result:
- external_listing_id
- status
- external_reference
- timestamp

## Offer

Request:
- offer_id
- digital_asset_id
- buyer_ref
- price
- currency
- expiration
- idempotency_key

Result:
- external_offer_id
- status
- external_reference

## Transfer

Request:
- transfer_id
- digital_asset_id
- from_ref
- to_ref
- external_reference
- idempotency_key

Result:
- status
- transaction_reference

## Settlement

Request:
- settlement_id
- transfer_id
- payment_reference
- amount
- currency

Result:
- status
- settlement_reference
- reconciliation_reference

## Adapter Operations

createListing
cancelListing
createOffer
cancelOffer
acceptOffer
executeTransfer
confirmSettlement
getListing
getOffer
getAsset
syncActivity

## Rules

1. Marketplace implementation stays outside Core.
2. Every operation is versioned.
3. Every mutation is idempotent.
4. External IDs are stored as references.
5. Marketplace failure does not corrupt Core state.
6. Listing does not equal ownership.
7. Transfer is not complete until confirmed.
8. Settlement is reconciled independently.
9. Marketplace events are mapped to HamiFund events.
10. Adapter never bypasses authorization or ledger rules.
