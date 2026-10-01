import Principal "mo:base/Principal";

persistent actor HamiFund {
  public query ({ caller }) func health() : async Text {
    if (Principal.isAnonymous(caller)) {
      return "HamiFund OK | anonymous";
    };
    "HamiFund OK | authenticated";
  };
}
