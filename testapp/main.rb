# -*- coding: utf-8 -*-

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

require_relative 'users'
require_relative 'departments'
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
