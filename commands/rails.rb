require 'socket'

class MissionControl::Console::Commands::Rails
  # TODO extract to initialize
  ActiveSupport::Inflector.inflections do |inflect|
    inflect.singular('rails', 'rails')
  end

  def server
    "bundle exec rails server -p #{port}"
  end

  def console
    "bundle exec rails console"
  end

  def port
    @port ||= search_port
  end

  private
  def search_port
    default_ports.find do |port|
      begin
        server = TCPServer.new('127.0.0.1', port)
        server.close

        true
      rescue
        false
      end
    end
  end

  def default_ports
    @default_ports ||= (3000..3100)
  end
end