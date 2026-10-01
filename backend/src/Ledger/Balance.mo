import Types "./Types";

module {
  public type BalanceError = {
    #NegativeAmount;
    #EmptyCurrency;
    #CurrencyMismatch;
    #UnbalancedEvent;
  };

  public func validateEntry(
    entry : Types.LedgerEntry
  ) : { #ok : (); #err : BalanceError } {

    if (entry.amount <= 0) {
      return #err(#NegativeAmount);
    };

    if (entry.currency == "") {
      return #err(#EmptyCurrency);
    };

    #ok(());
  };

  public func isBalanced(
    debit : Int,
    credit : Int
  ) : Bool {
    debit == credit;
  };
}
