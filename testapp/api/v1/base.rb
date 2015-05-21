
require 'grape'

module API
  module V1
    class Base < Grape::API
      version 'v1', using: :path
      format :json
    end
  end
end
