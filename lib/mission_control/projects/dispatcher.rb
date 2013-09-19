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
    project_classes.inject([]) do |array, project|
      name = project.to_s.underscore
      object = project_class(name).new

      if object.show_in_overview?
        array << name
      end

      array
    end
  end

  def projects_descriptions
    project_classes.inject({}) do |hash, project|
      name = project.to_s.underscore
      clazz = project_class(name)
      object = clazz.new

      if object.show_in_overview?
        description = object.description if object.respond_to?(:description)

        hash[name] = description
      end

      hash
    end
  end

  def project_exists?(project)
    project_classes.include?(project.classify.to_sym)
  end

  private

  def project_paths
    ::Dir["#{MissionControl::Config.instance.projects_path}/*.rb"]
  end

  def project_class(project)
    "#{namespace}::#{project.classify}".constantize
  end

  def project_classes
    classes = namespace.constants

    hidden_constants.each do |constant|
      classes.delete(constant)
    end

    classes
  end


  def load_projects
    project_paths.each do |path|
      require path
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