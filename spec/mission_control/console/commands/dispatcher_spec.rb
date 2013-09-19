require 'spec_helper'
require 'lib/mission_control/console/commands/dispatcher'
require 'active_support/inflector'

describe MissionControl::Console::Commands::Dispatcher do
  before(:all) do
    @project_name = "test#{Time.now.to_i}"

    @project_class = Class.new(Object) do
      def text(test)
        test
      end
    end

    MissionControl::Console::Commands.const_set(@project_name.classify, @project_class)
  end

  it 'self.call the right command and action' do
    expect(subject.class.call("#{@project_name}", 'text', 'text')).to eq('text')
  end

  it 'call the right command and action' do
    expect(subject.call("#{@project_name}", 'text', 'text')).to eq('text')
  end
end