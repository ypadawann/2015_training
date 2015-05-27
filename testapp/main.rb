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
require_relative 'model/admins'


class Main < Sinatra::Base
  use Rack::Session::Cookie, key: 'ams_session', expire_after: 86_400
  set :bind, '0.0.0.0'
  set :erb, :escape_html => true

  before do
    @user_id = session[:no]
    @name = Model::Users.get_name(@user_id.to_i)
  end

  helpers do
    def show_erb
      path = request.path
      path.slice!(0, 1)
      if File.exist?("#{settings.views}/#{path}.erb")
        erb "#{path}".to_sym
      else
        raise Sinatra::NotFound.new
      end
    end
  end

  get '/' do
    if @name
      erb :userpage
    else
      erb :login
    end
  end

  get %r{\/[\w\/]+} do
    show_erb
  end

  post '/admin/register_department' do
    @name = params[:name]
    @succeed = Model::Departments.add(@name)
    show_erb
  end

  post '/admin/change_department' do
    no = params[:no].to_i
    @new_name = params[:name]
    @old_name = Model::Departments.name_of(no)
    @succeed = Model::Departments.update(no, @new_name)
    show_erb
  end

  post '/admin/delete_department' do
    no = params[:no].to_i
    @name = Model::Departments.name_of(no)
    @succeed = Model::Departments.remove(no)
    show_erb
  end

  get '/admin-add' do
    Model::Admins.add('root', 'password')
  end

  get '/admin-auth' do
    if Model::Admins.verify('root', 'password')
      p 'true'
    else
      p 'false'
    end
  end
end
