
require 'rubygems'
require 'sinatra/base'
# require 'sinatra/reloader'

require_relative 'users'

class Myapp < Sinatra::Base
set :bind, '0.0.0.0'

@@err_msg = ""

get '/' do
  erb :index
end

post '/list' do
  erb :list
end

post '/attend' do
  id = params[:id].to_i
  if Userslist.include?(id)
    @id = id
    @name = Userslist.access(id)
    @exists = true
  else
    @exists = false
  end
  erb :attend
end

get '/register' do
  erb :reg
end

post '/reg_finish' do 
  @newid = params[:id].to_i
  @newname = params[:name]
  if Userslist.add(@newid, @newname)
    erb :reg_finish
  else
    erb :reg_error
  end
end
  run! if app_file == $0
end
