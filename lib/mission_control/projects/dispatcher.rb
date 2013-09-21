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
    project_names.select do |name|
      object = project(name)

      object.show_in_overview?
    end
  end

  def descriptions
    project_names.inject({}) do |hash, name|
      object = project(name)

      if object.show_in_overview?
        hash[name] = object.description
      end

      hash
    end
  end

  def project_exists?(project)
    project_classes.include?(project.classify.to_sym)
  end

  def load_projects
    project_paths.each do |path|
      require path
    end
  end

  private

  def project_paths
    ::Dir["#{MissionControl::Config.instance.projects_path}/**/*.rb"]
  end

  def project_classes
    classes = namespace.constants

    classes.reject do |clazz|
      hidden_constants.include?(clazz)
    end
  end

  def project_class(project)
    "#{namespace}::#{project.classify}".constantize
  end

  def project_names
    project_classes.map do |clazz|
      project_name(clazz)
    end
  end

  def project_name(project)
    project.to_s.underscore
  end


  def hidden_constants
    [
      :Base,
      :Creator,
      :DSL,
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