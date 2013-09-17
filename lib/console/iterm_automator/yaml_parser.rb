require 'yaml'

module ItermAutomator
  class YAMLParser
    def initialize(path)
      @hash = ::YAML::load_file(path)
    end

    def parse
      dispatch(@hash)
    end

    def dispatch(hash)
      hash.each do |key, value|
        send(key, value)
      end
    end

    private

    def dir(path)
      @dir = path
    end

    def iterm(hash)
      self.dispatch(hash)
    end

    def window(hash)
      contexts << automator_term.open_window
      self.dispatch(hash)
      contexts.pop
    end

    def tab(hash)
      contexts << automator_term.open_tab
      self.dispatch(hash)
      contexts.pop
    end

    def commands(values)
      automator_term.execute_command("cd #{@dir}", contexts.last)

      values.each do |value|
        execute(value, contexts.last)
      end
    end

    def execute(value, context)
      if dispatcher.action_exists?(value)
        value = dispatcher.call_action(value)
      end

      automator_term.execute_command(value, contexts.last)
    end

    def verticle(hash)
      contexts << automator_term.vertical_split
      self.dispatch(hash)
      contexts.pop
    end

    def horizontal(hash)
      contexts << automator_term.horizontal_split
      self.dispatch(hash)
      contexts.pop
    end

    def automator_term
      @automator_term ||= ItermAutomator::Iterm.new
    end

    def dispatcher
      @dispatcher ||= ::MissionControle::Console::Actions::Dispatch.new
    end

    def contexts
      @contexts ||= []
    end
  end
end