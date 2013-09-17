require 'active_support/inflector'

module MissionControl
  module Console
    module Actions
      class Dispatcher
        def initialize
          load_classes
        end

        def action_exists?(action)
          name = action.classify

          action_classes.include?(name.to_sym)
        end

        def call_action(action, *args)
          if action_exists?(action)
            name = class_name(action)
            object = name.constantize.new

            object.call(*args)
          else
            raise "No action available for #{class_name(action)}"
          end
        end

        private
        def load_classes
          load_paths.each do |path|
            require path
          end
        end

        def load_paths
          Dir[File.expand_path('../*.rb', __FILE__)]
        end

        def action_classes
          scope.constants
        end

        def class_name(action)
          "#{scope}::#{action.classify}"
        end

        def scope
          ::MissionControle::Console::Actions
        end
      end
    end
  end
end
