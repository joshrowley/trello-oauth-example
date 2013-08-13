== Trello OAuth Example


A simple example of how to request authentication with the Trello
OAuth 1.0 API using just the [oauth](https://github.com/pelle/oauth) gem.


Grab an App ID and secret [here](https://trello.com/1/appKey/generate).


Either set your Trello App ID and Secret vars
in `app.rb` or in your environment.


    $ ruby app.rb


Go to http://localhost:4567/auth to initiate the oauth
authentication.


You can move `binding.pry` throughout the code to interrupt the execution to
see what values are being returned along the way.
