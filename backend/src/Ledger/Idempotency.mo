module {
  public type IdempotencyResult<T> = {
    #New : T;
    #Existing : T;
  };

  public func isValidKey(
    key : Text
  ) : Bool {
    key != "";
  };
}
