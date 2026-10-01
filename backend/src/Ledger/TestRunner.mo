import TestVectors "./TestVectors";
import ProjectionTests "./ProjectionTests";
import FinancialStateTests "../Query/FinancialStateTests";
import SemanticsTests "../Accounting/SemanticsTests";
import AccountAccountingTests "../Account/AccountingTests";

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
      ProjectionTests.voidedIgnored(),

      FinancialStateTests.accountStateFromProjection(),

      SemanticsTests.assetNormalBalance(),
      SemanticsTests.liabilityNormalBalance(),
      SemanticsTests.revenueNormalBalance(),
      SemanticsTests.expenseNormalBalance(),

      SemanticsTests.assetSignedBalance(),
      SemanticsTests.liabilitySignedBalance(),
      SemanticsTests.revenueSignedBalance(),
      SemanticsTests.expenseSignedBalance(),

      AccountAccountingTests.personalMapping(),
      AccountAccountingTests.treasuryMapping(),
      AccountAccountingTests.settlementMapping(),
      AccountAccountingTests.systemMapping(),
      AccountAccountingTests.classesRemainIndependent()
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
