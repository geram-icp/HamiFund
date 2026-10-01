module {
  public type Result<T, E> = {
    #ok : T;
    #err : E;
  };

  public type Error = {
    code : Text;
    message : Text;
    retryable : Bool;
  };

  public type Command = {
    command_id : Text;
    command_type : Text;
    correlation_id : Text;
    idempotency_key : Text;
    actor : Text;
    timestamp : Int;
  };

  public type Query = {
    query_id : Text;
    query_type : Text;
    correlation_id : Text;
    actor : Text;
    timestamp : Int;
  };
}
