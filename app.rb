require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'oauth'
require 'pry'

Pry.config.input = STDIN
Pry.config.output = STDOUT

enable :sessions

get '/auth' do
  # Create a new OAuth consumer to make the request to the oauth API
  # with the correct request token path, access token path, and
  # authorize path.

  consumer = OAuth::Consumer.new(   ENV["TRELLO_APP_ID"],
                                    ENV["TRELLO_APP_SECRET"],
                                    site: "https://trello.com",
                                    request_token_path: "/1/OAuthGetRequestToken",
                                    access_token_path: "/1/OAuthGetAccessToken",
                                    authorize_path: "/1/OAuthAuthorizeToken"  )

  # Get request token, passing in the callback url you want the user to
  # be redirected to after the user authenticates your application.
  # This will be make a request to the request_token_path passed into
  # the consumer. The application ID and secret will be passed in as
  # parameters and  the response will ba a request token object with a secret key.

  request_token = consumer.get_request_token(oauth_callback: "http://localhost:4567/callback")

  # Store the request_token in the session, you'll need this during
  # the callback.

  session[:request_token] = request_token

  # Redirect the user to the authorization url provided
  # by the request token.

  redirect request_token.authorize_url
end


get '/callback' do
  # Retrieve the request token.
  request_token = session[:request_token]

  # Use the request token to make a request to the
  # access token path.

  access_token  = request_token.get_access_token(oauth_verifier: params[:oauth_verifier])

  # Uncomment below to stop drop into pry at this line.
  #
  # binding.pry


  # Hopefully you recieve an access token back with
  # a token and a secret. You can use this access
  # token to make authenticated HTTP requests.

  "Access Token: #{access_token.inspect}"
end
