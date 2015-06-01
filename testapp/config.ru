
require './main'
require './admin'

require './api/base.rb'

require 'rack/protection'


map '/admin' do
  use Rack::Session::Cookie,
    key: 'admin_session',
    expire_after: 3_600
  use Rack::Protection

  run Rack::Cascade.new [API::AdminBase, Admin]
end

map '/' do
  use Rack::Session::Cookie,
    key: 'ams_session',
    expire_after: 86_400
  use Rack::Protection

  run Rack::Cascade.new [API::Base, Main]
end
