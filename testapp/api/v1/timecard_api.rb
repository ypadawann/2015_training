require './model/timecards'
require './model/users'
require './model/departments'

require './api/v1/timeutils'

module API
  module V1
    class Timecards < Grape::API
      helpers TimeUtils

      params do
        requires :user_id, type: Integer, desc: '社員番号'
      end
      resource 'users/:user_id' do
        post '/attend' do
          user_id = params[:user_id]
          authenticate!(user_id)
          date = Date.today
          error!('Already Attended', 400) if
            Model::Timecard_operation.get_attendance(date, user_id).present?

          time = (Time.now).strftime('%H:%M')
          Model::Timecard_operation.attend(date, user_id, time)

          results = Model::Users.status(user_id)
          results[:date] = date
          results[:attendance] = time
          results
        end

        params do
          requires :date, type: Date, desc: '日付'
          requires :attendance, type: Time, desc: '出勤時間'
        end
        put '/attend/:date' do
          user_id = params[:user_id]
          authenticate!(user_id)
          date = params[:date]
          time = params[:attendance]
          Model::Timecard_operation.attend(date, user_id, time)

          results = Model::Users.status(user_id)
          results[:attendance] = time
          results
        end

        post '/leave' do
          user_id = params[:user_id]
          authenticate!(user_id)
          date = Date.today
          error!('Already Left', 400) if
            Model::Timecard_operation.get_leaving(date, user_id).present?
          error!('Not Attended Yet', 404) if
            Model::Timecard_operation.get_attendance(date, user_id).blank?

          time = (Time.now).strftime('%H:%M')
          Model::Timecard_operation.returnhome(date, user_id, time)

          results = Model::Users.status(user_id)
          results[:date] = date
          results[:leaving] = time
          results
        end

        params do
          requires :date, type: Date, desc: '日付'
          requires :leaving, type: Time, desc: '退勤時間'
        end
        put 'leave/:date' do
          user_id = params[:user_id]
          authenticate!(user_id)
          date = params[:date]
          time = params[:leaving]
          Model::Timecard_operation.leave(date, user_id, time)

          results = Model::Users.status(user_id)
          results[:leaving] = time
          results
        end

        params do
          requires :year, type: Integer, desc: '年'
          requires :month, type: Integer, desc: '月'
        end
        put '/attend-leave/:year/:month' do
          user_id = params[:user_id]
          authenticate!(user_id)
          year = params[:year]
          month = params[:month]
          data = params[:data]
          Model::Timecard_operation.update_all(year, month, data, user_id)

          Model::Users.status(user_id)
        end

        params do
          requires :year, type: Integer, desc: '年'
          requires :month, type: Integer, desc: '月'
        end
        get '/attend-leave/:year/:month' do
          user_id = params[:user_id]
          year = params[:year]
          month = params[:month]
          timecards =
            Model::Timecard_operation.read_monthly_data(user_id, year, month)

          timecards =
            timecards.map do |timecard|
              timecard
              .merge!(types_of_day(year, month, timecard[:day]))
              .merge!(calculate_extra_hours(timecard))
            end

          results = Model::Users.status(user_id)
          results[:data] = timecards
          results
        end
      end
    end
  end
end
