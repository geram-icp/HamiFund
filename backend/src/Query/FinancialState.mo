import Types "../Ledger/Types";
import Projection "../Ledger/Projection";

module {
  public type AccountState = {
    account_id : Text;
    currency : Text;
    debit : Int;
    credit : Int;
    available : Int;
  };

  public func accountState(
    account_id : Text,
    currency : Text,
    entries : [Types.LedgerEntry]
  ) : AccountState {
    Projection.projectAccount(
      account_id,
      currency,
      entries
    );
  };
}
