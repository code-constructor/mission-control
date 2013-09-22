module MissionControl
  module Projects
    class Help
      def projects(projects)
        rows = projects.inject([]) do |rows, project|
          rows << [
            project.name,
            project.description,
          ]
        end

        puts Terminal::Table.new(
          title: "Projects",
          headings: ['Name', 'Desc'],
          rows: rows
        )
      end

      def actions
        rows = []

        rows << [
          'all',
          'Print all available projects',
        ]

        rows << :separator
        rows << [
          'open(name)',
          'Open a project',
          '- name: of the project'
        ]

        rows << :separator
        rows << [
          'create(name, template = default)',
          "Create a new project at the defined \nprojects path (see config.rb in lib directory).",
          "- name: of the project as symbol in snakecase\n- template: to generate the project file. Default \nis the mission-control provided template.",
        ]

        rows << :separator
        rows << [
          'reload',
          "Load new projects into mission-control.",
        ]

        rows << :separator
        rows << [
          'quit',
          "Close projects subshell",
        ]

        puts "Use tab for autocompletion!\n"

        puts Terminal::Table.new(
          title: "Actions",
          headings: ['NAME', 'DESC', 'PARAMS'],
          rows: rows,
        )
      end
    end
  end
end