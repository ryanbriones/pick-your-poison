require 'sinatra'
require 'sinatra-initializers'

module PickYourPoison
    class Application < Sinatra::Base
        register Sinatra::Initializers

            get '/' do
                'hello world'
                # haml :index
            end

            get '/submit' do
                haml :confirm
            end

    end
end

