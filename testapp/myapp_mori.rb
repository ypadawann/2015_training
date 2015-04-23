
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

# require 'sinatra/reloader'

require_relative 'users'

post '/attend' do
    @id = params[:id].to_i
 #   @pass = params[:pass].to_s
    @pass = "maki chan kawaii ka ki ku ke ko"
    erb :attend
end
