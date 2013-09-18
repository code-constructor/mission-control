module MissionControl
  module Projects
    class Example < Base
      def description
        'Lorem Ipsum'
      end

      def run
        tab do
          execute 'cd ~/Development/wonderweblabs/mein-eventbus-shop'
          execute 'mysql.server start'
          execute command(:browser, :chrome, 'http://localhost:3000')

          verticle do
            execute 'cd ~/Development/wonderweblabs/mein-eventbus-shop'
            execute command(:rails, :server)

            horizontal do
              execute 'cd ~/Development/wonderweblabs/mein-eventbus-shop'
              execute command(:rails, :console)
            end
          end
        end
      end
    end
  end
end