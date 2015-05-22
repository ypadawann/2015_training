
require './api/v1/users'
require './api/v1/timecard_api'
require './api/v1/utils'

module API
  module V1
    class Base < Grape::API
      version 'v1', using: :path
      format :json

      helpers Utils

      mount Users
      mount Timecards
    end
  end
end
