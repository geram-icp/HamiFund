import Types "./Types";

module {
  public type StoreError = {
    #DuplicateEvent;
    #DuplicateEntry;
    #EventNotFound;
    #InvalidEvent;
  };

  public type AppendResult = {
    event_id : Types.EventId;
    entry_count : Nat;
  };

  public type EventStore = {
    append : (
      event : Types.FinancialEvent,
      entries : [Types.LedgerEntry]
    ) -> { #ok : AppendResult; #err : StoreError };

    containsEvent : (
      event_id : Types.EventId
    ) -> Bool;
  };
}
