require 'rubygems'
require 'bundler'
Bundler.require(:default)

require './site'
run Sinatra::Application

