module MissionControl
end

require 'bombshell'
require 'active_support/inflector'

require 'mission_control/class_extension'

require 'mission_control/config'

require 'mission_control/commands/dsl'
require 'mission_control/commands/dispatcher'

require 'mission_control/console/iterm/api'
require 'mission_control/console/iterm/dsl'

require 'mission_control/models/project'

require 'mission_control/projects/dsl'
require 'mission_control/projects/base'
require 'mission_control/projects/creator'
require 'mission_control/projects/help'

require 'mission_control/shells/main'
require 'mission_control/shells/project'

[
  MissionControl::Config.instance.projects_path,
  MissionControl::Config.instance.commands_path,
].each do |path|
    $:.unshift(path) unless $:.include?(path)
end