import Types "./Types";

module {
  public type TransitionError = {
    #InvalidTransition;
    #AlreadyClosed;
    #AlreadyActive;
  };

  public func activate(
    status : Types.AccountStatus
  ) : { #ok : Types.AccountStatus; #err : TransitionError } {
    switch (status) {
      case (#Pending) { #ok(#Active) };
      case (#Active) { #err(#AlreadyActive) };
      case (#Restricted) { #err(#InvalidTransition) };
      case (#Suspended) { #err(#InvalidTransition) };
      case (#Closed) { #err(#AlreadyClosed) };
    };
  };

  public func restrict(
    status : Types.AccountStatus
  ) : { #ok : Types.AccountStatus; #err : TransitionError } {
    switch (status) {
      case (#Active) { #ok(#Restricted) };
      case (#Restricted) { #ok(#Restricted) };
      case (_) { #err(#InvalidTransition) };
    };
  };

  public func suspend(
    status : Types.AccountStatus
  ) : { #ok : Types.AccountStatus; #err : TransitionError } {
    switch (status) {
      case (#Active) { #ok(#Suspended) };
      case (#Restricted) { #ok(#Suspended) };
      case (#Suspended) { #ok(#Suspended) };
      case (_) { #err(#InvalidTransition) };
    };
  };

  public func close(
    status : Types.AccountStatus
  ) : { #ok : Types.AccountStatus; #err : TransitionError } {
    switch (status) {
      case (#Active) { #ok(#Closed) };
      case (#Restricted) { #ok(#Closed) };
      case (#Suspended) { #ok(#Closed) };
      case (#Closed) { #err(#AlreadyClosed) };
      case (#Pending) { #err(#InvalidTransition) };
    };
  };
}
