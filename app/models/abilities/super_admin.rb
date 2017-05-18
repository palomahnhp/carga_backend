module Abilities
  class SuperAdmin
    include CanCan::Ability

    def initialize(user)
      can :manage, :all
    end

  end
end
