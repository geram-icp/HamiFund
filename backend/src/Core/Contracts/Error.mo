module {
  public type Error = {
    code : Text;
    message : Text;
    retryable : Bool;
  };
}
