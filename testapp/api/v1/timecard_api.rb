require './model/timecards'
require './model/users'
require './model/departments'

module API
  module V1
    class Timecards < Grape::API
      # prefix 'users'
      # resource '/:user_id' do

      resource 'users/:user_id' do

        post '/attend' do
          user_id = params[:user_id].to_i
          authenticate!(user_id)
          time = (Time.now).strftime('%X')
          date = Date.today
          if !Model::Timecard_operation.attend(date, user_id, time)
            error!('already attend', 400)
          end
          name = Model::Users.get_name(user_id)
          department =
            Model::Departments.name_of(Model::Users.get_department(user_id))
          { user_id: user_id, name: name,
            department: department, date: date, attendance: time }
        end

        put '/attend/:date' do
          user_id = params[:user_id].to_i
          authenticate!(user_id)
          date = params[:date]
          time = params[:attendance]
          Model::Timecard_operation.update_attend(date, user_id, time)
          name = Model::Users.get_name(user_id)
          department =
            Model::Departments.name_of(Model::Users.get_department(user_id))
          { user_id: user_id, name: name, department: department }
        end

        post '/leave' do
          user_id = params[:user_id].to_i
          authenticate!(user_id)
          time = (Time.now).strftime('%X')
          date = Date.today
          if !Model::Timecard_operation.returnhome(date, user_id, time)
            error!('wrong access', 400)
          end
          name = Model::Users.get_name(user_id)
          department =
            Model::Departments.name_of(Model::Users.get_department(user_id))
          { user_id: user_id, name: name,
            department: department, date: date, leaving: time }
        end

        put 'leave/:date' do
          user_id = params[:user_id].to_i
          authenticate!(user_id)
          date = params[:date]
          time = params[:leaving]
          Model::Timecard_operation.update_leave(date, user_id, time)
          name = Model::Users.get_name(user_id)
          department =
            Model::Departments.name_of(Model::Users.get_department(user_id))
          { user_id: user_id, name: name, department: department }
        end
               
        put '/attend-leave/:year_month' do
          user_id = params[:user_id].to_i
          authenticate!(user_id)
          year_month = params[:year_month]
          timecard_data = params[:data]
          timecard_data[0].day
          Model::Timecard_operation.update_all(year_month, timecard_data, user_id)
          name = Model::Users.get_name(user_id)
          department =
            Model::Departments.name_of(Model::Users.get_department(user_id))
          { user_id: user_id, name: name, department: department }
        end

      end
    end
  end    
end

