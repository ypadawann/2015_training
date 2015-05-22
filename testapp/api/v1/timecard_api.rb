require './model/timecards'
require './model/users'
require './model/departments'

module API
  module V1
    class Timecards < Grape::API
      #prefix 'users'
      #resource '/:user_id' do
      resource 'users/:user_id' do
        
        post '/attend' do
          p 'attend test'
          p user_id = params[:user_id]
          if user_id == env['rack.session'][:no]
            p time = (Time.now).strftime('%X')
            p date = Date.today
            if Model::Timecard_operation.attend(date, user_id, time) == true
              p name = Model::Users.get_name(user_id)
              p department = Model::Departments.name_of(Model::Users.get_department(user_id))
              {user_id: user_id, name: name, 
                department: department, date: date, time: time}.to_json
            else
              error!('already attend', 400)
            end
          else
            p 'wrong id'
            error!('failed authentication', 403)
          end
        end
        
        put '/attend/:date' do
          p 'attend/date'
          p  user_id = params[:user_id]
          if user_id == env['rack.session'][:no]
            p date = params[:date]
            p time = params[:attendance]
            Model::Timecard_operation.update_attend(date, user_id, time)
            p name = Model::Users.get_name(user_id)
            p department = Model::Departments.name_of(Model::Users.get_department(user_id))
            {user_id: user_id, name: name, department: department}
          else
            error!('failed authentication', 403)
          end
        end
        
        post '/leave' do
          p user_id = params[:user_id]
          if user_id == env['rack.session'][:no]
            time = (Time.now).strftime('%X')
            date = Date.today
            if Model::Timecard_operation.returnhome(date, user_id, time) == true
              p name = Model::Users.get_name(user_id)
              p department = Model::Departments.name_of(Model::Users.get_department(user_id))
              {user_id: user_id, name: name, 
                department: department, date: date, leaving: time}
            else
              error!('wrong access', 400)
            end
          else
            p 'wrong id'
            error!('failed authentication', 403)
          end
        end
        
        put 'leave/:date' do
          user_id = params[:user_id]
          if user_id == env['rack.session'][:no]
            date = params[:date]
            time = params[:leaving]
            Model::Timecard_operation.update_leave(date, user_id, time)
            name = Model::Users.get_name(user_id)
            department = Model::Departments.name_of(Model::Users.get_department(user_id))
            {user_id: user_id, name: name, department: department}
          else
            error!('failed authentication', 403)
          end
        end
               
        put '/attend-leave/:year_month' do
          user_id = params[:user_id]
          if user_id == env['rack.session'][:no]
            year_month = params[:year_month]
            timecard_data = params[:data]
            timecard_data[0].day
            Model::Timecard_operation.update_all(year_month, timecard_data, user_id)
            name = Model::Users.get_name(user_id)
            department = Model::Departments.name_of(Model::Users.get_department(user_id)) 
            {user_id: user_id, name: name, department: department}
          else
            error!('failed authentication', 403)
          end
        end
        
      end
    end
  end    
end

