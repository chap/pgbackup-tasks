Gem::Specification.new do |s|
  s.name        = 'pgbackup-tasks'
  s.version     = '0.2.0'
  s.date        = '2011-12-22'
  s.summary     = "Some nice rake tasks for Heroku's pgbackups"
  s.authors     = ["Chap Ambrose"]
  s.email       = 'chapambrose@gmail.com'
  s.files       = ["lib/pgbackup-tasks.rb"]
  s.homepage    = 'http://github.com/chap/pgbackup-tasks'
  s.add_runtime_dependency "heroku", [">= 2.17.0"]
end