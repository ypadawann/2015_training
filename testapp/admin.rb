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


class Admin < Sinatra::Base
  set :bind, '0.0.0.0'
  set :erb, :escape_html => true

  helpers ControllerHelpers
  helpers Sinatra::ContentFor

  get '/' do
    redirect to('/top') if session[:admin_login]
    erb 'admin/login'.to_sym
  end

  get %r{\/\w+} do
    redirect to ('/') unless session[:admin_login]
    erb 'admin/layout'.to_sym do
      show_erb
    end
  end
  
end
