import Semantics "./Semantics";

module {
  public type TestResult = {
    name : Text;
    passed : Bool;
  };

  public func assetNormalBalance() : TestResult {
    {
      name = "ASSET_NORMAL_DEBIT";
      passed =
        Semantics.normalBalance(#Asset) == #Debit;
    };
  };

  public func liabilityNormalBalance() : TestResult {
    {
      name = "LIABILITY_NORMAL_CREDIT";
      passed =
        Semantics.normalBalance(#Liability) == #Credit;
    };
  };

  public func revenueNormalBalance() : TestResult {
    {
      name = "REVENUE_NORMAL_CREDIT";
      passed =
        Semantics.normalBalance(#Revenue) == #Credit;
    };
  };

  public func expenseNormalBalance() : TestResult {
    {
      name = "EXPENSE_NORMAL_DEBIT";
      passed =
        Semantics.normalBalance(#Expense) == #Debit;
    };
  };

  public func assetSignedBalance() : TestResult {
    let balance = Semantics.signedBalance(
      #Asset,
      500,
      125
    );

    {
      name = "ASSET_SIGNED_BALANCE";
      passed = balance == 375;
    };
  };

  public func liabilitySignedBalance() : TestResult {
    let balance = Semantics.signedBalance(
      #Liability,
      100,
      400
    );

    {
      name = "LIABILITY_SIGNED_BALANCE";
      passed = balance == 300;
    };
  };

  public func revenueSignedBalance() : TestResult {
    let balance = Semantics.signedBalance(
      #Revenue,
      50,
      450
    );

    {
      name = "REVENUE_SIGNED_BALANCE";
      passed = balance == 400;
    };
  };

  public func expenseSignedBalance() : TestResult {
    let balance = Semantics.signedBalance(
      #Expense,
      450,
      50
    );

    {
      name = "EXPENSE_SIGNED_BALANCE";
      passed = balance == 400;
    };
  };
}
