import Types "./Types";

module {
  public type StoreError = {
    #DuplicateEvent;
    #DuplicateEntry;
    #InvalidEvent;
    #InvalidPosting;
  };

  public type AppendResult = {
    event_id : Types.EventId;
    entry_count : Nat;
  };

  public type Store = {
    events : [Types.FinancialEvent];
    entries : [Types.LedgerEntry];
  };

  public type EventStore = {
    empty : () -> Store;

    append : (
      store : Store,
      event : Types.FinancialEvent,
      entries : [Types.LedgerEntry]
    ) -> { #ok : (Store, AppendResult); #err : StoreError };

    containsEvent : (
      store : Store,
      event_id : Types.EventId
    ) -> Bool;
  };
}
