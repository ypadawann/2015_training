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


class Test < Sinatra::Base
  set :bind, '0.0.0.0'
  set :erb, :escape_html => true

  register Sinatra::Reloader

  helpers ControllerHelpers
  helpers Sinatra::ContentFor

  get '/init-data' do
    Model::Admins.add('admin', 'password')

    Model::Departments.add('大日本帝国海軍')
    Model::Departments.add('呉鎮守府')
    Model::Departments.remove(Model::Departments.id_of('横須賀鎮守府'))
    Model::Users.remove(23)
    Model::Users.add(23, '戦艦　榛名', '大日本帝国海軍', 'kongoclass', '1915-04-19')
  end
 
end
