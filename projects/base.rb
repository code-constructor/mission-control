module MissionControl
  module Projects
    class Base
      include MissionControl::Console::Iterm::DSL
      include MissionControl::Console::Commands::DSL
    end
  end
end