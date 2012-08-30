require 'sinatra'
require 'sinatra-initializers'

module PickYourPoison
    class Application < Sinatra::Base
        register Sinatra::Initializers

            get '/' do
                haml :index
            end

            post '/submit' do
                puts params
                PF.insert(params)
                puts PF.find_one



                haml :index
            end

            get '/about' do
                haml :index
            end

    end
end

