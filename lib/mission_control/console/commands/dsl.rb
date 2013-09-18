module MissionControl
  module Console
    module Commands
      module DSL
        def command(command, action, *args)
          @commands_dispatcher ||= MissionControl::Console::Commands::Dispatcher.new

          @commands_dispatcher.call(command, action, *args)
        end
      end
    end
  end
end