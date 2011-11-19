require 'haml'
require 'sinatra'
require "sinatra/streaming"
require 'json'
require './app'

get '/' do
  @doors = App.door_ids
  haml :index
end

get '/door/events/:door' do
  content_type 'text/event-stream'
  if App::door?(params[:door])
    door = params[:door]
    STDOUT.puts "request for #{door}"
    stream() do |out|
      #:keep_open
      #App.add_connection(params[:door],out)
      data = {door: door}
      out << "data: #{JSON(data)}\n\n"
    end
  else
    stream do |out|
      out << "data: #{JSON({error: "No door #{params[:door].to_s}"})}\n\n"
    end
  end
end

get '/stylesheets/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  scss(:"stylesheets/#{params[:name]}")
end

configure do
  App.start
end

