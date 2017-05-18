module Abilities
  class Admin
    include CanCan::Ability

    def initialize(user)
      cannot :settings, WelcomeController
    end

  end
end
