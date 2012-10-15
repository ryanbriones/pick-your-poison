require 'sinatra'
require 'sinatra-initializers'
require 'geocoder'
require 'httparty'

module PickYourPoison
    class Application < Sinatra::Base
        register Sinatra::Initializers

            get '/' do
                # Grab user's info from twitter link, pass it to index view
                @user_info = params
                puts @user_info
                haml :index
            end

            post '/submit' do
                # Geocode address from post request, add it to params hash
                full_address = params[:restaurant_address] + ' , Chicago, IL'
                lat, long = Geocoder.coordinates(full_address) 
                puts lat, long
                params[:lat] = lat
                params[:long] = long
                
                puts 'Open311 API Post Service Request:', params

                # Submit form results to open311 test API, print resulting API response to confirm
                response = HTTParty.post('http://test311api.cityofchicago.org/open311/v2/requests.json', :body => { 
                        :api_key => '229b10330f7ec919ce64d349d88fea2e', 
                        :service_code => '4fd6e4ece750840569000019', 
                        :attributePLEASESE => 'FOODPOIS', 
                        :attributeWHATISTH => params[:restaurant_name], 
                        :address_string => params[:restaurant_address],
                        :description => params[:problem_description],
                        # :problem_date => params[:problem_date],
                        :lat => params[:lat], 
                        :long => params[:long], 
                        :first_name => params[:person_name],
                        :last_name => params[:person_name],
                        :email => params[:person_email],
                    })

                puts 'Open311 API response:', response

                # Add service request token to params hash / mongo document.
                # Tokens are used to get a request's id once the city processes it.
                params[:token] = response[0]['token']

                puts 'Report hash, pre-mongo insert:', params

                # Dump form results to reports mongo collection, print resulting mongo object to confirm
                id = REPORTS.insert(params)

                puts 'Mongo document, post-insert:', REPORTS.find( '_id' => id ).to_a
                
                haml :index
            end

            get '/about' do
                haml :about
            end

            get '/tweets' do
                # Show recent food poisoning tweets dumped into tweets mongo collection by listener
                @tweets = TWEETS.find.sort( :jDate => :desc ).limit(60)
                haml :tweets
            end

            get '/replies' do
                # Show recent Dan responses to confirmed food poisoning tweets
                @dan_outreach_tweets = DAN_TWEETS.find({:text => /improve/}).limit(30)
                haml :replies

#                dan_confirm_tweets = DAN_TWEETS.find({ :text => /SR#/ }, {:text => true, :in_reply_to_screen_name => true, :jDate => true}).limit(30)
#
#                @convo_list = []
#                for outreach_tweet in dan_outreach_tweets:
#                    convo = []
#
#                    in_reply_screen_name = outreach_tweet['in_reply_to_screen_name']
#                    dan_confirm_tweets[reply_screen_name]
#
#                    for confirm_tweet in dan_confirm_tweets:
#                        if confirm_tweet['in_reply_to_screen_name'] == in_reply_to_screen_name
#                            confirm tweet....
#
#                    end
#                    end
#
#                    convo[0] = outreach_tweet
#                    convo[1] = confirm_tweet
#                    @convo_list += convo
#                end
            end

            get '/reports' do
                # Show recent info for recent form submissions / API service requests
                @reports = REPORTS.find.limit(30)
                haml :reports
            end

    end
end

