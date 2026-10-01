module {
  public type Subject = {
    subject_id : Text;
  };

  public type Resource = {
    resource_type : Text;
    resource_id : Text;
  };

  public type Action = {
    action : Text;
  };

  public type AuthorizationDecision = {
    #Allow;
    #Deny;
  };

  public type AuthorizationRequest = {
    subject : Subject;
    resource : Resource;
    action : Action;
  };
}
