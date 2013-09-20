module MissionControl
end

require 'bombshell'
require 'active_support/inflector'

require 'mission_control/config'

require 'mission_control/console/commands/dsl'
require 'mission_control/console/commands/dispatcher'
require 'mission_control/console/iterm/api'
require 'mission_control/console/iterm/dsl'

require 'mission_control/projects/dsl'
require 'mission_control/projects/base'
require 'mission_control/projects/creator'
require 'mission_control/projects/dispatcher'

require 'mission_control/shell'
require 'mission_control/projects/shell'

[
  MissionControl::Config.instance.projects_path,
  MissionControl::Config.instance.commands_path,
].each do |path|
    $:.unshift(path) unless $:.include?(path)
end