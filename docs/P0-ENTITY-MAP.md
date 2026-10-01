# HamiFund ? P0 Entity Map

## Common Identity

Every major entity:
- id
- version
- status
- created_at
- updated_at
- owner
- audit_ref

Sensitive commands:
- correlation_id
- idempotency_key

## Identity & Access

Identity
Account
WalletReference
Permission
Role
Policy

## Financial Core

Fund
CapitalAccount
Investment
Position
Portfolio
Transaction
NAVSnapshot

## Opportunity

Opportunity
AssetReference
RightsReference
VerificationSnapshot
ValuationSnapshot
RiskSnapshot
InvestmentReadiness

## Digital Asset

DigitalAsset
Metadata
Collection
Listing
Offer
Transfer
MarketplaceActivity
SettlementReference

## Event & Ledger

Command
FinancialEvent
LedgerEntry
Projection
Reconciliation
AuditEvent

## Money

Deposit
Allocation
Redemption
Settlement
TreasuryPosition

## Value

Valuation
Performance
Yield
Distribution
Reinvestment

## Risk

Exposure
Concentration
LiquidityPosition
CreditAssessment
Counterparty
StressScenario
RiskAssessment

## Core Separation

Real Asset
    ? Digital Asset

Digital Asset
    ? Financial Account

Wallet
    ? Financial Account

Opportunity
    ? Investment

Investment
    ? Position

Marketplace Listing
    ? Ownership Settlement

Ledger Entry
    ? Mutable Balance Record
