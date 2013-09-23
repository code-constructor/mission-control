mission-control
===============

Mission Control allows the automatic setup of your everyday used projects on a mac with the help of iterm.

##The Problem:
Your working day starts. You switch on your computer and must open your project setup with different shells. One for a rails server, another for a rails console, a third for the git commands and so on. It's even more worse to do this when you must switch between different project and repeat the opening tasks again and again.


##The Solution:
Mission Control helps to solve this problem. With the full power of ruby, it's possible to define your project setup only once in a little ruby class. Mission Control provides a little console interface that keeps track of the defined project files and run the setup easily with one command.

##Before first start
Checkout the project from github. Create a folder for the projects, commands and templates and define the paths in lib/config.rb. The standard-setting are:

Project-Dir: mission_control_root_directory/projects

Commands-Dir: mission_control_root_directory/projects/commands

Templates-Dir: mission_control_root_directory/projects/templates

##Usage

###Create a new project
1. Execute the run skript in the project root folder
2. open the projects subshell with 'projects'
3. write 'create project_name, template'
4. mission control creates a new project file in the projects directory.


###Open a project setup
1. Execute the run skript
2. open the projects subshell with 'projects'
3. write the name of your project in snakecase (tap completion is possible an recommended)
4. mission control executes the run method of your project file

## Further cool stuff
Take a look at the wiki. MissionControl provides also a simple templatesystem an command helpers.
