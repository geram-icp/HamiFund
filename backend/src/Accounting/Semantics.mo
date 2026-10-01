module {
  public type AccountClass = {
    #Asset;
    #Liability;
    #Equity;
    #Revenue;
    #Expense;
  };

  public type NormalBalance = {
    #Debit;
    #Credit;
  };

  public func normalBalance(
    account_class : AccountClass
  ) : NormalBalance {
    switch (account_class) {
      case (#Asset) { #Debit };
      case (#Expense) { #Debit };
      case (#Liability) { #Credit };
      case (#Equity) { #Credit };
      case (#Revenue) { #Credit };
    };
  };

  public func signedBalance(
    account_class : AccountClass,
    debit : Int,
    credit : Int
  ) : Int {
    switch (normalBalance(account_class)) {
      case (#Debit) {
        debit - credit;
      };
      case (#Credit) {
        credit - debit;
      };
    };
  };
}
