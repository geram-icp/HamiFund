import Authorization "../Core/Authorization";

module {

  public type AuthorizationError = {
    #Denied;
  };

  public func authorize(
    command : {
      actor_id : Text;
      command_id : Text;
    }
  ) : {
    #ok : Authorization.AuthorizationDecision;
    #err : AuthorizationError
  } {

    if (command.actor_id == "") {
      return #err(#Denied);
    };

    #ok(#Allow);
  };
}
