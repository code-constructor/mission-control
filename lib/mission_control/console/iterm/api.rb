require 'appscript'
require File.expand_path('../dsl', __FILE__)

# Consular Core to interact with iTerm2 for Mac OS X
#
module MissionControl
  module Console
    module Iterm
      class Api
        # Initializes a reference to the iTerm.app via appscript
        #
        # @api public
        def initialize
          @iterm = Appscript.app('iTerm')
        end

        def open_tab
          window = iterm.current_terminal
          session = window.launch_(session: 'New Session')
        end

        def close_tab(tab = nil)
          tab ||= active_tab

          # TODO add checking if window opening process is ready
          sleep(0.1)

          tab.terminate
        end

        def open_window
          window = iterm.make(new: :terminal)
          window.launch_(session: 'New session')
        end

        def active_window
          iterm.current_terminal
        end

        def active_tab
          active_window.current_session
        end

        def execute_command(command, context = nil)
          # TODO add checking if window opening process is ready
          sleep(0.1)

          context ||= active_tab
          context.write(text: command)
        end

        def horizontal_split
          call_ui_action('Shell', nil, 'Split Horizontally with Current Profile')

          active_tab
        end

        def vertical_split
          call_ui_action('Shell', nil, 'Split Vertically with Current Profile')

          active_tab
        end

        def iterm
          @iterm
        end

        private

        def iterm_menu
          _process = Appscript.app("System Events").processes["iTerm"]
          _process.menu_bars.first
        end

        def call_ui_action(menu, submenu, action)
          menu = iterm_menu.menu_bar_items[menu].menus[menu]
          menu = menu.menu_items[submenu].menus[submenu] if submenu
          menu.menu_items[action].click
        end
      end
    end
  end
end