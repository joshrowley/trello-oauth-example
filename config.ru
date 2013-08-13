require 'rack'
require './app'

run Sinatra::Application
$stdout.sync = true