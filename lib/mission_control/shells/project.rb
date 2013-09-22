require 'terminal-table'

module MissionControl
  module Shells
    class Project < Bombshell::Environment
      include Bombshell::Shell

      before_launch do
        define_project_methods
      end

      prompt_with 'projects'

      def all
        help_projects
      end

      def create(name, template = nil)
        name = beautify_name(name)

        creator.create(name, template)
      end

      def open(name)
        open_project(name)
      end


      def reload
        self.class.define_project_methods
      end

      def help
        @help ||= MissionControl::Projects::Help.new
        @help.actions
        @help.projects(self.class.model_class.all)
      end

      private

      def self.define_project_methods
        model_class.all.each do |project|
          name = project.name

          send(:define_method, name) do
            open_project(name)
          end
        end
      end

      def open_project(name)
        name = beautify_name(name)

        project = self.class.model_class.find_by_name(name)
        project.run
      end

      def beautify_name(name)
        name = name.to_s
        name = name.delete(' ')

        name.underscore.to_sym
      end

      def self.model_class
        ::MissionControl::Models::Project
      end

      def creator
        @creator ||= ::MissionControl::Projects::Creator.new
      end
    end
  end
end