import Contracts "../Core/Contracts/Command";
import Boundary "./PostingBoundary";
import Command "./PostingCommand";
import PostingAuthorization "./PostingAuthorization";

module {

  public type HandlerError = {
    #InvalidCommand : Command.ValidationError;
    #Unauthorized;
    #InvalidPosting : Boundary.BuildError;
  };

  public type PostingCommandResult = {
    command_id : Text;
    intent : Boundary.PostingIntent;
  };

  public func handle(
    command : Contracts.Command,
    request : Boundary.PostingRequest
  ) : {
    #ok : PostingCommandResult;
    #err : HandlerError;
  } {

    switch (Command.validate(command)) {
      case (#err(error)) {
        return #err(#InvalidCommand(error));
      };
      case (#ok(_)) {};
    };

    switch (
      PostingAuthorization.authorize({
        actor_id = command.actor_id;
        command_id = command.command_id;
      })
    ) {
      case (#err(_)) {
        return #err(#Unauthorized);
      };
      case (#ok(#Deny)) {
        return #err(#Unauthorized);
      };
      case (#ok(#Allow)) {};
    };

    switch (Boundary.build(request)) {
      case (#err(error)) {
        return #err(#InvalidPosting(error));
      };
      case (#ok(intent)) {
        #ok({
          command_id = command.command_id;
          intent = intent;
        });
      };
    };
  };
}
