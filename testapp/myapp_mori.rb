# -*- coding: utf-8 -*-

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

# require 'sinatra/reloader'

require_relative 'users_mori'

require 'date'

post '/attend' do
  @id = params[:id].to_i
  @pass = params[:pass].to_s
  @status = params[:status]
@time = Time.now
date = Date.today.to_s
  if @status == "出勤"
    Ams_operation.attend_operation(10)
    @message = "good morning"
  else
    # 帰宅データを
    @message = "Bye"
  end

    erb :attend
end
