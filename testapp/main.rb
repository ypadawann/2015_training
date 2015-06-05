# -*- coding: utf-8 -*-
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
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

  get '/' do
    redirect to('/userpage') if session[:user_login]
    erb :index
  end

  before %r{\/[\w\/]+} do
    redirect to('/') unless session[:user_login]
    @user_id = session[:user_id]
  end

  get '/userpage' do
    @name = Model::Users.get_name(@user_id.to_i)
    erb %s(userpage/index)
  end

  get %r{\/userpage\/[\w\/]*} do
    @name = Model::Users.get_name(@user_id.to_i)
    show_erb
  end

  get '/bookmarklet/:action' do
    @action = params[:action]
    erb :bookmarklet
  end

  get %r{\/[\w\/]+} do
    show_erb
  end

end
