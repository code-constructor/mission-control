module MissionControl
  class Shell < Bombshell::Environment
    include Bombshell::Shell

    prompt_with 'mission-control'

    def projects
      MissionControl::Projects::Shell.launch
    end
  end
end