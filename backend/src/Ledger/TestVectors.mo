import Types "./Types";
import Posting "./Posting";

module {
  public type TestResult = {
    name : Text;
    passed : Bool;
  };

  public func balancedEvent() : TestResult {
    let event : Types.FinancialEvent = {
      event_id = "EVT-001";
      event_type = "TRANSFER";
      correlation_id = "CORR-001";
      causation_id = null;
      occurred_at = 1;
      recorded_at = 1;
    };

    let entries : [Types.LedgerEntry] = [
      {
        entry_id = "ENT-001";
        ledger_id = "LEDGER-001";
        event_id = "EVT-001";
        account_id = "ACC-001";
        direction = #Debit;
        amount = 100;
        currency = "USD";
        status = #Pending;
        created_at = 1;
      },
      {
        entry_id = "ENT-002";
        ledger_id = "LEDGER-001";
        event_id = "EVT-001";
        account_id = "ACC-002";
        direction = #Credit;
        amount = 100;
        currency = "USD";
        status = #Pending;
        created_at = 1;
      }
    ];

    switch (Posting.validateEvent(event, entries)) {
      case (#ok(_)) {
        { name = "BALANCED"; passed = true };
      };
      case (#err(_)) {
        { name = "BALANCED"; passed = false };
      };
    };
  };

  public func unbalancedEvent() : TestResult {
    let event : Types.FinancialEvent = {
      event_id = "EVT-002";
      event_type = "TRANSFER";
      correlation_id = "CORR-002";
      causation_id = null;
      occurred_at = 1;
      recorded_at = 1;
    };

    let entries : [Types.LedgerEntry] = [
      {
        entry_id = "ENT-003";
        ledger_id = "LEDGER-001";
        event_id = "EVT-002";
        account_id = "ACC-001";
        direction = #Debit;
        amount = 100;
        currency = "USD";
        status = #Pending;
        created_at = 1;
      },
      {
        entry_id = "ENT-004";
        ledger_id = "LEDGER-001";
        event_id = "EVT-002";
        account_id = "ACC-002";
        direction = #Credit;
        amount = 90;
        currency = "USD";
        status = #Pending;
        created_at = 1;
      }
    ];

    switch (Posting.validateEvent(event, entries)) {
      case (#ok(_)) {
        { name = "UNBALANCED"; passed = false };
      };
      case (#err(_)) {
        { name = "UNBALANCED"; passed = true };
      };
    };
  };

  public func emptyEvent() : TestResult {
    let event : Types.FinancialEvent = {
      event_id = "EVT-003";
      event_type = "TRANSFER";
      correlation_id = "CORR-003";
      causation_id = null;
      occurred_at = 1;
      recorded_at = 1;
    };

    switch (Posting.validateEvent(event, [])) {
      case (#ok(_)) {
        { name = "EMPTY"; passed = false };
      };
      case (#err(_)) {
        { name = "EMPTY"; passed = true };
      };
    };
  };

  public func multiCurrencyEvent() : TestResult {
    let event : Types.FinancialEvent = {
      event_id = "EVT-004";
      event_type = "TRANSFER";
      correlation_id = "CORR-004";
      causation_id = null;
      occurred_at = 1;
      recorded_at = 1;
    };

    let entries : [Types.LedgerEntry] = [
      {
        entry_id = "ENT-005";
        ledger_id = "LEDGER-001";
        event_id = "EVT-004";
        account_id = "ACC-001";
        direction = #Debit;
        amount = 100;
        currency = "USD";
        status = #Pending;
        created_at = 1;
      },
      {
        entry_id = "ENT-006";
        ledger_id = "LEDGER-001";
        event_id = "EVT-004";
        account_id = "ACC-002";
        direction = #Credit;
        amount = 100;
        currency = "EUR";
        status = #Pending;
        created_at = 1;
      }
    ];

    switch (Posting.validateEvent(event, entries)) {
      case (#ok(_)) {
        { name = "MULTI_CURRENCY"; passed = false };
      };
      case (#err(_)) {
        { name = "MULTI_CURRENCY"; passed = true };
      };
    };
  };
}
