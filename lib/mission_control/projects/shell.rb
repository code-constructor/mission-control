module MissionControl
  module Projects
    class Shell < Bombshell::Environment
      include Bombshell::Shell

      prompt_with 'projects'

      def open(name)
        name = beautify_name(name)

        dispatcher.project(name).run
      end

      def all
        dispatcher.projects.each do |key, value|
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
      def beautify_name(name)
        name = name.to_s
        name = name.delete(' ')
        name = name.underscore

        name
      end

      def dispatcher
        @dispatcher ||= MissionControl::Projects::Dispatcher.new
      end

      def creator
        @creator ||= MissionControl::Projects::Creater.new
      end
    end
  end
end