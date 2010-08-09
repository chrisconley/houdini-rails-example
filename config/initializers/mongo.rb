if ENV['MONGOHQ_URL']
  settings = URI.parse(ENV['MONGOHQ_URL'])
  database_name = settings.path.gsub(/^\//, '')
else
  settings = URI.parse('mongodb://localhost/houdini')
  database_name = settings.path.gsub(/^\//, '') + "_#{RAILS_ENV}"
end

Mongoid.configure do |config|
  config.master = Mongo::Connection.new(settings.host, settings.port).db(database_name)
  config.master.authenticate(settings.user, settings.password) if settings.user
  config.persist_in_safe_mode = true
end
