require 'yaml'
require 'mongo'

config = {
    'server' => ENV['MONGO_FULL'],
    'port' => ENV['MONGO_PORT'],
    'db' => ENV['MONGO_DB'],
    'user' => ENV['MONGO_USER'],
    'pass' => ENV['MONGO_PASS']
}
puts 'got config from heroku env'

conn = Mongo::Connection.new(config['server'], config['port'])  # Open connection
puts conn
db = conn.db(config['db'])  # connect to db 
puts db
auth = db.authenticate(config['user'], config['pass'])  # Authentice
puts auth
PF = db['pf']  # Create new collection
puts PF
