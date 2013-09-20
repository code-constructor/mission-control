require 'erb'
require 'ostruct'

module MissionControl
  module Projects
    class Creator
      def create(name, template_name = nil)
        path = output_path(name)
        vars = template_vars(name)
        template = template(template_name)

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

      def template(name)
        path = user_template_path(name) || default_template_path

        File.read(path)
      end

      def default_template_path
        File.expand_path('../template.erb', __FILE__)
      end

      def user_template_path(name)
        unless name.nil?
          name = name.to_s.underscore

          Dir["#{config.templates_path}/**/#{name}.erb"].first
        else
          nil
        end
      end

      def output_path(name)
        "#{config.projects_path}/#{name}.rb"
      end

      def projects_dir
        config.projects_path
      end

      def config
        ::MissionControl::Config.instance
      end
    end
  end
end