
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

# require 'sinatra/reloader'

require_relative 'users'

get '/' do
  erb :index
end

load 'myapp_mori.rb'
