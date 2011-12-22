require 'pgbackup-tasks'
require 'rails'

class Railtie < Rails::Railtie
  rake_tasks do
    require "pgbackup-tasks/tasks"
  end
end