module {
  public type VerificationStatus = {
    #Unverified;
    #Pending;
    #Verified;
    #Rejected;
    #Expired;
  };

  public type Verification = {
    verification_id : Text;
    identity_id : Text;
    method : Text;
    status : VerificationStatus;
    verified_at : ?Int;
    expires_at : ?Int;
  };
}
