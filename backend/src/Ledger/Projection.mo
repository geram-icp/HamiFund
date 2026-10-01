import Types "./Types";

module {
  public type AccountBalance = {
    account_id : Text;
    currency : Text;
    debit : Int;
    credit : Int;
    available : Int;
  };

  public func projectAccount(
    account_id : Text,
    currency : Text,
    entries : [Types.LedgerEntry]
  ) : AccountBalance {

    var debit : Int = 0;
    var credit : Int = 0;

    for (entry in entries.vals()) {
      if (
        entry.account_id == account_id
        and entry.currency == currency
        and entry.status == #Posted
      ) {
        switch (entry.direction) {
          case (#Debit) {
            debit += entry.amount;
          };
          case (#Credit) {
            credit += entry.amount;
          };
        };
      };
    };

    {
      account_id = account_id;
      currency = currency;
      debit = debit;
      credit = credit;
      available = credit - debit;
    };
  };
}
