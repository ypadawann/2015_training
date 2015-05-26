# -*- coding: utf-8 -*-
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'date'

require 'csv'
require 'json'
require 'sinatra/contrib'
require 'erubis'

require_relative 'model/users'
require_relative 'model/departments'
require_relative 'model/timecards'

class Main < Sinatra::Base
  use Rack::Session::Cookie, key: 'ams_session', expire_after: 86_400
  set :bind, '0.0.0.0'
  set :erb, :escape_html => true


  get '/' do
    @user_id = session[:no]
    @name = Model::Users.get_name(@user_id.to_i)
    if @name
      erb :userpage
    else
      erb :login
    end
  end

  post '/login' do
    p 'login session'
    @user_id = params[:no]
    pass = params[:password]
    if Model::Users.verify(@user_id, pass)
      session[:no] = @user_id
      @name = Model::Users.get_name(@user_id.to_i)
      erb :userpage
    else
      @msg = 'ログインに失敗しました'
      erb :login
    end
  end

  post '/logout' do
    session.clear
    erb :login
  end

  get '/register' do
    erb :reg
  end

  post '/reg_finish' do
    @new_no = params[:no].to_i
    @new_name = params[:name]
    @new_department = params[:department]
    if Model::Users.add(@new_no,
                        @new_name,
                        @new_department,
                        params[:pass])
      erb :reg_finish
    else
      erb :reg_error
    end
  end

  get '/admin' do
    erb :admin
  end

  post '/admin/register_department' do
    @name = params[:name]
    @succeed = Model::Departments.add(@name)
    erb :register_department
  end

  post '/admin/change_department' do
    no = params[:no].to_i
    @new_name = params[:name]
    @old_name = Model::Departments.name_of(no)
    @succeed = Model::Departments.update(no, @new_name)
    erb :change_department
  end

  post '/admin/delete_department' do
    no = params[:no].to_i
    @name = Model::Departments.name_of(no)
    @succeed = Model::Departments.remove(no)
    erb :delete_department
  end

  post '/attend' do
    @user_id = session[:no]
    @name = Model::Users.get_name(@user_id.to_i)

    if @name.nil?
      @message = '認証に失敗しました。'
      erb :login
    else
      time = (Time.now).strftime('%X')
      day = Date.today
      @message = Model::Timecard_operation.attend(day, @user_id, time)
      erb :attend_leave
    end
  end

  post '/leave' do
    @user_id = session[:no]
    @name = Model::Users.get_name(@user_id.to_i)
    if @name.nil?
      @message = '認証に失敗しました。'
      erb :login
    else
      time = (Time.now).strftime('%X')
      day = Date.today
      @message = Model::Timecard_operation.returnhome(day, @user_id, time)
      erb :attend_leave
    end
  end

  post '/read-data' do
    @user_id = session[:no]
    if Model::Users.get_name(@user_id)
      @name = Model::Users.get_name(@user_id)
      @department =
        Model::Departments.name_of(Model::Users.get_department(@user_id))
      year = (Date.today).strftime('%Y')
      month = (Date.today).strftime('%m')
      @json_str =
        Model::Timecard_operation.read_monthly_data(@user_id, year, month)
      p @json_str
      erb :view_data
    end
  end

  get '/read-data' do
    erb :view_data
  end

  get '/userdata_modify' do
    p @user_id = session[:no]
    erb :userdata_modify
  end

  get '/test' do
    erb :admin_user
  end
end
