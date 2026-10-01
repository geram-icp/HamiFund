import Array "mo:base/Array";
import Types "./Types";
import Posting "./Posting";

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

  public func empty() : Store {
    {
      events = [];
      entries = [];
    };
  };

  public func containsEvent(
    store : Store,
    event_id : Types.EventId
  ) : Bool {
    Array.find<Types.FinancialEvent>(
      store.events,
      func(event) {
        event.event_id == event_id
      }
    ) != null;
  };

  public func containsEntry(
    store : Store,
    entry_id : Types.EntryId
  ) : Bool {
    Array.find<Types.LedgerEntry>(
      store.entries,
      func(entry) {
        entry.entry_id == entry_id
      }
    ) != null;
  };

  public func append(
    store : Store,
    event : Types.FinancialEvent,
    entries : [Types.LedgerEntry]
  ) : { #ok : (Store, AppendResult); #err : StoreError } {

    if (event.event_id == "") {
      return #err(#InvalidEvent);
    };

    if (containsEvent(store, event.event_id)) {
      return #err(#DuplicateEvent);
    };

    for (entry in entries.vals()) {
      if (containsEntry(store, entry.entry_id)) {
        return #err(#DuplicateEntry);
      };
    };

    switch (Posting.validateEvent(event, entries)) {
      case (#err(_)) {
        return #err(#InvalidPosting);
      };
      case (#ok(_)) {};
    };

    let updatedEvents = Array.append<Types.FinancialEvent>(
      store.events,
      [event]
    );

    let updatedEntries = Array.append<Types.LedgerEntry>(
      store.entries,
      entries
    );

    (
      #ok(
        (
          {
            events = updatedEvents;
            entries = updatedEntries;
          },
          {
            event_id = event.event_id;
            entry_count = entries.size();
          }
        )
      )
    );
  };
}
