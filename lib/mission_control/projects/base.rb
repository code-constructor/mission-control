module MissionControl
  module Projects
    class Base
      include MissionControl::Console::Iterm::DSL
      include MissionControl::Console::Commands::DSL

      def show_in_overview?
        true
      end

      def exec(command, action = nil, *args)
        unless action.nil?
          command = command(command, action, *args)
        end

        execute command
      end
    end
  end
end