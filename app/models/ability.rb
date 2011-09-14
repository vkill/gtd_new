class Ability
  include CanCan::Ability

  def initialize(current_user)
    if current_user.nil?

    elsif current_user.superadmin? or current_user.has_role? 'admin'
      can :manage, :all

    elsif current_user.has_role? 'chief'

    elsif current_user.has_role? 'staff'

    else

    end
  end
end

