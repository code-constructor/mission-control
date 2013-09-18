module MissionControl
end

require 'bombshell'
require 'active_support/inflector'

require 'lib/mission_control/console/commands/dsl'
require 'lib/mission_control/console/commands/dispatcher'
require 'lib/mission_control/console/iterm/api'
require 'lib/mission_control/console/iterm/dsl'

require 'lib/mission_control/projects/creator'
require 'lib/mission_control/projects/dispatcher'

require 'lib/mission_control/shell'
require 'lib/mission_control/projects/shell'

require 'projects/base'