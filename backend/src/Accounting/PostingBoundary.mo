import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Types "../Ledger/Types";
import Posting "../Ledger/Posting";

module {

  public type PostingLine = {
    account_id : Text;
    direction : Types.EntryDirection;
    amount : Int;
    currency : Text;
  };

  public type PostingRequest = {
    event_id : Types.EventId;
    event_type : Text;
    correlation_id : Text;
    occurred_at : Int;
    recorded_at : Int;
    lines : [PostingLine];
  };

  public type BuildError = {
    #EmptyEventId;
    #EmptyAccountId;
    #NoLines;
    #InvalidAmount;
    #EmptyCurrency;
    #Unbalanced;
    #InvalidPosting;
  };

  public type PostingIntent = {
    event : Types.FinancialEvent;
    entries : [Types.LedgerEntry];
  };

  public func build(
    request : PostingRequest
  ) : { #ok : PostingIntent; #err : BuildError } {

    if (request.event_id == "") {
      return #err(#EmptyEventId);
    };

    if (request.lines.size() == 0) {
      return #err(#NoLines);
    };

    for (line in request.lines.vals()) {
      if (line.account_id == "") {
        return #err(#EmptyAccountId);
      };

      if (line.amount <= 0) {
        return #err(#InvalidAmount);
      };

      if (line.currency == "") {
        return #err(#EmptyCurrency);
      };
    };

    let event : Types.FinancialEvent = {
      event_id = request.event_id;
      event_type = request.event_type;
      correlation_id = request.correlation_id;
      causation_id = null;
      occurred_at = request.occurred_at;
      recorded_at = request.recorded_at;
    };

    let entries : [Types.LedgerEntry] = Array.tabulate<Types.LedgerEntry>(
      request.lines.size(),
      func(index : Nat) : Types.LedgerEntry {
        let line = request.lines[index];

        {
          entry_id = request.event_id # ":" # Nat.toText(index);
          ledger_id = "MAIN";
          event_id = request.event_id;
          account_id = line.account_id;
          direction = line.direction;
          amount = line.amount;
          currency = line.currency;
          status = #Pending;
          created_at = request.recorded_at;
        }
      }
    );

    switch (Posting.validateEvent(event, entries)) {
      case (#err(_)) {
        return #err(#InvalidPosting);
      };
      case (#ok(_)) {};
    };

    #ok({
      event = event;
      entries = entries;
    });
  };
}
