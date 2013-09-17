require File.expand_path('../../../spec_helper', __FILE__)

describe MissionControle::Console::Actions::Dispatcher do
  before do
    @result = MissionControle::Console::Actions::Dispatcher.new

    class ::MissionControle::Console::Actions::Test
      def call(*args)
        args
      end
    end
  end

  describe '.call_action' do
    it 'send "call" to the right class' do
      string = @result.call_action('test', 'test')

      expect(string).to eq(['test'])
    end

    it 'raise exception when action not exists' do
      expect{ @result.call_action(Time.now.to_s)}.to raise_error
    end
  end

  describe '.action_exists?' do
    it 'return true when action exists' do
      expect(@result.action_exists?('test')).to be_true
    end

    it 'return false when action not exists' do
      expect(@result.action_exists?(Time.now.to_s)).to be_false
    end
  end
end