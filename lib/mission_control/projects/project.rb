class MissionControl::Projects::Project
  attr_accessor :class_name
  attr_reader :object
  attr_reader :description

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

  def description
    object.description
  end

  def run
    object.run
  end

  def visible?
    object.show_in_overview?
  end

  private

  def self.all_objects
    classes.map do |clazz|
      new(clazz)
    end
  end

  def self.classes
    classes = namespace.constants

    classes = classes.reject do |clazz|
      hidden_constants.include?(clazz)
    end

    classes.map do |clazz|
      "#{namespace}::#{clazz}".constantize
    end
  end

  def self.hidden_constants
    [
      :Base,
      :Creator,
      :DSL,
      :Dispatcher,
      :Shell,
      :Project,
      :Help
    ] + (config.hidden_projects || [])
  end

  def self.paths
    ::Dir["#{MissionControl::Config.instance.projects_path}/**/*.rb"]
  end

  def self.require_all
    paths.each do |path|
      require path
    end
  end

  def self.namespace
    config.projects_namespace
  end

  def self.config
    ::MissionControl::Config.instance
  end
end