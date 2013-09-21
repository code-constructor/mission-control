require 'terminal-table'

module MissionControl
  module Projects
    class Shell < Bombshell::Environment
      include Bombshell::Shell

      prompt_with 'projects'

      before_launch do
        dispatcher.projects.each do |name|
          send(:define_method, name) do
            open_project(name)
          end
        end
      end

      def help
        help_actions
        help_projects
      end

      def open(name)
        open_project(name)
      end

      def all
        help_projects
      end

      def create(name, template = nil)
        name = beautify_name(name)

        creator.create(name, template)
      end

      private

      def open_project(name)
        name = beautify_name(name)

        dispatcher.project(name).run
      end

      def beautify_name(name)
        name = name.to_s
        name = name.delete(' ')

        name.underscore
      end

      def dispatcher
        @dispatcher ||= self.class.dispatcher
      end

      def self.dispatcher
        ::MissionControl::Projects::Dispatcher.new
      end

      def creator
        @creator ||= ::MissionControl::Projects::Creator.new
      end

      def help_actions
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

      def help_projects
        rows = []

        dispatcher.descriptions.each do |key, value|
          rows << [key, value]
        end

        puts Terminal::Table.new(
          title: "Projects",
          headings: ['Name', 'Desc'],
          rows: rows
        )
      end
    end
  end
end