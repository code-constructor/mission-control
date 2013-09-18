module MissionControl
  module Projects
    class Base
      include MissionControl::Console::Iterm::DSL
      include MissionControl::Console::Actions::Browser
    end
  end
end