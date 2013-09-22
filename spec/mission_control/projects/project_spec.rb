require 'spec_helper'
require 'active_support/inflector'

describe MissionControl::Models::Project do
  describe '#all' do
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

    it 'return all project objects' do
      objects = MissionControl::Models::Project.all

      expect(objects.size).to have_at_least(0).items

      objects.each do |object|
        expect(object.class).to eq(MissionControl::Models::Project)
      end
    end
  end

  describe '#find_by_name' do
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

    it 'return a project by its name' do
      object = MissionControl::Models::Project.find_by_name(@project_name.to_sym)

      expect(object.class.to_s).to_not eq(MissionControl::Projects::Base)
      expect(object.name).to eql(@project_name.to_sym)
    end
  end

  describe 'object methods' do
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

    subject{MissionControl::Models::Project.new(@project_class)}

    it{ expect(subject.class.to_s).to_not(eq(MissionControl::Projects::Base)) }
    it{ expect(subject.name).to eql(@project_name.to_sym) }
    it{ expect(subject.description).to eql(@project_class.new.description) }
    it{ expect(subject.visible?).to eql(@project_class.new.visible?) }
  end
end