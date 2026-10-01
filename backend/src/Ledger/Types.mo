module {
  public type LedgerId = Text;
  public type EntryId = Text;
  public type EventId = Text;

  public type EntryDirection = {
    #Debit;
    #Credit;
  };

  public type EntryStatus = {
    #Pending;
    #Posted;
    #Voided;
  };

  public type FinancialEvent = {
    event_id : EventId;
    event_type : Text;
    correlation_id : Text;
    causation_id : ?Text;
    occurred_at : Int;
    recorded_at : Int;
  };

  public type LedgerEntry = {
    entry_id : EntryId;
    ledger_id : LedgerId;
    event_id : EventId;
    account_id : Text;
    direction : EntryDirection;
    amount : Int;
    currency : Text;
    status : EntryStatus;
    created_at : Int;
  };
}
