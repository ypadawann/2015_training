
require './api/v1/users'
require './api/v1/departments'
require './api/v1/timecard_api'
require './api/v1/utils'
require './api/v1/admin'

module API
  module V1
    class Base < Grape::API
      version 'v1', using: :path
      format :json
      helpers Utils
      mount Users
      mount Timecards
    end
    class AdminBase < Grape::API
      version 'v1', using: :path
      format :json
      mount Departments
      mount Admin
    end
  end
end
