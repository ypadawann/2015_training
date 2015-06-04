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
  use Rack::Session::Cookie, key: 'ams_session', expire_after: 86_400
  set :bind, '0.0.0.0'
  set :erb, :escape_html => true

  register Sinatra::Reloader

  before do
    @user_id = session[:no]
    @name = Model::Users.get_name(@user_id.to_i)
  end

  helpers ControllerHelpers

  get '/bookmarklet/:action' do
    redirect to('/') unless @name
    p @action = params[:action]
    erb :bookmarklet
  end

  get '/' do
    redirect to('/userpage') if @name
    erb :index
  end

  get '/userpage' do
    redirect to('/') unless @name
    erb %s(userpage/index)
  end

  get %r{\/userpage\/[\w\/]*} do
    redirect to('/') unless @name
    show_erb
  end

  get %r{\/[\w\/]+} do
    show_erb
  end

end
