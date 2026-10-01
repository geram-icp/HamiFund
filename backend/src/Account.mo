module {
  public type AccountId = Text;

  public type AccountKind = {
    #Personal;
    #Institutional;
    #Treasury;
    #Settlement;
    #System;
  };

  public type AccountStatus = {
    #Pending;
    #Active;
    #Restricted;
    #Suspended;
    #Closed;
  };

  public type Account = {
    account_id : AccountId;
    identity_id : Text;
    kind : AccountKind;
    status : AccountStatus;
    created_at : Int;
    updated_at : Int;
  };
}
