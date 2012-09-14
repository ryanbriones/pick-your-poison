require 'sinatra'
require 'sinatra-initializers'

module PickYourPoison
    class Application < Sinatra::Base
        register Sinatra::Initializers

            get '/' do
                haml :index
            end

            post '/submit' do
                FORMS.insert(params)
                puts FORMS.find_one

                haml :index
            end

            get '/about' do
                haml :index
            end

            get '/tweets' do
                puts TWEETS.count
                @tweets = TWEETS.find
                haml :tweets
            end

            get '/responses' do
                haml :responses
            end

            get '/forms' do
                haml :forms
            end

    end
end

