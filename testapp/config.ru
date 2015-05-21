
require './main'

require './api/base.rb'

run Rack::Cascade.new [API::Base, Main]
