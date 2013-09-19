require 'spec_helper'
require 'rails'
require 'socket'

describe MissionControl::Console::Commands::Rails do
  before do
    @result = MissionControl::Console::Commands::Rails.new
  end

  it ".console return correct command" do
    expect(@result.console).to eq("bundle exec rails console")
  end

  it ".server return correct command" do
    @result.stub(:port).and_return(3000)

    expect(@result.server).to eq("bundle exec rails server -p 3000")
  end

  it ".port return unused port" do
    server = TCPServer.new('0.0.0.0', 3000) rescue nil

    expect(@result.port).to be > 3000

    server.close
  end
end