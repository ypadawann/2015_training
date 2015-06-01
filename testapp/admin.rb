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


class Admin < Sinatra::Base
  set :bind, '0.0.0.0'
  set :erb, :escape_html => true

  helpers ControllerHelpers

  get '/' do
    redirect to('/top') if session[:login_status]
    erb 'admin/login'.to_sym
  end

  get %r{\/\w+} do
    p 'admin'
    if session[:login_status]
      show_erb
    else
      erb 'admin/login'.to_sym
    end
  end

end
