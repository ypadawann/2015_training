# -*- coding: utf-8 -*-
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/content_for'
require 'date'

require 'csv'
require 'json'
require 'sinatra/contrib'
require 'erubis'

require './controller_helpers'

require_relative 'model/users'
require_relative 'model/departments'
require_relative 'model/timecards'
require_relative 'model/admins'


class Main < Sinatra::Base
  set :bind, '0.0.0.0'
  set :erb, :escape_html => true

  register Sinatra::Reloader

  helpers ControllerHelpers
  helpers Sinatra::ContentFor

  before %r{\/(userpage|bookmarklet)[\w\/]*} do
    redirect to('/') unless session[:user_login]
    @user_id = session[:user_id]
  end

  configure :test do
    get '/test/add_department/:department_name' do
      Model::Departments.add(params['department_name'])
    end

    get '/test/add_user/:user_id/:name/:department/:password/:enter' do
      Model::Users.add(params['user_id'].to_i,
                       params['name'],
                       params['department'],
                       params['password'],
                       params['enter'])
    end
  end

  get '/' do
    redirect to('/userpage') if session[:user_login]
    erb :index
  end

  get '/userpage' do
    @name = Model::Users.get_name(@user_id.to_i)
    erb %s(userpage/layout) do
      erb %s(userpage/index)
    end
  end

  get %r{\/userpage\/[\w\/]*} do
    @name = Model::Users.get_name(@user_id.to_i)
    erb %s(userpage/layout) do
      show_erb
    end
  end

  get '/bookmarklet/:action' do
    @action = params[:action]
    erb :bookmarklet
  end

  get %r{\/[\w\/]+} do
    show_erb
  end
end
