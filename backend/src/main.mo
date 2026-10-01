import Principal "mo:base/Principal";

actor HamiFund {
  public query ({ caller }) func health() : async Text {
    if (Principal.isAnonymous(caller)) {
      return "HamiFund OK | anonymous";
    };
    "HamiFund OK | authenticated";
  };
}
