import Types "./Types";
import Balance "./Balance";

module {
  public type PostingError = {
    #InvalidEvent;
    #NoEntries;
    #MixedCurrencies;
    #Unbalanced;
    #InvalidEntry;
  };

  public func validateEvent(
    event : Types.FinancialEvent,
    entries : [Types.LedgerEntry]
  ) : { #ok : (); #err : PostingError } {

    if (event.event_id == "") {
      return #err(#InvalidEvent);
    };

    if (entries.size() == 0) {
      return #err(#NoEntries);
    };

    var debit : Int = 0;
    var credit : Int = 0;
    var currency : ?Text = null;

    for (entry in entries.vals()) {
      switch (Balance.validateEntry(entry)) {
        case (#err(_)) {
          return #err(#InvalidEntry);
        };
        case (#ok(_)) {};
      };

      switch (currency) {
        case (null) {
          currency := ?entry.currency;
        };
        case (?existing) {
          if (existing != entry.currency) {
            return #err(#MixedCurrencies);
          };
        };
      };

      switch (entry.direction) {
        case (#Debit) {
          debit += entry.amount;
        };
        case (#Credit) {
          credit += entry.amount;
        };
      };
    };

    if (not Balance.isBalanced(debit, credit)) {
      return #err(#Unbalanced);
    };

    #ok(());
  };
}
