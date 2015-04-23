# -*- coding: utf-8 -*-

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

require_relative 'users'
require_relative 'timecards'

set :bind, '0.0.0.0'

get '/' do
 erb :index
end

post '/list' do
  erb :list
end

get '/register' do
  erb :reg
end

post '/reg_finish' do 
  @new_no = params[:no].to_i
  @new_name = params[:name].to_s
  if Userslist.add(@new_no, @new_name, 
                   params[:department], params[:pass])
    erb :reg_finish
  else
    erb :reg_error
  end
end




post '/attend' do
  @no = params[:no].to_i
  @pass = params[:password].to_s
  @status = params[:status]
 # @time = Time.now
# date = Date.today.to_s
  if @status == "出勤"
    @message = Ams_operation.attend()
    # @message = "good morning"
  else
    # 帰宅データを
    @message = "Bye"
  end

    erb :attend
end
