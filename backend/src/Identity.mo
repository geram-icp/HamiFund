module {
  public type IdentityId = Text;

  public type IdentityKind = {
    #Individual;
    #Organization;
    #Institution;
    #System;
  };

  public type IdentityStatus = {
    #Pending;
    #Active;
    #Suspended;
    #Revoked;
  };

  public type Identity = {
    identity_id : IdentityId;
    kind : IdentityKind;
    status : IdentityStatus;
    created_at : Int;
    updated_at : Int;
  };

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
