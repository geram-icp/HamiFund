import Contracts "../Core/Contracts/Command";
import Boundary "./PostingBoundary";

module {

  public type PostingCommand = {
    command : Contracts.Command;
    request : Boundary.PostingRequest;
  };

  public type ValidationError = {
    #EmptyCommandId;
    #EmptyCommandType;
    #EmptyCorrelationId;
    #EmptyIdempotencyKey;
    #EmptyActor;
    #InvalidCommandType;
  };

  public func validate(
    command : Contracts.Command
  ) : { #ok : Contracts.Command; #err : ValidationError } {

    if (command.command_id == "") {
      return #err(#EmptyCommandId);
    };

    if (command.command_type == "") {
      return #err(#EmptyCommandType);
    };

    if (command.correlation_id == "") {
      return #err(#EmptyCorrelationId);
    };

    if (command.idempotency_key == "") {
      return #err(#EmptyIdempotencyKey);
    };

    if (command.actor_id == "") {
      return #err(#EmptyActor);
    };

    if (command.command_type != "POST_FINANCIAL_EVENT") {
      return #err(#InvalidCommandType);
    };

    #ok(command);
  };
}
