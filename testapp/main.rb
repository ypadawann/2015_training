# -*- coding: utf-8 -*-

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'composite_primary_keys'

require_relative 'users'
require_relative 'departments'
require_relative 'timecards'
# require_relative 'timecards'

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
  @new_department = params[:department].to_i
  if Userslist.add(@new_no, @new_name,
                   @new_department, params[:pass])
    erb :reg_finish
  else
    erb :reg_error
  end
end

get '/admin' do
  erb :admin
end

post '/register_department' do
  @name = params[:name]
  if params[:button_action] == '登録'
    if Departments.add(@name)
      @msg = "部署:#{@name}を登録しました。"
    else
      @msg = "登録に失敗しました。"
    end
  else
    if Departments.remove(@name)
      @msg = "部署:#{@name}を削除しました。"
    else
      @msg = "削除に失敗しました。"
    end
  end
  erb :admin
end

post '/attend' do
  @no = params[:no].to_i
  pass = params[:password].to_s
  accessresult = Userslist.access(@no,pass)
  if accessresult != true
    @message = accessresult
  else
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
  end
  erb :attend
end

get '/test-get-time' do
  Timecard_operation.testgettime()
  # p timecards.all[0].day
end
