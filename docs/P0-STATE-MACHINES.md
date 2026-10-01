# HamiFund ? P0 State Machines

## Opportunity

Draft
? PendingReview
? Verified
? InvestmentReady
? Published
? Suspended
? Closed

## Digital Asset

Draft
? Defined
? Issued
? Active
? Frozen
? Transferred
? Retired

## Marketplace Listing

Draft
? Active
? Paused
? Sold
? Cancelled
? Expired

## Offer

Created
? Open
? Accepted
? Rejected
? Cancelled
? Expired

## Investment

Proposed
? PendingApproval
? Approved
? Executing
? Active
? Suspended
? Closed
? Settled

## Deposit

Initiated
? Validating
? Authorized
? Posted
? Reconciled
? Rejected

## Redemption

Requested
? Validating
? Approved
? Queued
? Settling
? Settled
? Rejected
? Cancelled

## Settlement

Created
? Pending
? Processing
? Confirmed
? Reconciled
? Failed

## Financial Event

Proposed
? Validated
? Authorized
? Posted
? Reconciled

## Treasury

Available
? Reserved
? InTransit
? Settled
? Reconciled

## General Rules

1. No arbitrary status jump.
2. Every transition has an authorized command.
3. Invalid transitions return a domain error.
4. Financial transitions produce events.
5. Financial events produce ledger entries where applicable.
6. Settlement must be idempotent.
7. Terminal states cannot be reopened unless explicitly defined.
8. Suspended states block restricted operations.
