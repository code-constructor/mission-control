module MissionControl
  module Projects
    class Example < Base
      def run
        tab do
          execute 'cd ~/Development/wonderweblabs/mein-eventbus-shop'
          execute 'mysql.server start'
          open_chrome('http://localhost:3000')

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
    end
  end
end