module MissionControl
  module Console
    module Actions
      class OpenChrome
        def call(url)
          "open -a \"/Applications/Google Chrome.app\" '#{url}'"
        end
      end
    end
  end
end