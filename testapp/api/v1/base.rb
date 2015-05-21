
require './api/v1/users'

module API
  module V1
    class Base < Grape::API
      version 'v1', using: :path
      format :json

      mount Users
    end
  end
end
