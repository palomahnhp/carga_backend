module Abilities
  class Respondent
    include CanCan::Ability

    def initialize(user)
      cannot :tracking, WelcomeController
      cannot :settings, WelcomeController
      cannot :admin_panel, WelcomeController

      can [:show_mail], WelcomeController

      # Add and override permissions
      user.loggable.permissions.each do |permission|
        resource_class = permission.resource.class_name
        permission.permitted_actions.each do |permitted_action|
          can permitted_action, resource_class
        end
      end
    end

  end
end
