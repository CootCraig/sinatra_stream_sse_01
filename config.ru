require 'rubygems'
require 'bundler'
Bundler.require(:default):w

require './site'
run Sinatra::Application

