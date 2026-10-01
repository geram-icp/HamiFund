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
}
