module MissionControl
  module Projects
    class Base
      include MissionControl::Commands::DSL
      include MissionControl::Console::Iterm::DSL
      include MissionControl::Projects::DSL

      description nil
      visible true

      def exec(command, action = nil, *args)
        unless action.nil?
          command = command(command, action, *args)
        end

        execute command
      end
    end
  end
end