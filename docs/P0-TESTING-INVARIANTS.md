# P0-C26 ? Testing & Invariant Strategy

## Purpose

Define the testing architecture for HamiFund before production implementation.

Testing must validate:

- domain behavior
- financial correctness
- authorization
- state machines
- event/ledger integrity
- idempotency
- adapter isolation
- marketplace boundaries
- risk boundaries
- governance controls
- failure recovery
- projection rebuildability

A successful compilation is not sufficient evidence of system correctness.

## Testing Layers

HamiFund uses six primary test layers:

1. Unit Tests
2. Integration Tests
3. Contract Tests
4. Invariant Tests
5. Failure / Recovery Tests
6. End-to-End Tests

Each layer has a distinct purpose.

## Unit Tests

Unit tests validate isolated domain behavior.

Targets include:

- identifiers
- state transitions
- monetary calculations
- policy evaluation
- authorization decisions
- limit evaluation
- risk calculations
- valuation calculations
- performance calculations
- yield calculations
- readiness evaluation
- idempotency rules

Unit tests should not require external providers.

## State Machine Tests

Every defined lifecycle must have transition tests.

For each state machine test:

- valid transition -> accepted
- invalid transition -> rejected
- unauthorized transition -> rejected
- terminal state mutation -> rejected
- suspended/frozen restriction -> enforced
- audit evidence -> created where required

State machines include:

- Opportunity
- Digital Asset
- Listing
- Offer
- Investment
- Deposit
- Redemption
- Settlement
- Financial Event
- Treasury
- Approval
- Emergency Control

## Financial Calculation Tests

Authoritative financial calculations must be deterministic.

Test:

- addition
- subtraction
- allocation
- transfer
- redemption
- fees
- valuation
- NAV
- performance
- yield
- distribution
- reinvestment
- currency handling
- rounding/precision

Floating-point arithmetic must not be used for authoritative monetary state.

## Event and Ledger Tests

Test that:

`Command -> Financial Event -> Ledger Entry -> Projection`

behaves consistently.

Verify:

- accepted financial mutation creates required event
- applicable event creates ledger evidence
- ledger entries are append-oriented
- existing entries cannot be silently overwritten
- compensating entries represent corrections
- event references are valid
- projection can be rebuilt

## Double-Entry Tests

Where double-entry accounting applies:

`Total Debits == Total Credits`

Test:

- balanced transaction
- unbalanced transaction rejection
- duplicate entry prevention
- missing account rejection
- invalid currency rejection
- invalid amount rejection
- compensating entry behavior

Not every non-accounting event requires a double-entry ledger entry.

## Projection Tests

For every important projection:

1. Start from known events/ledger.
2. Build projection.
3. Record result.
4. Destroy projection.
5. Rebuild from authoritative history.
6. Compare results.

Expected:

`Original Projection == Rebuilt Projection`

Projection corruption must not corrupt authoritative financial history.

## Idempotency Tests

For every sensitive command:

Test:

`Same Key + Same Request -> Same Result`

and:

`Same Key + Different Request -> Reject`

Also test:

- retry after timeout
- retry after partial external execution
- concurrent duplicate requests
- expired idempotency record
- duplicate command ID
- provider retry

Sensitive operations include:

- deposit
- allocation
- investment
- redemption
- transfer
- settlement
- distribution
- reinvestment
- treasury movement
- digital asset issuance
- marketplace listing
- marketplace offer
- marketplace transfer

## Authorization Tests

Test:

- authorized actor -> allowed
- missing permission -> denied
- expired permission -> denied
- suspended identity -> denied
- policy violation -> denied
- limit breach -> denied
- compliance failure -> denied
- missing approval -> denied
- emergency restriction -> denied

Test that authorization failure causes:

`No Financial Mutation`

## Separation of Duties Tests

Where required:

`Requester != Approver != Executor`

Test:

- valid independent approval
- self-approval rejection
- changed command after approval
- expired approval
- revoked approval
- wrong target approval
- wrong amount approval

## Risk Tests

Test:

- exposure calculation
- concentration calculation
- liquidity calculation
- counterparty assessment
- settlement risk
- technology risk
- risk validity expiration
- limit breach detection
- stale risk detection

Risk Engine must not independently authorize financial operations.

## Opportunity Tests

Test:

- incomplete opportunity
- missing verification
- expired verification
- missing valuation
- stale valuation
- missing risk assessment
- stale risk assessment
- valid InvestmentReady
- invalid InvestmentReady
- suspended opportunity
- closed opportunity

Critical invariant:

`InvestmentReady != InvestmentApproved`

## Digital Asset Tests

Test:

- invalid asset definition
- missing rights reference
- unauthorized issuance
- duplicate issuance
- frozen asset transfer
- retired asset transfer
- valid ownership reference
- invalid ownership reference
- metadata integrity
- lifecycle transitions

Critical invariants:

`Digital Asset != Real Asset`

`Digital Asset != Legal Ownership`

## Marketplace Contract Tests

Each marketplace adapter must pass the same contract suite.

Test:

- create listing
- cancel listing
- create offer
- cancel offer
- accept offer
- transfer
- settlement
- activity synchronization
- external timeout
- external rejection
- duplicate request
- stale external state

A new marketplace implementation should not require Core business-rule changes.

## GERAM Contract Tests

GERAM Adapter tests must verify:

- valid opportunity snapshot
- invalid snapshot
- version mismatch
- stale snapshot
- missing verification
- valuation reference
- risk reference
- refresh
- external outage
- malformed external response

Critical invariant:

`GERAM Adapter Failure != HamiFund Core Corruption`

No GERAM internal Motoko type may enter Core contracts.

## API Tests

Test:

- valid command
- invalid command
- unauthorized command
- duplicate command
- malformed request
- stale request
- API version compatibility
- query authorization
- pagination
- error mapping
- external timeout

Verify:

`Query -> No Mutation`

## Failure and Recovery Tests

Simulate:

- provider timeout
- provider rejection
- chain transaction pending
- chain transaction failure
- payment timeout
- marketplace outage
- GERAM outage
- oracle outage
- projection failure
- partial execution
- duplicate callback
- network retry
- corrupted external response

Expected principle:

`External Failure -> Controlled State -> Recovery/Reconciliation`

Never:

`External Failure -> Silent Financial Completion`

## Reconciliation Tests

Test differences between:

- Core state vs marketplace state
- Core state vs payment provider
- Core state vs chain state
- Core ledger vs settlement
- expected vs observed amount
- expected vs observed status

Differences must create explicit reconciliation cases.

## Security Tests

Test:

- privilege escalation
- unauthorized access
- role confusion
- replay
- duplicate requests
- forged external reference
- invalid ownership reference
- malformed input
- excessive request rate
- emergency bypass attempt
- adapter authorization bypass
- AI authority bypass

## AI Boundary Tests

Verify AI cannot:

- authorize transactions
- approve investments
- modify ledger
- change ownership
- bypass risk
- override governance

AI output must remain:

`Analysis / Signal / Recommendation`

not:

`Authority`

## Property / Invariant Testing

Where practical, use property-based testing for core financial rules.

Examples:

### Conservation

For applicable transfers:

`Source Reduction == Destination Increase + Fees`

### Ledger Balance

For applicable double-entry transactions:

`Debits == Credits`

### Idempotency

Repeated identical command:

`Result(n) == Result(1)`

### Projection

`Replay(Events) == Current Projection`

### State Machine

Every accepted transition must belong to the defined transition graph.

### Authorization

Unauthorized command:

`Financial State After == Financial State Before`

## Security and Financial Invariants

The following invariants must have automated tests:

1. No unauthorized financial mutation.
2. No direct balance mutation.
3. No silent ledger overwrite.
4. No duplicate execution from retry.
5. No invalid state transition.
6. No governance bypass.
7. No risk bypass.
8. No AI authority.
9. No adapter direct financial mutation.
10. No external failure causing false completion.
11. No projection corruption of authoritative history.
12. No implicit currency conversion.
13. No stale evidence presented as current.
14. No marketplace listing treated as ownership.
15. No InvestmentReady treated as Investment approval.

## Test Data

Test data should distinguish:

- synthetic identities
- synthetic accounts
- synthetic assets
- synthetic opportunities
- synthetic currencies
- synthetic marketplace providers
- synthetic external references

Production secrets and real private credentials must never appear in test fixtures.

## Determinism

Tests for authoritative financial calculations must be deterministic.

The same:

- input
- policy version
- valuation inputs
- exchange-rate inputs
- timestamp assumptions
- configuration

must produce the same authoritative result.

## Time Testing

Test:

- expired permissions
- expired approvals
- expired verification
- expired valuation
- expired risk assessment
- settlement timeout
- idempotency expiration
- policy effective dates

Time-sensitive tests should use controlled test time rather than uncontrolled wall-clock assumptions.

## Contract Version Testing

Test:

- supported current version
- supported previous version
- unsupported future version
- malformed version
- migration path where applicable

Adapters must explicitly declare supported contract versions.

## Regression Strategy

Every production bug that affects domain behavior should produce:

1. regression test
2. root-cause record
3. invariant check where applicable
4. compatibility review
5. audit of related workflows

A bug fix is incomplete without a regression test when a deterministic test is possible.

## Test Gates

A change should not be considered releasable until applicable gates pass:

### Gate 1
Compile/build validation.

### Gate 2
Unit tests.

### Gate 3
State-machine tests.

### Gate 4
Financial/event/ledger tests.

### Gate 5
Authorization/security tests.

### Gate 6
Contract/adapter tests.

### Gate 7
Invariant tests.

### Gate 8
Failure/recovery tests for affected integrations.

### Gate 9
Regression suite.

## Test Isolation

Tests must not depend on:

- production data
- production secrets
- uncontrolled external providers
- live financial accounts
- live marketplace assets

External integrations use mocks, simulators or dedicated test environments.

## Auditability

Test results should identify:

- test_suite
- test_case
- version
- timestamp
- environment
- result
- failure_reason
- related_commit where available

Financial invariant failures should be treated as release-blocking.

## Core Invariants

1. Build success is not correctness.
2. Every critical state machine has transition tests.
3. Financial calculations are deterministic.
4. Sensitive commands have idempotency tests.
5. Unauthorized commands produce no financial mutation.
6. Ledger integrity is automatically tested.
7. Projections are rebuild-tested.
8. Adapter contracts are independently tested.
9. External failures have recovery tests.
10. Governance and risk boundaries are tested.
11. AI authority boundaries are tested.
12. Stale data detection is tested.
13. Regression tests accompany material bug fixes.
14. Critical invariant failure blocks release.
15. Production secrets never enter test data.
