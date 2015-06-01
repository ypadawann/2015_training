require './model/timecards'
require './model/users'
require './model/departments'

module API
  module V1
    class Timecards < Grape::API
      resource 'users/:user_id' do

        post '/attend' do
          user_id = params[:user_id].to_i
          authenticate!(user_id)
          date = Date.today
          error!('Already Attended', 400) unless
            Model::Timecard_operation.get_attendance(date, user_id).nil?

          time = (Time.now).strftime('%H:%M')
          Model::Timecard_operation.attend(date, user_id, time)

          results = Model::Users.status(user_id)
          results[:date] = date
          results[:attendance] = time
          results
        end

        put '/attend/:date' do
          user_id = params[:user_id].to_i
          authenticate!(user_id)
          date = params[:date]
          time = params[:attendance]
          Model::Timecard_operation.attend(date, user_id, time)

          results = Model::Users.status(user_id)
          results[:attendance] = time
          results
        end

        post '/leave' do
          user_id = params[:user_id].to_i
          authenticate!(user_id)
          date = Date.today
          error!('Already Left', 400) unless
            Model::Timecard_operation.get_leaving(date, user_id).nil?
          error!('Not Attended Yet', 404) if
            Model::Timecard_operation.get_attendance(date, user_id).nil?

          time = (Time.now).strftime('%H:%M')
          Model::Timecard_operation.returnhome(date, user_id, time)

          results = Model::Users.status(user_id)
          results[:date] = date
          results[:leaving] = time
          results
        end

        put 'leave/:date' do
          user_id = params[:user_id].to_i
          authenticate!(user_id)
          date = params[:date]
          time = params[:leaving]
          Model::Timecard_operation.leave(date, user_id, time)

          results = Model::Users.status(user_id)
          results[:leaving] = time
          results
        end

        put '/attend-leave/:year/:month' do
          user_id = params[:user_id].to_i
          authenticate!(user_id)
          year = params[:year]
          month = params[:month]
          timecard_data = params[:data]
          Model::Timecard_operation.update_all(year, month, timecard_data, user_id)

          Model::Users.status(user_id)
        end

        get '/attend-leave/:year/:month' do
          user_id = params[:user_id].to_i
          year = params[:year]
          month = params[:month]
          data =
            Model::Timecard_operation.read_monthly_data(user_id, year, month)

          results = Model::Users.status(user_id)
          results[:data] = data
          results
        end
      end
    end
  end
end
