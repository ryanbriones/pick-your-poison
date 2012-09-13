require 'yaml'
require 'mongo'

begin
    config = YAML.load_file('config/database.yml')
    puts 'got config from local'
rescue
    config = {
        'server' => ENV['MONGO_AWS'],
        'port' => ENV['MONGO_PORT'],
        'db' => ENV['MONGO_DB'],
        'user' => ENV['MONGO_USER'],
        'pass' => ENV['MONGO_PASS']
    }

    heroku_config = true

    puts 'got config from heroku env'
end

conn = Mongo::Connection.new(config['server'], config['port'])  # Connect to Mongo instance
puts conn

db = conn.db(config['db'])  # Connect to DB
puts db

if heroku_config == true
    auth = db.authenticate(config['user'], config['pass'])  # Authenticate if on production server
    puts auth
end

PF = db['fp_form_data']  # Connect to collection
puts PF
