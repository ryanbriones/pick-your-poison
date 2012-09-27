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
                REPORTS.insert(params)
                puts REPORTS.find_one

                haml :index
            end

            get '/about' do
                haml :about
            end

            get '/tweets' do
                @tweets = TWEETS.find.sort( :jDate => :desc ).limit(60)
                haml :tweets
            end

            get '/replies' do

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
                @reports = REPORTS.find.limit(30)
                haml :reports
            end

    end
end

