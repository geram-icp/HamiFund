import Types "../Ledger/Types";
import FinancialState "./FinancialState";

module {
  public type TestResult = {
    name : Text;
    passed : Bool;
  };

  public func accountStateFromProjection() : TestResult {
    let entries : [Types.LedgerEntry] = [
      {
        entry_id = "Q-001";
        ledger_id = "LEDGER-001";
        event_id = "EVT-Q01";
        account_id = "ACC-QUERY";
        direction = #Credit;
        amount = 250;
        currency = "USD";
        status = #Posted;
        created_at = 1;
      },
      {
        entry_id = "Q-002";
        ledger_id = "LEDGER-001";
        event_id = "EVT-Q02";
        account_id = "ACC-QUERY";
        direction = #Debit;
        amount = 75;
        currency = "USD";
        status = #Posted;
        created_at = 1;
      }
    ];

    let state = FinancialState.accountState(
      "ACC-QUERY",
      "USD",
      entries
    );

    {
      name = "QUERY_FROM_PROJECTION";
      passed =
        state.available == 175
        and state.credit == 250
        and state.debit == 75;
    };
  };
}
