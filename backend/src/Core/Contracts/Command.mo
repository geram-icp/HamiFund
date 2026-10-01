module {
  public type Command = {
    command_id : Text;
    command_type : Text;
    correlation_id : Text;
    idempotency_key : Text;
    actor : Text;
    timestamp : Int;
  };
}
