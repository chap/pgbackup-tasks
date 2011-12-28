Gem::Specification.new do |s|
  s.name        = 'pgbackup-tasks'
  s.version     = '0.2.2'
  s.date        = '2011-12-28'
  s.summary     = "Some nice rake tasks for Heroku's pgbackups"
  s.authors     = ["Chap Ambrose"]
  s.email       = 'chapambrose@gmail.com'
  s.files       = `git ls-files -- lib/*`.split("\n")
  s.homepage    = 'http://github.com/chap/pgbackup-tasks'
  s.add_runtime_dependency "heroku", [">= 2.17.0"]
end