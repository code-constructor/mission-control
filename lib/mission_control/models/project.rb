require 'forwardable'

module MissionControl
  module Models
    class Project
      extend ::Forwardable

      attr_accessor :class_name
      attr_reader :object
      attr_reader :description

      def_delegator :object, :description
      def_delegator :object, :run
      def_delegator :object, :visible?

      def self.all
        require_all

        all_objects.select do |project|
          project.visible?
        end
      end

      def self.find_by_name(name)
        object = self.all.detect do |object|
          object.name == name
        end

        raise 'Project doesen\'t exists' if object.nil?

        object
      end

      def initialize(class_name)
        @class_name = class_name
      end

      def object
        @object ||= class_name.new
      end

      def name
        class_name.to_s.demodulize.underscore.to_sym
      end

      private

      def self.all_objects
        classes.map do |clazz|
          new(clazz)
        end
      end

      def self.classes
        MissionControl::Projects::Base.subclasses
      end

      def self.paths
        ::Dir["#{MissionControl::Config.instance.projects_path}/**/*.rb"]
      end

      def self.require_all
        paths.each do |path|
          require path
        end
      end
    end
  end
end