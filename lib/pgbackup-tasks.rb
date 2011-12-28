module PgbackupTasks
  module Rails
    class Railtie < ::Rails::Railtie
      rake_tasks do
        load "tasks/pgbackup.rake"
      end
    end
  end
end