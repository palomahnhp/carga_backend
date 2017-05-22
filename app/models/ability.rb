class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    if user.superadmin_role?
      can :manage, :all
    end
    elsif user.admin_role?
    end
    elsif user.respondent_role?
    end
end
