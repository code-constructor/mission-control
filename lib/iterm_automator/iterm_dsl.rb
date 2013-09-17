module ItermAutomator
  module DSL
    def iterm
      @iterm ||= Iterm.new
    end

    def window(&block)
      context = iterm.open_window

      # TODO add checking if window opening process is ready
      sleep(0.1)

      execute_block(context, &block)
    end

    def tab(&block)
      context = iterm.open_tab

      execute_block(context, &block)
    end

    def verticle_pane(&block)
      context = iterm.vertical_split

      execute_block(context, &block)
    end

    def horizontal_pane(&block)
      context = iterm.horizontal_split

      execute_block(context, &block)
    end

    def execute(command)
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
