# -*- coding: utf-8 -*-
require './model/timecards'
require './model/users'
require './model/departments'

require './api/v1/timeutils'
require './api/v1/csv_formatter'

module API
  module V1
    class Timecards < Grape::API
      helpers TimeUtils
      helpers CSVFormatter

      params do
        requires :user_id, type: Integer, desc: '社員番号'
      end
      resource 'users/:user_id' do
        get '/attend' do
          user_id = params[:user_id]
          authenticate!(user_id)
          date = Date.today
          Model::Timecard_operation.get_attendance(date, user_id).presence ||
            error!('本日はまだ出勤していません。', 400)
        end

        post '/attend' do
          user_id = params[:user_id]
          authenticate!(user_id)
          date = Date.today
          error!('本日は既に出勤しています。', 400) if
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

        get '/leave' do
          user_id = params[:user_id]
          authenticate!(user_id)
          date = Date.today
          Model::Timecard_operation.get_leaving(date, user_id).presence ||
            error!('本日はまだ退勤していません。', 400)
        end

        post '/leave' do
          user_id = params[:user_id]
          authenticate!(user_id)
          date = Date.today
          error!('本日は既に退勤しています。', 400) if
            Model::Timecard_operation.get_leaving(date, user_id).present?
          error!('本日はまだ出勤していません。', 400) if
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
          requires :data, type: Array, desc: '月の出退勤データ' do
            requires :day, type: Integer, desc: '日'
            requires :attendance, type: String, desc: '出勤時間'
            requires :leaving, type: String, desc: '退勤時間'
            requires :prearranged_holiday, type: String, desc: '振替休暇予定日'
            requires :paid_vacation, type: Float, desc: '有給休暇'
            requires :holiday_acquisition, type: String, desc: '振替休暇取得日'
            requires :etc, type: String, desc: 'その他'
          end
          requires :year, type: Integer, desc: '年'
          requires :month, type: Integer, desc: '月'
        end
        put '/attend-leave/:year/:month' do
          user_id = params[:user_id]
          authenticate!(user_id)
          year = params[:year]
          month = params[:month]
          data = params[:data]

          invalid_date, msg =
            Model::Timecard_operation.find_invalid_data(
              year, month, data, user_id)
          return error!("#{invalid_date}:\n#{msg}", 400) unless invalid_date.nil?

          Model::Timecard_operation.update_all(year, month, data, user_id)

          Model::Users.status(user_id)
        end

        params do
          requires :year, type: Integer, desc: '年'
          requires :month, type: Integer, desc: '月'
        end
        get '/attend-leave/:year/:month' do
          contents = Model::Users.status(params[:user_id])
          contents[:data] =
            get_full_attendance_data(
              params[:user_id], params[:year], params[:month])
          contents[:total] =
            calculate_totals(contents[:data])
          contents
        end

        params do
          requires :year, type: Integer, desc: '年'
          requires :month, type: Integer, desc: '月'
        end
        get '/attend-leave/:year/:month/export' do
          authenticate!(params[:user_id])
          contents = Model::Users.status(params[:user_id])
          contents[:data] =
            get_full_attendance_data(
              params[:user_id], params[:year], params[:month])
          contents[:total] =
            calculate_totals(contents[:data])

          bom = '   '
          bom.setbyte(0, 0xEF)
          bom.setbyte(1, 0xBB)
          bom.setbyte(2, 0xBF)

          content_type 'text/csv'
          filename = format('%d_%d%02d.csv',
                            params[:user_id], params[:year], params[:month])
          header('Content-Disposition', "attachment; filename=#{filename}")
          bom + export_csv(contents, params[:year], params[:month])
        end
      end
    end
  end
end
