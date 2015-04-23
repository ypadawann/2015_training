
require 'rubygems'
require 'sinatra/base'
require 'sinatra/reloader'

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
  begin
    Userslist.access(params[:id], params[:pass])
    erb :attend
  rescue UsersAccessError => exp
    @err_msg = exp.message
    erb :attend_fail
  end
end

get '/register' do
  erb :reg
end

post '/reg_finish' do 
  if Userslist.add(params[:id], params[:name], 
                   params[:depno], params[:pass])
    erb :reg_finish
  else
    @new_id = params[:id]
    erb :reg_error
  end
end
  run! if app_file == $0
end
