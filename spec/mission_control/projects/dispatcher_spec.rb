require 'spec_helper'
require 'active_support/inflector'

describe MissionControl::Projects::Dispatcher do
  before(:all) do
    @project_name = "test#{Time.now.to_i}"

    class_name = @project_name.classify
    @project_class = Class.new(MissionControl::Projects::Base) do
      def description
        'Lorem Ipsum'
      end
    end
    MissionControl::Projects.const_set(class_name, @project_class)
  end

  describe '.project' do
    it 'return object of project' do
      object = subject.project(@project_name)
      expect(object.class.name).to eq(@project_class.name)
    end

    it 'raise exception when project not avaiable' do
      expect{subject.project(Time.now.to_s)}.to raise_error
    end
  end

  it '.projects_descriptions returns description' do
    expect(subject.projects_descriptions).to include({@project_name => "Lorem Ipsum"})
  end

  it '.projects returns array of project names' do
    expect(subject.projects).to include(@project_name)
  end

  describe '.project_exists?' do
    it 'return true when project avaiable' do
      expect(subject.project_exists?(@project_name)).to be_true
    end

    it 'return false when project not avaiable' do
      expect(subject.project_exists?("#{Time.now.to_i}")).to be_false
    end
  end
end