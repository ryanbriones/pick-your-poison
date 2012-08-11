require 'sinatra'
require 'sinatra-initializers'

module PickYourPoison
    class Application < Sinatra::Base
        register Sinatra::Initializers

            get '/' do
                haml :index
            end

            get '/submit' do
                haml :confirm
            end

            get '/about' do
                haml :index
            end

    end
end

