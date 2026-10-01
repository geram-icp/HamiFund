import Types "./Types";
import InMemoryStore "./InMemoryStore";

module {
  public type TestResult = {
    name : Text;
    passed : Bool;
  };

  public func duplicateEntryRejected() : TestResult {
    let store = InMemoryStore.empty();

    let event1 : Types.FinancialEvent = {
      event_id = "EVT-001";
      event_type = "TEST";
      correlation_id = "COR-001";
      causation_id = null;
      occurred_at = 1;
      recorded_at = 1;
    };

    let entry1 : Types.LedgerEntry = {
      entry_id = "ENTRY-001";
      ledger_id = "LEDGER-001";
      event_id = "EVT-001";
      account_id = "ACC-001";
      direction = #Debit;
      amount = 100;
      currency = "USD";
      status = #Posted;
      created_at = 1;
    };

    let entry1Credit : Types.LedgerEntry = {
      entry_id = "ENTRY-002";
      ledger_id = "LEDGER-001";
      event_id = "EVT-001";
      account_id = "ACC-002";
      direction = #Credit;
      amount = 100;
      currency = "USD";
      status = #Posted;
      created_at = 1;
    };

    let entry2 : Types.LedgerEntry = {
      entry_id = "ENTRY-001";
      ledger_id = "LEDGER-001";
      event_id = "EVT-002";
      account_id = "ACC-002";
      direction = #Credit;
      amount = 100;
      currency = "USD";
      status = #Posted;
      created_at = 2;
    };

    switch (InMemoryStore.append(store, event1, [entry1, entry1Credit])) {
      case (#err(_)) {
        {
          name = "DUPLICATE_ENTRY_REJECTED";
          passed = false;
        };
      };

      case (#ok(updatedStore, _)) {
        let event2 : Types.FinancialEvent = {
          event_id = "EVT-002";
          event_type = "TEST";
          correlation_id = "COR-002";
          causation_id = null;
          occurred_at = 2;
          recorded_at = 2;
        };

        switch (InMemoryStore.append(updatedStore, event2, [entry2])) {
          case (#err(#DuplicateEntry)) {
            {
              name = "DUPLICATE_ENTRY_REJECTED";
              passed = true;
            };
          };
          case (_) {
            {
              name = "DUPLICATE_ENTRY_REJECTED";
              passed = false;
            };
          };
        };
      };
    };
  };
}
