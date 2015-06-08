
require './api/v1/users'
require './api/v1/timecard_api'
require './api/v1/paid_vacation'
require './api/v1/utils'

require './api/v1/adminutils'
require './api/v1/departments'
require './api/v1/admin'

module API
  module V1
    class Base < Grape::API
      version 'v1', using: :path
      content_type :json, 'application/json'
      content_type :xml, 'application/xml'
      content_type :csv, 'text/csv'
      default_format :json

      helpers Utils
      mount Users
      mount Timecards
      mount PaidVacation
    end
    class AdminBase < Grape::API
      version 'v1', using: :path
      format :json
      helpers AdminUtlis
      mount Departments
      mount Admin
    end
  end
end
