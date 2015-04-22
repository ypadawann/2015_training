
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

set :bind, '0.0.0.0'

require_relative 'users'

get '/' do
  @title = 'Top Page'
  erb :index
end

post '/list' do
  erb :list
end

post '/login' do
  name = params[:name]
  if Userslist.include(name)
    @title = "出勤を確認しました。"
  else
    @title = "登録されていません。"
  end
end

get '/register' do
  @title = 'User registration'
  erb :reg
end

post '/reg_finish' do 
  @newid = params[:id]
  @newname = params[:name]
  if Userslist.add(@newid, @newname)
    @who = @newid + ": " + @newname
    erb :reg_finish
  else
    erb :reg_error
  end
end
