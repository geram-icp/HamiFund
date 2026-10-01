module {
  public type Query = {
    query_id : Text;
    query_type : Text;
    correlation_id : Text;
    actor : Text;
    timestamp : Int;
  };
}
