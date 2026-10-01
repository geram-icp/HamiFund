import Types "./Types";
import Semantics "../Accounting/Semantics";

module {
  public type ClassificationError = {
    #UnclassifiedAccountKind;
  };

  public type ClassificationPolicy = {
    personal : Semantics.AccountClass;
    institutional : Semantics.AccountClass;
    treasury : Semantics.AccountClass;
    settlement : Semantics.AccountClass;
    system_account : Semantics.AccountClass;
  };

  public func classify(
    kind : Types.AccountKind,
    policy : ClassificationPolicy
  ) : { #ok : Semantics.AccountClass; #err : ClassificationError } {
    switch (kind) {
      case (#Personal) {
        #ok(policy.personal);
      };
      case (#Institutional) {
        #ok(policy.institutional);
      };
      case (#Treasury) {
        #ok(policy.treasury);
      };
      case (#Settlement) {
        #ok(policy.settlement);
      };
      case (#System) {
        #ok(policy.system_account);
      };
    };
  };
}
