require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'oauth'
require 'pry'

Pry.config.input = STDIN
Pry.config.output = STDOUT

enable :sessions

get '/auth' do
  @consumer = OAuth::Consumer.new(  ENV["TRELLO_APP_ID"],
                                    ENV["TRELLO_APP_SECRET"],
                                    site: "https://trello.com",
                                    request_token_path: "/1/OAuthGetRequestToken",
                                    access_token_path: "/1/OAuthGetAccessToken",
                                    authorize_path: "/1/OAuthAuthorizeToken"  )
  @callback_url = "http://localhost:4567/callback"
  @request_token = @consumer.get_request_token(oauth_callback: @callback_url)
  session[:request_token] = @request_token
  redirect @request_token.authorize_url(oauth_callback: @callback_url)
end


get '/callback' do
  binding.pry
  "/callback works. params are #{params.inspect}"
end
