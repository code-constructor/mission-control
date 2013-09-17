module MissionControl
  module Projects
    class Dispatcher
      def initialize
        load_projects
      end

      def project(name)
        if project_exists?(name)
          project_class(name).new
        else
          raise 'Project doesen\'t exists'
        end
      end

      private

      def project_paths
        Dir[File.expand_path('../../../../projects/*.rb', __FILE__)]
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
end