module MissionControl
  module Console
    module Commands
      class Dispatcher
        def self.call(command, action, *args)
          self.object.call(command, action, *args)
        end

        def self.object
          @object ||= self.new
        end

        def initialize
          require_file
        end

        def call(command, action, *args)
          object(command).send(action, *args)
        end

        private

        def require_file
          files.each do |file|
            require file
          end
        end

        def object(name)
          clazz(name).new
        end

        def clazz(name)
          "#{config.commands_namespace}::#{name.to_s.classify}".constantize
        end

        def files
          ::Dir["#{config.commands_path}/**/*.rb"]
        end

        def config
          ::MissionControl::Config.instance
        end
      end
    end
  end
end