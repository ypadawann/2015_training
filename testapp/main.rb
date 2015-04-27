# -*- coding: utf-8 -*-

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'composite_primary_keys'

require_relative 'users'
require_relative 'timecards'
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
  @no = params[:no].to_i
  pass = params[:pass].to_s
  status = params[:status]
  time = (Time.now).strftime("%X")
  # time = Time.now
  day = Date.today
  if status == "出勤"
    if Timecard_operation.attend(day,@no,time)
      @message = "#{day}は#{time}に出勤しました"
    else
      @message = "本日はすでに出勤しています"
    end
  elsif status == "退勤"
    leavingstatus = Timecard_operation.returnhome(day,@no,time)
    if leavingstatus == 'no attend'
      @message = "本日はまだ出勤していません"
    elsif leavingstatus == 'leave'
      @message = "#{day}は#{time}に退勤しました"
    elsif leavingstatus == 'already leave'
      @message = "本日はすでに退勤しました"
    end
  end  

  erb :attend
end

get '/test-get-time' do
  Timecard_operation.testgettime()
  # p timecards.all[0].day
end
