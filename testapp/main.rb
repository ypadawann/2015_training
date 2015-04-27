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
  @new_no = params[:no]
  @new_name = params[:name]
  @new_department = params[:department]
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

post '/admin/department_registered' do
  @name = params[:name]
  if Departments.add(@name)
    @msg = "#{@name}を登録しました。"
  else
    @msg = "登録に失敗しました。"
  end
  erb :admin
end
post '/admin/department_changed' do
  @no = params[:no] 
  @new_name = params[:name]
  @old_name = Departments.name_of(@no)
  Departments.update(@no, @new_name)
  @msg = "#{@old_name}の名前を#{@new_name}に変更しました。"
  erb :admin
  #erb :admin_department_changed
end
post '/admin/department_deleted' do
  @no = params[:no]
  @name = Departments.name_of(@no)
  if Departments.remove(@no)
    @msg = "#{@name}を削除しました。"
  else
    @msg = "その部署に所属している人がいます。"
  end
  erb :admin
  #erb :admin_department_changed
end

post '/attend' do
  @no = params[:no].to_i
  pass = params[:password].to_s
  accessresult = Userslist.access(@no,pass)
  if accessresult != 'true'
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
