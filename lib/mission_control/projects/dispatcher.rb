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
    project_classes.inject({}) do |hash, project|
      name = project.to_s.underscore
      object = project_class(name).new
      description = object.description if object.respond_to?(:description)

      hash[name] = description

      hash
    end
  end

  def project_exists?(project)
    project_classes.include?(project.classify.to_sym)
  end

  private

  def project_paths
    Dir[File.expand_path('../../../../projects/*.rb', __FILE__)]
  end

  def project_class(project)
    "#{scope}::#{project.classify}".constantize
  end

  def project_classes
    classes = scope.constants

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
    ]
  end

  def scope
    ::MissionControl::Projects
  end
end