# HamiFund ? P0 Source Tree

## Core

### core/identity
Identity, Role, Permission, AuthorizationContext.

### core/financial
Account, Capital, Investment, Position, Portfolio, Fund, NAV, Transaction.

### core/event
Command, FinancialEvent, LedgerEntry, Projection,
Reconciliation, AuditEvent.

### core/governance
Policy, Limit, Approval, Compliance, EmergencyControl.

## Engines

### engines/money
Deposit, Allocation, Transfer, Redemption, Settlement, Treasury.

### engines/value
Valuation, Performance, Yield, Distribution, Reinvestment.

### engines/risk
Exposure, Concentration, Liquidity, Credit,
Counterparty, Market, Operational, Settlement, Technology.

### engines/opportunity
Opportunity, AssetReference, RightsReference,
VerificationSnapshot, ValuationSnapshot, RiskSnapshot,
InvestmentReadiness.

### engines/intelligence
Forecast, Scenario, Anomaly, RiskAnalysis,
PortfolioAnalysis, DecisionSupport.

## Marketplace

Marketplace-independent Digital Asset, Collection,
Listing, Offer, Transfer and Settlement contracts.

## Connectivity

All external integrations are isolated behind contracts and adapters.

- connectivity/contracts
- connectivity/adapters
- connectivity/geram
- connectivity/wallet
- connectivity/chain
- connectivity/oracle
- connectivity/financial

## Shared

Cross-cutting primitives only.

No business-domain logic belongs here.

## API

External command/query boundary.

API must not contain Core business rules.

## Testing

Unit, integration, invariant and contract tests.

## Dependency Rule

Allowed direction:

API
? Core / Engines
? Core Contracts

Connectivity
? Contracts
? External Systems

Forbidden:

Core
? GERAM implementation

Core
? Marketplace implementation

Core
? Wallet implementation

Core
? Chain implementation

AI
? Authority

API
? Direct Ledger Mutation

Adapters
? Direct Balance Mutation

## Legacy Boundary

Existing legacy files are not imported into the new architecture.

They remain available only as historical reference until
the new implementation is independently validated.
