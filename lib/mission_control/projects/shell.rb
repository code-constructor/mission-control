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

      def open(name)
        open_project(name)
      end

      def all
        dispatcher.projects_descriptions.each do |key, value|
          puts "#{key} -> #{value}"
        end
      end

      def create(name)
        name = beautify_name(name)

        creator.create(name)
      end

      def method_missing(*args)
        name = beautify_name(args[0])

        if dispatcher.project_exists?(name)
          open(name)
        else
          super(*args)
        end
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
        MissionControl::Projects::Dispatcher.new
      end

      def creator
        @creator ||= MissionControl::Projects::Creater.new
      end
    end
  end
end