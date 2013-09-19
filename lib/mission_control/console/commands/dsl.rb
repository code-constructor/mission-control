module MissionControl
  module Console
    module Commands
      module DSL
        def command(command, action, *args)
          ::MissionControl::Console::Commands::Dispatcher.call(command, action, *args)
        end
      end
    end
  end
end