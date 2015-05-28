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


class Admin < Sinatra::Base
#  use Rack::Session::Cookie, key: 'ams_session', expire_after: 86_400
  set :bind, '0.0.0.0'
  set :erb, :escape_html => true

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
    def app_path
      "#{request.scheme}://#{request.host_with_port}"
    end

    def js_path
      "#{app_path}/dist/js"
    end

    def css_path
      "#{app_path}/dist/style"
    end
  end

  get '/*' do
    p 'admin'
    if session[:login_status]
      show_erb
    else
      erb 'admin/login'.to_sym
    end
  end

end
