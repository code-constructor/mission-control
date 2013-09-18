module MissionControl
  module Console
    module Commands
      class Dispatcher
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
          clazz(name).constantize.new
        end

        def clazz(name)
          "MissionControl::Console::Commands::#{name.to_s.classify}"
        end

        def files
          Dir[File.expand_path('../../../../../commands/*.rb', __FILE__)]
        end
      end
    end
  end
end