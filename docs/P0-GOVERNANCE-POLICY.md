# P0-C24 ? Governance & Policy Contract

## Purpose

Define the authoritative governance boundary for permissions, policies, limits, approvals, compliance controls and emergency actions.

Governance decides what operations are permitted.

Core engines execute only within authorized policy boundaries.

## Governance Principles

1. Explicit authorization.
2. Default deny.
3. Least privilege.
4. Separation of duties.
5. Policy-driven execution.
6. Auditable decisions.
7. Time-bounded permissions where required.
8. Emergency controls are explicit and auditable.
9. No adapter bypasses governance.
10. AI has no governance authority.

## Identity

Minimum reference:

- identity_ref
- identity_type
- status
- verification_ref
- version

Identity establishes the actor reference.

Identity alone does not grant permission.

## Role

Minimum fields:

- role_id
- name
- description
- status
- version
- policy_ref
- created_at
- updated_at

Examples:

- SystemAdmin
- Operations
- Finance
- Risk
- Compliance
- InvestmentOfficer
- TreasuryOfficer
- Auditor
- MarketplaceOperator
- Support
- ReadOnly

Roles are permission containers.

## Permission

Minimum fields:

- permission_id
- operation
- resource_type
- scope
- status
- version

Examples:

- account.read
- account.create
- capital.allocate
- investment.propose
- investment.approve
- transfer.execute
- settlement.confirm
- distribution.approve
- treasury.move
- asset.issue
- marketplace.list
- marketplace.transfer
- governance.modify
- emergency.pause

Permission must be explicit.

No permission should be inferred from UI access or wallet possession.

## Authorization Context

Minimum fields:

- authorization_context_id
- actor_ref
- role_refs
- permission_refs
- policy_refs
- target_ref
- requested_operation
- requested_amount
- currency
- jurisdiction
- timestamp
- correlation_id
- decision
- reason
- version

Authorization decision:

`Allowed | Denied | RequiresApproval | RequiresReview`

## Policy

Minimum fields:

- policy_id
- policy_type
- name
- scope
- conditions_ref
- effective_from
- effective_until
- status
- version
- owner_ref
- approval_ref
- audit_ref

Policy types may include:

- transaction
- investment
- risk
- liquidity
- marketplace
- treasury
- settlement
- compliance
- jurisdiction
- asset
- emergency
- operational

Policies are versioned.

A historical decision must remain linked to the policy version used at decision time.

## Policy Evaluation

Authorization flow:

`Identity -> Role -> Permission -> Policy -> Limit Check -> Approval Check -> Authorization Decision`

A denied operation must not mutate financial state.

A RequiresApproval decision must not execute until required approval is completed.

## Limits

Minimum fields:

- limit_id
- target_ref
- limit_type
- threshold
- unit
- currency
- scope
- effective_from
- effective_until
- policy_ref
- status
- version

Possible limits:

- per_transaction
- daily_volume
- monthly_volume
- account_exposure
- portfolio_exposure
- asset_exposure
- issuer_exposure
- counterparty_exposure
- currency_exposure
- marketplace_volume
- redemption_volume
- treasury_outflow

Limit breaches create explicit control events.

Limits cannot be silently bypassed.

## Approval

Minimum fields:

- approval_id
- command_ref
- requester_ref
- approver_ref
- approval_type
- decision
- reason
- timestamp
- policy_ref
- status
- version
- audit_ref

Approval lifecycle:

`Requested -> UnderReview -> Approved -> Executed`

Failure/alternative states:

`Rejected -> Cancelled -> Expired`

An approval is bound to the command, target, amount and applicable policy context.

Changing material command parameters invalidates the previous approval unless policy explicitly permits amendment.

## Separation of Duties

Where policy requires:

`Requester != Approver != Executor`

Examples:

- Investment proposal may be created by one actor and approved by another.
- Treasury movement may require independent approval.
- Emergency actions require independent audit/review where applicable.

Self-approval is prohibited where the governing policy requires separation.

## Compliance

Minimum fields:

- compliance_check_id
- target_ref
- check_type
- result
- rule_ref
- checked_at
- valid_until
- reviewer_ref
- status
- version
- audit_ref

Possible checks:

- identity verification
- jurisdiction
- sanctions/compliance rule
- transaction restriction
- asset eligibility
- investor eligibility
- source-of-funds requirement
- documentation completeness

Compliance failure blocks the applicable operation unless an explicit lawful exception exists.

## Investment Governance

Investment execution requires applicable:

- identity authorization
- opportunity readiness
- risk assessment
- policy evaluation
- limit check
- compliance check
- required approval
- idempotency
- audit evidence

Investment readiness does not equal investment approval.

AI recommendations do not equal investment approval.

## Money Governance

Capital movement requires:

- authorized actor
- valid account
- valid currency
- sufficient eligible funds or explicitly authorized credit
- policy check
- applicable risk/limit checks
- idempotency
- financial event
- ledger evidence
- audit

No direct balance mutation is permitted.

## Marketplace Governance

Marketplace operations may require:

- asset eligibility
- ownership/right authorization
- marketplace policy
- pricing constraints
- counterparty controls
- jurisdiction controls
- risk checks
- approval where required
- idempotency
- audit

Marketplace operators cannot bypass Core financial controls.

## Treasury Governance

Treasury movements require explicit authorization.

Where required:

`Requester -> Approver -> Executor -> Reconciliation`

Treasury policies may define:

- allowed assets
- allowed providers
- transaction limits
- reserve requirements
- liquidity minimums
- emergency restrictions
- settlement requirements

## Emergency Control

Emergency controls may include:

- global_pause
- financial_operations_pause
- investment_pause
- transfer_pause
- settlement_pause
- marketplace_pause
- asset_freeze
- account_suspend
- treasury_pause

Minimum fields:

- emergency_control_id
- control_type
- target_ref
- activated_by
- activated_at
- reason
- scope
- status
- expires_at
- review_ref
- version
- audit_ref

Emergency controls must be explicit.

An emergency control cannot silently rewrite historical financial state.

## Emergency Lifecycle

`Proposed -> Authorized -> Active -> Reviewed -> Released`

Alternative:

`Proposed -> Rejected`

Emergency activation must produce an audit event.

Release requires authorization according to policy.

## Default Deny

If any required authorization component is missing:

`DENY`

Examples:

- missing identity
- missing permission
- missing policy
- expired permission
- exceeded limit
- failed compliance
- missing approval
- suspended account
- frozen asset
- active emergency restriction

The system must not guess authorization.

## Policy Versioning

Every authorization decision records:

- policy_ref
- policy_version
- permission_version where applicable
- limit_version where applicable
- approval_ref where applicable
- decision_timestamp

Policy changes apply prospectively unless an explicit migration policy exists.

Historical decisions remain auditable under the policy version used at execution.

## Governance Events

Examples:

- PermissionGranted
- PermissionRevoked
- PolicyCreated
- PolicyActivated
- PolicySuspended
- LimitChanged
- ApprovalRequested
- ApprovalGranted
- ApprovalRejected
- CompliancePassed
- ComplianceFailed
- EmergencyActivated
- EmergencyReleased

Governance events are immutable and auditable.

## AI Boundary

AI may:

- analyze policy data
- identify potential violations
- recommend review
- detect anomalies
- summarize governance activity
- support compliance analysis

AI may not independently:

- grant permissions
- approve investments
- approve capital movement
- change limits
- override policy
- release emergency controls
- alter ledger history
- establish legal authority

## Adapter Boundary

Adapters must:

- provide actor/context information
- preserve correlation_id
- preserve idempotency
- submit commands through Core authorization
- return external results
- never bypass policy evaluation

External systems cannot grant HamiFund authority.

## Audit Requirements

Every material governance action records:

- audit_id
- actor_ref
- action
- target_ref
- timestamp
- correlation_id
- command_ref
- policy_ref
- policy_version
- authorization_result
- approval_ref
- reason
- execution_result

## Core Invariants

1. Identity does not equal permission.
2. Role does not bypass policy.
3. Permission does not bypass limits.
4. Limits do not bypass compliance.
5. Approval does not rewrite policy.
6. Denied commands do not mutate financial state.
7. Required approvals cannot be bypassed.
8. Separation of duties is enforced where required.
9. Historical decisions retain policy versions.
10. Emergency controls are explicit and auditable.
11. AI has no independent governance authority.
12. Adapters cannot bypass Governance.
13. Governance cannot silently rewrite ledger history.
14. Every material authorization decision is auditable.
