module {
  public type Identifier = {
    namespace : Text;
    value : Text;
  };

  public type Version = {
    major : Nat;
    minor : Nat;
    patch : Nat;
  };

  public type Timestamp = Int;

  public type Correlation = {
    correlation_id : Text;
    causation_id : ?Text;
  };

  public type IdempotencyKey = Text;

  public type ExternalReference = {
    system : Text;
    reference : Text;
  };

  public type MonetaryValue = {
    currency : Text;
    amount : Int;
  };

  public type AuditReference = {
    event_id : Text;
    timestamp : Int;
  };
}
