
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

set :bind, '0.0.0.0'

require_relative 'users'

get '/' do
  erb :index
end

post '/list' do
  erb :list
end

post '/attend' do
  id = params[:id]
  if Userslist.include?(id)
    @msg = "出勤を確認しました。"
  else
    @msg = "登録されていません。"
  end
  erb :attend
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
