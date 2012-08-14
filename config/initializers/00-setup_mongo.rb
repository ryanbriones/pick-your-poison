require 'yaml'
require 'mongo'

begin
    config = YAML.load_file('config/database.yml')
    puts 'got config from local'
rescue
    config = {
        'server' => ENV['MONGO_SERVER'],
        'port' => ENV['MONGO_PORT']
    }
    puts 'got config from heroku env'
end

conn = Mongo::Connection.new(config['server'], config['port'])
puts conn
db = conn.db('test')
puts db
PF = db['pf']
puts PF
