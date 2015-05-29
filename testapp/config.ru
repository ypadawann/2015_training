
require './main'
require './admin'

require './api/base.rb'


map '/admin' do
  run Rack::Cascade.new [API::Base, Admin]
end

map '/' do
  run Rack::Cascade.new [API::Base, Main]
end
