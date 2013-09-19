require 'spec_helper'

describe MissionControl::Projects::Creator do
  before(:all) do
    @name = "test_#{Time.now.to_i}"
    @projects_dir = File.expand_path("../../../../projects", __FILE__)
  end

  after(:all) do
    File.delete("#{@projects_dir}/#{@name}.rb")
  end

  describe '.create' do
    it 'return object of project' do
      subject.create(@name)

      files = Dir["#{@projects_dir}/*.rb"]

      expect(files).to include "#{@projects_dir}/#{@name}.rb"
    end
  end
end