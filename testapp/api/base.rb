
require 'grape'

require './api/v1/base'

module API
  class Base < Grape::API
    prefix :api
    mount V1::Base
  end
  class AdminBase < Grape::API
    prefix :api
    mount V1::AdminBase
  end
end
