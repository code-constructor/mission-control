module MissionControl
  module Projects
    class Example < Base
      def description
        nil
      end

      def run
        tab do
          command 'cd ~/Development/wonderweblabs/mein-eventbus-shop'
          command 'mysql.server start'
          command(:browser, :chrome, 'http://localhost:3000')

          verticle do
            command 'cd ~/Development/wonderweblabs/mein-eventbus-shop'
            command(:rails, :server)

            horizontal do
              command 'cd ~/Development/wonderweblabs/mein-eventbus-shop'
              command(:rails, :console)
            end
          end
        end
      end
    end
  end
end