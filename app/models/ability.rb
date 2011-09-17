class Ability
  include CanCan::Ability

  def initialize(current_user)
    if current_user.nil?

    elsif current_user.superadmin? or current_user.has_role? 'admin'
      can :manage, :all

    elsif current_user.has_role? 'chief'
      can :manage, Admin
      can [:read, :create, :update], User
      can :manage, Service
      can [:read, :update], Business
      can :manage, Task

    elsif current_user.has_role? 'staff'
      can :manage, Admin
      can [:read, :update], Business
      can [:read, :update], Task
    else

    end
  end
end

