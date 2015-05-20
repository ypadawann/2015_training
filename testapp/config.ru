
#require './api/timecard_api'
require './main'
run Main

#use Rack::Session::Cookie, key: 'ams_session', expire_after: 86_400

#use Rack::Session::Cookie
#run Rack::Cascade.new [API, Web]