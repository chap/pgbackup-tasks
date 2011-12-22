namespace :backup do
  desc 'capture pgbackup from production and put in ../pgbackups'
  task :pgbackup  => :environment do
    timestamp = Time.now.utc.strftime("%Y%m%d%H%M%S")
    system("heroku pgbackups:capture --expire --app acc")
    system("curl -o ../pgbackups/production_#{timestamp}.dump --create-dirs `heroku pgbackups:url --app acc`")
  end

  desc 'load most recent pgbackup dump in db/backup'
  task :load  => :environment do
    last_backup = Dir.entries("./pgbackups").last
    database = Rails.configuration.database_configuration[Rails.env]['database']
    system("pg_restore --verbose --clean --no-acl --no-owner -d #{database} ./pgbackups/#{last_backup}")
  end

  desc 'pull down pgbackup and load'
  task :seed  => :environment do
    `rake backup:pgbackup`
    `rake backup:load`
  end

  desc 'put production db on staging'
  task :to_staging  => :environment do
    system("heroku pgbackups:capture --expire --remote production")
    system("heroku pgbackups:restore `heroku pgbackups:url --remote production` --remote staging")
  end
end