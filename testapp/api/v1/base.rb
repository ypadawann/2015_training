
require './api/v1/users'
require './api/v1/timecard_api'

module API
  module V1
    class Base < Grape::API
      version 'v1', using: :path
      format :json

      mount Users
      mount Timecards
    end
  end
end
