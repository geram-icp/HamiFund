import Types "./Types";

module {
  public type ValidationError = {
    #EmptyAccountId;
    #EmptyIdentityId;
    #InvalidAccountKind;
  };

  public func validate(
    account : Types.Account
  ) : { #ok : (); #err : ValidationError } {

    if (account.account_id == "") {
      return #err(#EmptyAccountId);
    };

    if (account.identity_id == "") {
      return #err(#EmptyIdentityId);
    };

    #ok(());
  };
}
