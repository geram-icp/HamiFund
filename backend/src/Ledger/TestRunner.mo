import TestVectors "./TestVectors";
import ProjectionTests "./ProjectionTests";

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
      TestVectors.multiCurrencyEvent(),
      ProjectionTests.postedEntriesCount(),
      ProjectionTests.pendingIgnored(),
      ProjectionTests.voidedIgnored()
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
