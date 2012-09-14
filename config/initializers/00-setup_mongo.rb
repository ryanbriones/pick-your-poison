require 'yaml'
require 'mongo'

begin
    config = YAML.load_file('config/database.yml')
    puts 'got config from local'
rescue
    config = {
        'server' => ENV['MONGO_AWS'],
        'port' => ENV['MONGO_PORT'],
        'tweets_db' => ENV['MONGO_TWEETS_DB'],
        'forms_db' => ENV['MONGO_FORMS_DB'],
        'tweets_user' => ENV['MONGO_TWEETS_USER'],
        'tweets_pass' => ENV['MONGO_TWEETS_PASS'],
        'forms_user' => ENV['MONGO_FORMS_USER'],
        'forms_pass' => ENV['MONGO_FORMS_PASS']
    }

    heroku_config = true

    puts 'got config from heroku env'
end

conn = Mongo::Connection.new(config['server'], config['port'])  # Connect to Mongo instance
puts conn

tweets_db = conn.db(config['tweets_db'])  # Connect to DBs
puts config['tweets_db'], tweets_db

forms_db = conn.db(config['forms_db'])  
puts config['forms_db'], forms_db

if heroku_config == true
    tweet_auth = tweet_db.authenticate(config['tweets_user'], config['tweets_pass'])  # Authenticate if on production server
    forms_auth = tweet_db.authenticate(config['forms_user'], config['forms_pass'])  
    puts tweet_auth, forms_auth
end

TWEETS = tweets_db['fp_tweets_chi_01'] # Connect to collections
puts 'fp_tweets_chi_01', TWEETS

FORMS = forms_db['fp_form_data']  
puts 'fp_form_data', FORMS
