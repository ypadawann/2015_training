
require 'rubygems'
require 'sinatra/base'

require_relative 'users'

post '/list' do
  erb :list
end

get '/register' do
  erb :reg
end

post '/reg_finish' do 
  @new_id = params[:id]
  @new_name = params[:name]
  if Userslist.add(@new_id, @new_name, params[:depno], params[:pass])
    erb :reg_finish
  else
    erb :reg_error
  end
end
