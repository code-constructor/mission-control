module MissionControl
  module Commands
    module DSL
      def command(command, action, *args)
        ::MissionControl::Commands::Dispatcher.call(command, action, *args)
      end
    end
  end
end