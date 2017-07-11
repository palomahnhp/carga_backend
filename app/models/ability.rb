class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    if user.superadmin_role?
      can :manage, :all
    elsif user.admin_role?
      can :manage, :all
      can :settings
    else
      cannot :settings
      cannot :tracking
      cannot :show_mail
      cannot :admin_panel
    end

  end
end
