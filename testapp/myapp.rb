
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

set :bind, '0.0.0.0'

get '/' do
  erb :index
end

load 'myapp_mori.rb'
load 'myapp_henmi.rb'
