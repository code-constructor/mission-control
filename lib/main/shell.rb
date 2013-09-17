require 'bombshell'
require 'active_support/inflector'

module Main
  class Shell < Bombshell::Environment
    include Bombshell::Shell

    prompt_with 'mission-control'

    def project(name)
      load_projects

      if project_exists?(name)
        project = project_class(name).new

        project.open
      else
        raise 'Project doesen\'t exists'
      end
    end

    private

    def project_paths
      Dir[File.expand_path('../../../projects/*.rb', __FILE__)]
    end

    def project_class(project)
      "#{scope}::#{project.classify}".constantize
    end

    def project_classes
      classes = scope.constants

      classes
    end

    def project_exists?(project)
      project_classes.include?(project.classify.to_sym)
    end

    def load_projects
      project_paths.each do |path|
        require path
      end
    end

    def scope
      ::MissionControl::Projects
    end
  end
end