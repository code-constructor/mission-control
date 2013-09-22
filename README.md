mission-control
===============

Mission Control allows the automatic setup of your everyday used projects.

##The Problem:
Your working day starts. You switch on your computer and must open your project setup with different shells. One for a rails server, another for a rails console, a third for the git commands and so on. It's even more worse to do this when you must switch between different project and repeat the opening tasks again and again.


##The Solution:
Mission Control helps to solve this problem. With the full power of ruby, it's possible to define your project setup only once in a little ruby class. Mission Control provides a little console interface that keeps track of the defined project files and run the setup easily with one command.

##Run
Checkout the project from github. Create a folder for the projects, commands and templates and define the paths in lib/config.rb. The standard-setting are:
Project-Dir at <root>/projects
Commands-Dir at <root>/projects/commands
Templates-Dir at <root>/projects/templates

Execute the run script in the projects root directory.

###A minimum project class:

    class MissionControl::Projects::LittleProject < MissionControl::Projects::Base
      description 'Little Project'

      def run
        tab do
          execute 'cd ~/foo/little-project'
          execute 'git status'

          verticle do
            execute 'cd ~/foo/little-project'
            execute 'rails console'
          end

          horizontal do
            execute 'cd ~/foo/little-project'
            execute 'rails server'
          end
        end
      end
    end

###Command Helpers:
Mission Control provides a helper mechanism to define complex, dynamic or often needed console output. Check out the little example.

####Commands-Class:
    class MissionControl::Commands::Dir
      def cd(path)
        "cd #{path}"
      end
    end

####Projects-Class:
    class MissionControl::Projects::LittleProject < MissionControl::Projects::Base
      description 'Little Project'

      def run
        tab do
          exec (:dir, :cd, '~/foo/little-project')
          execute 'git status'

          verticle do
            exec (:dir, :cd, '~/foo/little-project')
            execute 'rails console'
          end

          horizontal do
            exec (:dir, :cd, '~/foo/little-project')
            execute 'rails server'
          end
        end
      end
    end

Keep in mind, that the project- and the command-file are only ruby class. This means that you can use the full power of ruby. It's is e.g. possible to write a command that starts a rails server with a predetermine unused port. The following code shows an simple example of this command:


    require 'socket'

    class MissionControl::Commands::Rails
      def server
        "rails server -p #{port}"
      end

      private
      def port
        (3000..3100).find do |port|
          begin
            server = TCPServer.new('0.0.0.0', port)
            server.close

            true
          rescue
            false
          end
        end
      end
    end

##Open a project setup
1. Execute the run skript
2. open the projects subshell with 'projects'
3. write the name of your project in snakecase (tap completion is possible an recommended)
4. mission control executes the run method of your project file

##Create a new project
1. Execute the run skript in the project root folder
2. open the projects subshell with 'projects'
3. write 'create <project_name>, <template>'
4. mission control creates a new project file in the projects directory. If a template is given as the second argument, mission control uses this ERB-template to create the project file. If the template argument is not defined, mission control uses the standard ERB-template to create the new projects file.

##Template - System
To allow a simple and fast creation of a new project, mission control provides the possibility to define templates for a project-file. A template must be an erb file and can be specified in the mission control console in the creation instruction (see section 'Create a new project'). E.g.

    module MissionControl
      module Projects
        class <%= class_name %> < ::MissionControl::Projects::Base
          description 'Lorem Ipsum'

          def path
            '~/foo/bar'
          end

          def run
            tab do
              exec(:dir, :cd, path)
            end
          end
        end
      end
    end
