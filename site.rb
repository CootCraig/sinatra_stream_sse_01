require 'haml'
require 'sinatra'
require "sinatra/streaming"
require 'app'

get '/' do
  haml :index
end
get '/door/events/:door' do
  if App::door?(params[:door].to_s)
    stream(:keep_open) do |out|
      App.add_connection(params[:door],out)
      out << "data: #{JSON({door: params[:door]})}\n\n"
    end
  else
    stream do |out|
      out << "data: #{JSON({error: "No door #{params[:door].to_s}"})}\n\n"
    end
  end
end
configure do
  App.start
end

