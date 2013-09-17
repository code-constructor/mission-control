require 'erb'
require 'ostruct'
require 'active_support/inflector'

module MissionControl
  module Projects
    class Creater
      def create(name)
        path = output_path(name)
        vars = template_vars(name)

        output = File.open(path, 'w+')
        output << ERB.new(template).result(vars)
        output.close

        puts "Created at #{output_path(name)}"
      end

      private

      def template_vars(name)
        vars = OpenStruct.new(class_name: name.classify)

        vars.instance_eval { binding }
      end

      def template
        File.read(template_path)
      end

      def template_path
        File.expand_path('../template.erb', __FILE__)
      end

      def output_path(name)
        File.expand_path("../../../../projects/#{name}.rb", __FILE__)
      end

      def projects_dir
        File.expand_path("../../../../projects", __FILE__)
      end
    end
  end
end