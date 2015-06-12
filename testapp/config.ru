
require './main'
require './admin'

require './api/base.rb'

require 'rack/protection'


map '/admin' do
  use Rack::Session::Cookie,
    key: 'admin_session',
    expire_after: 3_600,
    secret: "AMS admin session key"
  use Rack::Protection

  run Rack::Cascade.new [API::AdminBase, Admin]
end

map '/' do
  use Rack::Session::Cookie,
    key: 'ams_session',
    expire_after: 604_800,
    secret: "AMS user session key"
  use Rack::Protection

  run Rack::Cascade.new [API::Base, Main]
end
