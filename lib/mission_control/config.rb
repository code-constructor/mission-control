require 'singleton'

module MissionControl
  class Config
    include Singleton

    # TODO extract to initialize
    ActiveSupport::Inflector.inflections do |inflect|
      inflect.singular('rails', 'rails')
      inflect.singular('ios', 'ios')
    end

    def commands_path
      File.expand_path('../../../commands', __FILE__)
    end

    def commands_namespace
      ::MissionControl::Console::Commands
    end

    def projects_path
      File.expand_path('../../../projects', __FILE__)
    end

    def templates_path
      "#{projects_path}/templates"
    end

    def projects_namespace
      ::MissionControl::Projects
    end

    def hidden_projects
      []
    end
  end
end