require 'pgbackup-tasks'

namespace :pgbackup do
  desc 'capture pgbackup from production'
  task :capture  => :environment do
    system("heroku pgbackups:capture --expire --remote production")
  end

  desc 'download most recent pgbackup from production and put in ../pgbackups'
  task :download  => :environment do
    timestamp = Time.now.utc.strftime("%Y%m%d%H%M%S")
    system("curl -o ../pgbackups/production_#{timestamp}.dump --create-dirs `heroku pgbackups:url --remote production`")
  end

  desc 'load most recently downloaded pgbackup into development database'
  task :restore  => :environment do
    last_backup = Dir.entries("../pgbackups").last
    database = Rails.configuration.database_configuration[Rails.env]['database']
    system("pg_restore --verbose --clean --no-acl --no-owner -d #{database} ../pgbackups/#{last_backup}")
  end

  desc 'capture, download and restore pgbackup from production to development'
  task :seed  => :environment do
    `rake pgbackup:capture`
    `rake pgbackup:download`
    `rake pgbackup:restore`
  end

desc 'capture and restore pgbackup from production to staging'
  task :to_staging  => :environment do
    `rake pgbackup:capture`
    system("heroku pgbackups:restore `heroku pgbackups:url --remote production` --remote staging")
  end
end