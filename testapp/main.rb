# -*- coding: utf-8 -*-

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

require_relative 'users'
# require_relative 'timecards'

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
  @new_id = params[:id]
  @new_name = params[:name]
  if Userslist.add(@new_id, @new_name, params[:depno], params[:pass])
    erb :reg_finish
  else
    erb :reg_error
  end
end




post '/attend' do
  @id = params[:id].to_i
  @pass = params[:pass].to_s
  @status = params[:status]
  @time = (Time.now).strftime("%X")
  @date = Date.today
  if @status == "出勤"
    @message = Timecard_operation.attend(@date,@time,@id)
    # @message = "good morning"
  else
    # 帰宅データを
    @message = "Bye"
  end

    erb :attend
end

get '/test-get-time' do
  Timecard_operation.testgettime()
  # p timecards.all[0].day
end

load 'timecards.rb'
