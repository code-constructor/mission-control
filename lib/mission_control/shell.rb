module MissionControl
  class Shell < Bombshell::Environment
    include Bombshell::Shell

    prompt_with 'mission-control'

    def projects
      MissionControl::Projects::Shell.launch
    end

    def help
      rows = []

      rows << [
        'projects',
        'Open projects-subshell',
      ]

      puts "Use tab for autocompletion!\n"

      puts Terminal::Table.new(
        title: "Actions",
        headings: ['NAME', 'DESC'],
        rows: rows,
      )
    end
  end
end