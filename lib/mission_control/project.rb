require 'active_support/inflector'

module MissionControl
  class Project < Bombshell::Environment
    include Bombshell::Shell

    prompt_with 'mission-control'

    def open(name)
      dispatcher.project(name).run
    end

    private
    def dispatcher
      @dispatcher ||= MissionControl::Projects::Dispatcher.new
    end
  end
end