# P0-C27 ? Build & Deployment Strategy

## Purpose

Define the build, test, deployment, configuration and upgrade strategy for HamiFund.

Deployment must preserve:

- financial integrity
- deterministic builds
- controlled configuration
- authorization boundaries
- auditability
- recoverability
- upgrade safety

## Toolchain

The initial implementation target is the Internet Computer / Motoko environment.

Primary tools:

- DFINITY SDK (`dfx`)
- Motoko compiler/toolchain
- Mops where justified
- Git
- Node.js only for frontend/tooling requirements
- shell-based verification scripts

Exact versions must be recorded and pinned for reproducible builds.

## Repository Structure

The implementation follows the approved source architecture:

`backend/src/core`

`backend/src/engines`

`backend/src/marketplace`

`backend/src/connectivity`

`backend/src/api`

`backend/src/shared`

`backend/src/testing`

Documentation remains under:

`docs/`

Historical source remains outside the active dependency graph.

## Build Configuration

The project must contain explicit build configuration.

Expected future configuration includes:

- dfx.json
- mops.toml where required
- backend build configuration
- frontend configuration where applicable
- test configuration
- environment/configuration definitions

Configuration must not contain production secrets.

## Build Reproducibility

A build should be reproducible from:

- source commit
- dependency versions
- compiler version
- build configuration
- contract versions
- required generated artifacts

The build environment should report:

- commit
- toolchain versions
- dependency versions
- build timestamp
- environment

## Dependency Policy

Dependencies must be:

- explicitly declared
- versioned
- reviewed
- justified
- compatible with the architecture

Do not add a dependency merely because it provides a convenient abstraction.

Avoid importing large blockchain libraries unless the implemented feature requires them.

## Core Dependency Rule

Core business modules must remain independent from:

- GERAM implementation
- marketplace implementation
- wallet implementation
- chain-specific implementation
- external provider SDKs
- frontend code
- AI implementation

External dependencies enter through contracts/adapters.

## Environment Separation

At minimum define:

1. Development
2. Test
3. Staging
4. Production

Each environment must have separate:

- canister/deployment identity
- configuration
- external provider configuration
- credentials
- test data
- operational controls

Production must never use development credentials.

## Development

Development environment supports:

- local compilation
- local canister execution
- unit tests
- integration tests
- synthetic data
- local adapter mocks

Development data has no financial authority.

## Test

Test environment validates:

- contract behavior
- financial calculations
- state machines
- authorization
- event/ledger behavior
- adapter integration
- failure/recovery
- invariant suite

Test environment must use synthetic or dedicated test resources.

## Staging

Staging should resemble production configuration and deployment behavior.

Use it for:

- release candidate validation
- migration testing
- upgrade testing
- integration validation
- operational rehearsal
- recovery testing

Staging must not silently connect to production financial resources.

## Production

Production requires:

- approved release
- passing required test gates
- versioned configuration
- authorized deployment
- backup/recovery readiness
- monitoring
- audit readiness
- emergency controls

Production deployment is an operationally controlled action.

## Release Pipeline

Recommended flow:

`Commit`
`-> Static Checks`
`-> Build`
`-> Unit Tests`
`-> Integration Tests`
`-> Contract Tests`
`-> Invariant Tests`
`-> Security Tests`
`-> Failure/Recovery Tests`
`-> Release Candidate`
`-> Staging`
`-> Approval`
`-> Production Deployment`
`-> Post-Deploy Verification`
`-> Audit`

A failed critical financial invariant blocks release.

## Static Checks

Before deployment validate:

- source formatting where applicable
- imports
- forbidden dependency boundaries
- forbidden direct mutations
- version declarations
- configuration integrity
- secret detection
- generated artifacts

## Architecture Checks

Automated checks should detect forbidden dependencies.

Examples:

Core must not import:

- GERAM implementation
- marketplace implementation
- wallet implementation
- chain implementation

Adapters must not:

- mutate authoritative balances directly
- rewrite ledger history
- bypass authorization

API must not:

- directly mutate ledger
- directly mutate balance
- directly modify ownership

AI must not:

- authorize financial operations
- modify ledger
- bypass governance

## Configuration

Configuration should distinguish:

- application settings
- policy configuration
- risk limits
- provider configuration
- feature flags
- environment settings

Configuration changes affecting financial behavior require appropriate governance and audit.

## Secrets

Secrets must never be committed to Git.

Examples:

- private keys
- API credentials
- provider secrets
- signing secrets
- authentication credentials

Secrets should be supplied through secure environment/secret-management mechanisms appropriate to deployment.

Logs must not expose secrets.

## Key Management

Cryptographic keys must have:

- controlled generation
- restricted access
- rotation policy
- backup/recovery strategy where applicable
- audit trail
- emergency replacement procedure

Key access must follow least privilege.

## Canister Deployment

Canister deployment must distinguish:

- installation
- upgrade
- configuration update
- migration

An upgrade must not be treated as an ordinary source replacement.

## Upgrade Safety

Before an upgrade:

1. Record current version.
2. Verify source commit.
3. Verify build.
4. Run full applicable tests.
5. Verify stable-state compatibility.
6. Validate migration plan.
7. Back up required state.
8. Obtain required approval.
9. Deploy to staging.
10. Perform post-upgrade checks.
11. Deploy production.
12. Verify state and invariants.

## Stable State

Authoritative state must have an explicit persistence strategy.

Important state includes:

- financial events
- ledger entries
- audit events
- reconciliation records
- critical configuration
- governance state
- idempotency records where required

Stable-state changes must be reviewed as part of upgrades.

## Migration

Migration scripts/processes must be:

- versioned
- deterministic
- testable
- reversible where technically possible
- auditable

Migration must not silently alter financial history.

If historical financial data needs correction, use explicit compensating records rather than destructive rewriting.

## Deployment Authorization

Production deployment should require:

- authorized operator
- approved release version
- passing release gates
- deployment correlation_id
- deployment audit record

Where required:

`Requester != Approver != Executor`

## Post-Deployment Verification

Immediately after deployment verify:

- canister/module availability
- API availability
- expected version
- state readability
- projection consistency
- ledger integrity
- governance availability
- risk engine availability
- adapter health
- monitoring
- audit trail

Financial operations should remain restricted until critical checks pass where policy requires it.

## Rollback

Rollback strategy must distinguish:

### Code Rollback

Return to a previous compatible software version.

### Data Rollback

Financial history must not normally be destructively rolled back.

If a financial error occurs:

`Correction -> Compensating Event -> Ledger Entry -> Audit`

not silent deletion.

## Backup

Backups should cover:

- authoritative events
- ledger
- audit
- reconciliation
- critical configuration
- governance state
- required metadata

Backups must be:

- versioned
- integrity checked
- access controlled
- recoverable
- periodically tested

## Disaster Recovery

Recovery sequence:

`Restore Authoritative State`
`-> Integrity Check`
`-> Rebuild Projections`
`-> Restore External References`
`-> Reconcile External Systems`
`-> Run Invariants`
`-> Verify Governance`
`-> Re-enable Restricted Operations`

Recovery is incomplete until reconciliation and invariant checks pass.

## Monitoring

Monitor at minimum:

- canister health
- command failures
- authorization failures
- ledger errors
- reconciliation cases
- settlement failures
- adapter failures
- stale external data
- risk-limit breaches
- emergency controls
- unusual marketplace activity

Monitoring events must be distinguishable from authoritative financial events.

## Logging

Logs should contain appropriate:

- timestamp
- severity
- component
- correlation_id
- command_id where applicable
- actor reference where permitted
- result
- error classification

Logs must not contain:

- private keys
- credentials
- unnecessary sensitive personal information
- confidential financial payloads

## Deployment Observability

Every production release should be traceable to:

- repository commit
- release version
- build environment
- deployment actor
- deployment timestamp
- configuration version
- migration version where applicable
- verification result

## Feature Flags

Feature flags may control unfinished or staged capabilities.

Financially sensitive feature flags require:

- explicit ownership
- policy
- audit
- safe default
- change history

A feature flag must not silently bypass authorization or risk controls.

## Emergency Deployment

Emergency deployment may use an expedited process only when defined by policy.

It still requires:

- authorized actor
- reason
- audit
- minimum safety validation
- post-deployment review

Emergency process does not permit silent ledger modification.

## Production Data Boundary

Production financial data must never be copied into development or test environments without an explicitly approved, lawful and appropriately protected process.

Synthetic data is preferred.

## Dependency Update

Dependency updates require:

- version review
- compatibility check
- security review where applicable
- build
- regression tests
- invariant tests
- deployment validation

A dependency update is not automatically harmless.

## Release Versioning

Release metadata should include:

- release_version
- source_commit
- build_version
- contract_versions
- migration_version
- configuration_version
- release_timestamp

Breaking contract changes require explicit version transition.

## Core Invariants

1. Production deployments are authorized.
2. Production secrets never enter source control.
3. Build versions are reproducible.
4. Critical invariant failures block release.
5. Core dependency boundaries are enforced.
6. Financial history is not destructively rolled back.
7. Migrations are versioned and auditable.
8. Stable authoritative state survives upgrades.
9. Recovery includes reconciliation.
10. Post-deployment verification is mandatory.
11. Configuration changes cannot silently bypass governance.
12. Emergency deployment remains auditable.
13. Test and production environments remain separated.
14. Every production release is traceable to a source commit.
15. Deployment cannot bypass financial authorization controls.
