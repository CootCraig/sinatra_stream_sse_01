require 'sinatra'
require "sinatra/streaming"
require 'haml'
require 'app'

set :server, :thin

get '/' do
  haml :index
end
get '/door/:door/events' do
end
configure do
  set :server, :thin
  App.start
end

