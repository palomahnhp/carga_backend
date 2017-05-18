class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role? :super_admin
      can :manage, :all
    end
  elsif user.role? :admin
    end
  elsif user.role? :superadmin
  end
end
