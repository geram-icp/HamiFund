import TestVectors "./TestVectors";

module {
  public type TestSummary = {
    total : Nat;
    passed : Nat;
    failed : Nat;
  };

  public func run() : TestSummary {
    let results = [
      TestVectors.balancedEvent(),
      TestVectors.unbalancedEvent(),
      TestVectors.emptyEvent(),
      TestVectors.multiCurrencyEvent()
    ];

    var passed : Nat = 0;

    for (result in results.vals()) {
      if (result.passed) {
        passed += 1;
      };
    };

    {
      total = results.size();
      passed = passed;
      failed = results.size() - passed;
    };
  };
}
