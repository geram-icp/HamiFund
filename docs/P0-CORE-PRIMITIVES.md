# HamiFund ? P0 Core Primitives

## Purpose

Define shared primitives used by Core entities, commands,
events, ledger records and adapters.

## Identifier

Every major entity has a stable unique identifier.

Required properties:

- unique
- immutable
- namespace-aware
- externally referenceable
- collision resistant

Examples:

- ACC-*
- CAP-*
- INV-*
- POS-*
- PORT-*
- EVT-*
- LED-*
- ORD-*
- SET-*
- OPP-*
- DAS-*

## Version

Every externally meaningful contract is versioned.

Format:

major.minor

Rules:

- major = breaking change
- minor = backward-compatible extension
- old versions remain readable during migration
- adapters declare supported versions

## Timestamp

All authoritative records contain timestamps.

Required concepts:

- created_at
- updated_at
- effective_at
- recorded_at

Financial events must preserve both:

- effective time
- recorded time

## Correlation

Every distributed operation may carry:

- correlation_id
- causation_id

Correlation identifies the business workflow.
Causation identifies the event or command that caused another event.

## Idempotency

Sensitive commands require:

- idempotency_key
- actor
- command_type
- request_hash
- result_reference
- created_at
- expiration/status

Rules:

1. Same key + same request must not execute twice.
2. Same key + different request must be rejected.
3. Completed requests return the original result.
4. Idempotency records survive retries.
5. Financial mutation must never depend on client retry behavior.

## External Reference

External identifiers are represented as:

- provider
- external_id
- external_type
- version
- captured_at

External references are not Core identifiers.

## Ownership Reference

Ownership is represented by an explicit reference.

Ownership reference does not automatically imply:

- wallet ownership
- legal title
- financial entitlement

The meaning of ownership must be defined by the relevant domain contract.

## Status

Statuses are domain-specific.

Generic statuses must not replace explicit state machines.

Each state transition must be validated against
the state machine of that entity.

## Monetary Value

Monetary values must contain:

- amount
- currency
- precision/scale
- valuation timestamp where applicable

Floating-point arithmetic must not be used for authoritative
financial calculations.

## Audit Reference

Major entities may reference:

- audit_ref
- created_by
- updated_by

Financial events and ledger records require stronger
audit linkage defined by the Event/Ledger contract.

## Contract Rules

1. Shared primitives contain no domain business rules.
2. Core modules may depend on primitives.
3. Primitives must not depend on external adapters.
4. Primitive identifiers are not external provider IDs.
5. Time must be explicit.
6. Version must be explicit at contract boundaries.
7. Sensitive commands must carry idempotency data.
8. Financial amounts must use deterministic representation.
