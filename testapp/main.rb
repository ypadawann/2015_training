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

  get '/register' do
    erb :reg
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

  get '/read-data' do
    erb :view_data
  end

  get '/userdata_modify' do
    p @user_id = session[:no]
    erb :userdata_modify
  end
end
