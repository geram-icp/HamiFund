import Boundary "./PostingBoundary";

module {

  public type TestResult = {
    name : Text;
    passed : Bool;
  };

  func baseRequest(
    lines : [Boundary.PostingLine]
  ) : Boundary.PostingRequest {
    {
      event_id = "EVT-TEST-001";
      event_type = "TEST_POSTING";
      correlation_id = "CORR-001";
      occurred_at = 1000;
      recorded_at = 1001;
      lines = lines;
    };
  };

  public func balancedPosting() : TestResult {
    let result = Boundary.build(
      baseRequest([
        {
          account_id = "ACC-DEBIT";
          direction = #Debit;
          amount = 100;
          currency = "USD";
        },
        {
          account_id = "ACC-CREDIT";
          direction = #Credit;
          amount = 100;
          currency = "USD";
        }
      ])
    );

    {
      name = "balanced posting";
      passed = switch (result) {
        case (#ok(intent)) {
          intent.entries.size() == 2;
        };
        case (#err(_)) {
          false;
        };
      };
    };
  };

  public func unbalancedPostingRejected() : TestResult {
    let result = Boundary.build(
      baseRequest([
        {
          account_id = "ACC-DEBIT";
          direction = #Debit;
          amount = 100;
          currency = "USD";
        },
        {
          account_id = "ACC-CREDIT";
          direction = #Credit;
          amount = 90;
          currency = "USD";
        }
      ])
    );

    {
      name = "unbalanced posting rejected";
      passed = switch (result) {
        case (#err(#InvalidPosting)) { true };
        case (#err(_)) { false };
        case (#ok(_)) { false };
      };
    };
  };

  public func mixedCurrencyRejected() : TestResult {
    let result = Boundary.build(
      baseRequest([
        {
          account_id = "ACC-DEBIT";
          direction = #Debit;
          amount = 100;
          currency = "USD";
        },
        {
          account_id = "ACC-CREDIT";
          direction = #Credit;
          amount = 100;
          currency = "EUR";
        }
      ])
    );

    {
      name = "mixed currency rejected";
      passed = switch (result) {
        case (#err(#InvalidPosting)) { true };
        case (#err(_)) { false };
        case (#ok(_)) { false };
      };
    };
  };

  public func emptyLinesRejected() : TestResult {
    let result = Boundary.build(baseRequest([]));

    {
      name = "empty lines rejected";
      passed = switch (result) {
        case (#err(#NoLines)) { true };
        case (#err(_)) { false };
        case (#ok(_)) { false };
      };
    };
  };

  public func invalidAmountRejected() : TestResult {
    let result = Boundary.build(
      baseRequest([
        {
          account_id = "ACC-001";
          direction = #Debit;
          amount = 0;
          currency = "USD";
        }
      ])
    );

    {
      name = "invalid amount rejected";
      passed = switch (result) {
        case (#err(#InvalidAmount)) { true };
        case (#err(_)) { false };
        case (#ok(_)) { false };
      };
    };
  };
}
