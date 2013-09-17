module MissionControl
  module Console
    module Actions
      module Browser
        def open_chrome(url)
          execute "open -a \"/Applications/Google Chrome.app\" '#{url}'"
        end
      end
    end
  end
end