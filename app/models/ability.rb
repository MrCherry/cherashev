class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    if user.admin?
      can :manage, :all
      can :manage, Page
      can :manage, FileUpload
    else
      can :read, :all
      can :read, Page
      cannot :read, FileUpload
    end
  end
end
