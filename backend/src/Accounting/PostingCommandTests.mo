import Contracts "../Core/Contracts/Command";
import Boundary "./PostingBoundary";
import Handler "./PostingCommandHandler";

module {

  public type TestResult = {
    name : Text;
    passed : Bool;
  };

  func validCommand() : Contracts.Command {
    {
      command_id = "CMD-001";
      command_type = "POST_FINANCIAL_EVENT";
      correlation_id = "CORR-001";
      idempotency_key = "IDEMP-001";
      actor_id = "ACTOR-001";
      timestamp = 1000;
    };
  };

  func validRequest() : Boundary.PostingRequest {
    {
      event_id = "EVT-CMD-001";
      event_type = "TEST_POSTING";
      correlation_id = "CORR-001";
      occurred_at = 1000;
      recorded_at = 1001;
      lines = [
        {
          account_id = "ACC-DEBIT";
          direction = #Debit;
          amount = 100;
          currency = "USD";
        },
        {
          account_id = "ACC-CREDIT";
          direction = #Credit;
          amount = 100;
          currency = "USD";
        }
      ];
    };
  };

  public func validCommandAccepted() : TestResult {
    let result = Handler.handle(
      validCommand(),
      validRequest()
    );

    {
      name = "valid posting command accepted";
      passed = switch (result) {
        case (#ok(value)) {
          value.command_id == "CMD-001"
            and value.intent.entries.size() == 2;
        };
        case (#err(_)) {
          false;
        };
      };
    };
  };

  public func invalidCommandTypeRejected() : TestResult {
    let command : Contracts.Command = {
      command_id = "CMD-002";
      command_type = "UNKNOWN_COMMAND";
      correlation_id = "CORR-002";
      idempotency_key = "IDEMP-002";
      actor_id = "ACTOR-001";
      timestamp = 1000;
    };

    let result = Handler.handle(
      command,
      validRequest()
    );

    {
      name = "invalid command type rejected";
      passed = switch (result) {
        case (#err(#InvalidCommand(#InvalidCommandType))) { true };
        case (#err(_)) { false };
        case (#ok(_)) { false };
      };
    };
  };

  public func emptyActorRejected() : TestResult {
    let command : Contracts.Command = {
      command_id = "CMD-003";
      command_type = "POST_FINANCIAL_EVENT";
      correlation_id = "CORR-003";
      idempotency_key = "IDEMP-003";
      actor_id = "";
      timestamp = 1000;
    };

    let result = Handler.handle(
      command,
      validRequest()
    );

    {
      name = "empty actor rejected";
      passed = switch (result) {
        case (#err(#InvalidCommand(#EmptyActor))) { true };
        case (#err(_)) { false };
        case (#ok(_)) { false };
      };
    };
  };

  public func invalidPostingRejected() : TestResult {
    let invalidRequest : Boundary.PostingRequest = {
      event_id = "EVT-CMD-002";
      event_type = "TEST_POSTING";
      correlation_id = "CORR-004";
      occurred_at = 1000;
      recorded_at = 1001;
      lines = [
        {
          account_id = "ACC-DEBIT";
          direction = #Debit;
          amount = 100;
          currency = "USD";
        },
        {
          account_id = "ACC-CREDIT";
          direction = #Credit;
          amount = 90;
          currency = "USD";
        }
      ];
    };

    let result = Handler.handle(
      validCommand(),
      invalidRequest
    );

    {
      name = "invalid posting rejected by handler";
      passed = switch (result) {
        case (#err(#InvalidPosting(_))) { true };
        case (#err(_)) { false };
        case (#ok(_)) { false };
      };
    };
  };
}
