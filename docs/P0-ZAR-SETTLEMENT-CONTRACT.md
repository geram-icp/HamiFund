# HamiFund — Digital Rand (ZAR) settlement adapter (P0)
**Status:** Proposed contract, pending implementation and tests.

## Boundary
HamiFund owns fund, loan, position, risk, allocation and exposure state. GERAM owns asset/evidence/certificate state. The official ICP ICRC ledger owns ZAR token balances and transfers; ZAR.TODAY owns published price-feed provenance, not token balances. HamiFund MUST NOT mint, burn or reconcile holder balances by merely modifying its internal database.

## Canonical token configuration
- Display name: **Digital Rand (ZAR)**; symbol `ZAR`; ICP ledger; 3 decimals; **0 raw-unit ledger transfer fee**.
- The owner's proposed 1:1 rand redemption obligation, mixed custody collateral and >=110% reserve coverage are issuer-policy matters, not HamiFund-guaranteed yields or liquidity.
- The proposed entire genesis supply (133 trillion display units) is **not minted or authorized** by this adapter.
- Minting is allowed only under attested reserve headroom + authorized manager signature; burning only upon holder authorization.
- Redemption is governed by issuer terms: target within 3 business days to a verified account in rand/agreed currency.
- Daily reserves/supply transparency and quarterly independent issuer audit are required before production use.

## Adapter requests
```text
ZarTransferInstruction {
  correlation_id, idempotency_key, fund_position_ref,
  payer_icrc_account, payee_icrc_account, ledger_canister_id,
  amount_base_units, network, purpose, wallet_authorization_ref,
  quote_id, quote_type, quote_expiry, compliance_ref
}
ZarSettlementReceipt {
  correlation_id, ledger_tx_ref, confirmed_amount_base_units,
  confirmed_payer, confirmed_payee, status, finalized_at,
  reconciliation_ref, evidence_hash
}
```

## Workflow
1. HamiFund validates investment eligibility, position and fund rules, risk limits and eligible capital.
2. Separately authenticate holder via wallet-signed ICP identity proof and verify the ICRC Account (Principal + optional subaccount).
3. Select and validate the correct **settlement** quote, not merely the ZAR.TODAY reference or redemption rate.
4. Initiate only a user-authorized ICRC-1 transfer or ICRC-2 allowance-based transfer, using stable idempotency/correlation records.
5. Confirm on-chain sender, recipient, amount, ledger identity and transaction reference before posting a reconciled HamiFund settlement.
6. Handle duplicate submissions, timeout, stale quotes, chain/network errors, reverse payments and escrow exceptions explicitly.
7. Update derived accounting entries, keeping the external ledger as the source of token truth.

## State machine
`Proposed -> Validated -> HolderAuthorized -> Submitted -> ChainConfirmed -> Reconciled`
Alternative terminal/compensating states: `Rejected`, `TimedOut`, `Disputed`, `CompensationPending`. A timeout is **not proof** of a failed transfer; query ledger history before retry.

## Financial safeguards
- Store amounts as integers in raw units; 1 ZAR = 1000 raw units, with no floating-point monetary accounting.
- The ledger fee is zero; off-chain banking, FX and service fees, if any, must be separately stated and opt-in.
- Do not use issuer reserves as HamiFund collateral or pooled fund liquidity unless legally segregated and separately permitted.
- No guaranteed redemption, reserve-backed value or public listing should be advertised until legal contracts, custody proof and independent audit exist.
- Reject stale, unsigned or ambiguously defined settlement quotes.
- Preserve GDPR/privacy and local statutory data retention while keeping an auditable reconciliation trace.

## Dependencies and release criteria
- Pinned official ICRC ledger WASM/Candid/version and local integration test results.
- Verified issuance reserve policy and redemption operating agreement owned by ZAR issuer.
- Signed HamiFund/GERAM cross-domain contracts and test fixtures.
- Authority, custody and wallet security review; independent compliance and jurisdictional assessment.
- No real-asset transfer, live mint/burn, production settlement or Mainnet deployment without separate approval.

See existing `P0-MONEY-ENGINE.md` and `P0-GERAM-CONTRACT.md` for the underlying HamiFund contract conventions.
