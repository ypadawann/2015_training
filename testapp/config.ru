
require './main'

require './api/base.rb'

use Rack::Session::Cookie, key: 'ams_session', expire_after: 86_400
run Rack::Cascade.new [API::Base, Main]
