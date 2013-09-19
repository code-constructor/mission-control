class MissionControl::Projects::Dispatcher
  def initialize
    load_projects
  end

  def project(name)
    if project_exists?(name)
      project_class(name).new
    else
      raise 'Project doesen\'t exists'
    end
  end

  def projects
    @projects ||= project_classes.inject([]) do |array, clazz|
      name = project_name(clazz)
      object = project(name)

      array << name if object.show_in_overview?

      array
    end
  end

  def projects_descriptions
    @descriptions ||= project_classes.inject({}) do |hash, clazz|
      name = project_name(clazz)
      object = project(name)

      if object.show_in_overview?
        hash[name] = object.respond_to?(:description) ? object.description : nil
      end

      hash
    end
  end

  def project_exists?(project)
    project_classes.include?(project.classify.to_sym)
  end

  private

  def load_projects
    project_paths.each do |path|
      require path
    end
  end

  def project_paths
    ::Dir["#{MissionControl::Config.instance.projects_path}/*.rb"]
  end

  def project_class(project)
    "#{namespace}::#{project.classify}".constantize
  end

  def project_name(project)
    project.to_s.underscore
  end

  def project_classes
    classes = namespace.constants

    classes.select do |clazz|
      !hidden_constants.include?(clazz)
    end
  end

  def hidden_constants
    [
      :Base,
      :Creator,
      :Dispatcher,
      :Shell,
    ] + (config.hidden_projects || [])
  end

  def namespace
    config.projects_namespace
  end

  def config
    ::MissionControl::Config.instance
  end
end