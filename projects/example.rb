module MissionControl
  module Projects
    class Example
      include ItermAutomator::DSL

      def open
        tab do
          execute 'cd ~/Development/wonderweblabs/mein-eventbus-shop'
          execute 'mysql.server start'
          execute open_chrome('http://localhost:3000')

          verticle_pane do
            execute 'cd ~/Development/wonderweblabs/mein-eventbus-shop'
            execute 'rails console'

            horizontal_pane do
              execute 'cd ~/Development/wonderweblabs/mein-eventbus-shop'
              execute "rails server -p 3000"
            end
          end
        end
      end

      def open_chrome(url)
        "open -a \"/Applications/Google Chrome.app\" '#{url}'"
      end
    end
  end
end