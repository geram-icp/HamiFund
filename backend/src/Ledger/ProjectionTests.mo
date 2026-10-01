import Types "./Types";
import Projection "./Projection";

module {
  public type TestResult = {
    name : Text;
    passed : Bool;
  };

  public func postedEntriesCount() : TestResult {
    let entries : [Types.LedgerEntry] = [
      {
        entry_id = "P-001";
        ledger_id = "LEDGER-001";
        event_id = "EVT-P01";
        account_id = "ACC-001";
        direction = #Credit;
        amount = 100;
        currency = "USD";
        status = #Posted;
        created_at = 1;
      },
      {
        entry_id = "P-002";
        ledger_id = "LEDGER-001";
        event_id = "EVT-P02";
        account_id = "ACC-001";
        direction = #Debit;
        amount = 30;
        currency = "USD";
        status = #Posted;
        created_at = 1;
      }
    ];

    let result = Projection.projectAccount("ACC-001", "USD", entries);

    {
      name = "POSTED_BALANCE";
      passed = result.available == 70;
    };
  };

  public func pendingIgnored() : TestResult {
    let entries : [Types.LedgerEntry] = [
      {
        entry_id = "P-003";
        ledger_id = "LEDGER-001";
        event_id = "EVT-P03";
        account_id = "ACC-001";
        direction = #Credit;
        amount = 100;
        currency = "USD";
        status = #Pending;
        created_at = 1;
      }
    ];

    let result = Projection.projectAccount("ACC-001", "USD", entries);

    {
      name = "PENDING_IGNORED";
      passed = result.available == 0;
    };
  };

  public func voidedIgnored() : TestResult {
    let entries : [Types.LedgerEntry] = [
      {
        entry_id = "P-004";
        ledger_id = "LEDGER-001";
        event_id = "EVT-P04";
        account_id = "ACC-001";
        direction = #Credit;
        amount = 100;
        currency = "USD";
        status = #Voided;
        created_at = 1;
      }
    ];

    let result = Projection.projectAccount("ACC-001", "USD", entries);

    {
      name = "VOIDED_IGNORED";
      passed = result.available == 0;
    };
  };
}
