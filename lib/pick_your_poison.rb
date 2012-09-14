require 'sinatra'
require 'sinatra-initializers'

module PickYourPoison
    class Application < Sinatra::Base
        register Sinatra::Initializers

            get '/' do
                @user_info = params
                puts @user_info
                haml :index
            end

            post '/submit' do
                FORMS.insert(params)
                puts FORMS.find_one

                haml :index
            end

            get '/about' do
                haml :about
            end

            get '/tweets' do
                @tweets = TWEETS.find.limit(30)
                haml :tweets
            end

            get '/replies' do
                @tweets = TWEETS.find.limit(30)
                haml :replies
            end

            get '/reports' do
                @reports = REPORTS.find.limit(30)
                haml :reports
            end

    end
end

