# HamiFund ? P0 Dependency Graph

## Dependency Direction

Governance
    ?
Financial Core
    ?
Event & Ledger

Money Engine ???????? Financial Core
Value Engine ???????? Financial Core
Risk Engine ????????? Financial Core
Opportunity Engine ?? Financial Core
Digital Asset ??????? Financial Core

Intelligence
    ? Financial Core
    ? Value Engine
    ? Risk Engine
    ? Opportunity Engine

Connectivity Fabric
    ? Core Contracts
    ? External Systems

## Adapter Boundary

GERAM
  ?
GERAM Adapter
  ?
Opportunity Contract

Marketplace
  ?
Marketplace Adapter
  ?
Digital Asset / Marketplace Contract

Wallet
  ?
Wallet Adapter
  ?
Wallet Contract

Ledger / Chain / Oracle / Financial APIs
  ?
Versioned Adapter Contracts

## Forbidden Dependencies

Core ? GERAM internal modules       NO
Core ? Marketplace implementation  NO
Core ? Wallet implementation       NO
Core ? Chain-specific implementation NO
AI ? Authority / Final Approval    NO
Marketplace ? GERAM internals     NO

## Rules

1. Core owns business rules.
2. Adapters translate external models into HamiFund contracts.
3. External outages must not corrupt HamiFund state.
4. External IDs remain references, not imported types.
5. Adapter versions are explicit.
6. Financial state changes go through events and ledger.
7. Sensitive commands require authorization and idempotency.
8. Marketplace listing never directly mutates financial balances.
