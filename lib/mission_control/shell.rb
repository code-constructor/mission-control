module MissionControl
  class Shell < Bombshell::Environment
    include Bombshell::Shell

    prompt_with 'mission-control'

    def projects
      MissionControl::Projects::Shell.launch
    end

    private
    def dispatcher
      @dispatcher ||= MissionControl::Projects::Dispatcher.new
    end
  end
end