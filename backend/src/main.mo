import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import LedgerTestRunner "./Ledger/TestRunner";

persistent actor HamiFund {
  public query func ledgerVerification() : async Text {
    let summary = LedgerTestRunner.run();
    "Ledger Tests | total=" # Nat.toText(summary.total)
      # " | passed=" # Nat.toText(summary.passed)
      # " | failed=" # Nat.toText(summary.failed);
  };

  public query ({ caller }) func health() : async Text {
    if (Principal.isAnonymous(caller)) {
      return "HamiFund OK | anonymous";
    };
    "HamiFund OK | authenticated";
  };
}
