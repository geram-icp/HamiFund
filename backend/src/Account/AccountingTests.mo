import Types "./Types";
import Accounting "./Accounting";
import Semantics "../Accounting/Semantics";

module {
  public type TestResult = {
    name : Text;
    passed : Bool;
  };

  let policy : Accounting.ClassificationPolicy = {
    personal = #Asset;
    institutional = #Asset;
    treasury = #Asset;
    settlement = #Liability;
    system_account = #Equity;
  };

  public func personalMapping() : TestResult {
    let result = Accounting.classify(#Personal, policy);

    {
      name = "PERSONAL_TO_ASSET";
      passed =
        switch (result) {
          case (#ok(#Asset)) { true };
          case (_) { false };
        };
    };
  };

  public func treasuryMapping() : TestResult {
    let result = Accounting.classify(#Treasury, policy);

    {
      name = "TREASURY_TO_ASSET";
      passed =
        switch (result) {
          case (#ok(#Asset)) { true };
          case (_) { false };
        };
    };
  };

  public func settlementMapping() : TestResult {
    let result = Accounting.classify(#Settlement, policy);

    {
      name = "SETTLEMENT_TO_LIABILITY";
      passed =
        switch (result) {
          case (#ok(#Liability)) { true };
          case (_) { false };
        };
    };
  };

  public func systemMapping() : TestResult {
    let result = Accounting.classify(#System, policy);

    {
      name = "SYSTEM_TO_EQUITY";
      passed =
        switch (result) {
          case (#ok(#Equity)) { true };
          case (_) { false };
        };
    };
  };

  public func classesRemainIndependent() : TestResult {
    let businessKind : Types.AccountKind = #Settlement;
    let accountingClass : Semantics.AccountClass = #Liability;

    {
      name = "BUSINESS_TYPE_INDEPENDENT";
      passed =
        switch (businessKind, accountingClass) {
          case (#Settlement, #Liability) { true };
          case (_) { false };
        };
    };
  };
}
