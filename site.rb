require 'haml'
require 'kramdown'
require 'sinatra'
require "sinatra/streaming"
require 'json'
require './app'

get '/' do
  markdown :'../README'
end

get '/simple' do
  @doors = App.door_ids
  haml :simple
end

get '/door/events/:door' do
  content_type 'text/event-stream'
  door = params[:door]
  if App::door?(params[:door])
    stream(:keep_open) do |out|
      App.add_subscriber(door,out)
      data = {door: door}
      out << "data: #{JSON(data)}\n\n"
      out.flush
    end
  else
    stream do |out|
      data = {error: "No door #{door}"}
      out << "data: #{JSON(data)}\n\n"
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

