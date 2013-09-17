require File.expand_path('../dsl', __FILE__)

module MissionControl
  module Console
    module Iterm
      module DSL
        def iterm
          @iterm ||= Api.new
        end

        def window(&block)
          context = iterm.open_window

          # TODO add checking if window opening process is ready
          sleep(0.1)

          execute_block(context, &block)
        end

        def tab(&block)
          context = iterm.open_tab

          # TODO add checking if window opening process is ready
          sleep(0.1)

          execute_block(context, &block)
        end

        def verticle_pane(&block)
          context = iterm.vertical_split

          # TODO add checking if window opening process is ready
          sleep(0.1)

          execute_block(context, &block)
        end

        def horizontal_pane(&block)
          context = iterm.horizontal_split

          # TODO add checking if window opening process is ready
          sleep(0.1)

          execute_block(context, &block)
        end

        def execute(command)
          # TODO add checking if window opening process is ready
          sleep(0.1)

          iterm.execute_command(command, current_context)
        end

        private

        def execute_block(context, &block)
          if block_given?
            contexts.push(context)
            instance_eval(&block)
            contexts.pop
          end
        end

        def current_context
          contexts.last
        end

        def contexts
          @contexts ||= []
        end
      end
    end
  end
end