class Ability
  include CanCan::Ability

  def initialize(current_user)
    if current_user.nil?

    elsif current_user.superadmin? or current_user.has_role? 'admin'
      can :manage, :all
      cannot :destroy, User

    elsif current_user.has_role? 'chief'
      can :manage, Admin
      can [:read, :create, :update], User
      can :manage, Service
      can [:read, :assign, :accept, :finish, :process_feedback], Business
      can :manage, Task
      can [:read, :create, :add_feedback], Business

    elsif current_user.has_role? 'staff'
      can :manage, Admin
      can [:read, :accept, :finish], Business
      can [:read, :accept, :finish], Task
      can [:read, :create, :add_feedback], Business

    else
      can :manage, Admin
      can [:read, :create, :add_feedback], Business
    end
  end
end

