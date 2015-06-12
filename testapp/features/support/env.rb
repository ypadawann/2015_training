require 'capybara'
require 'capybara/cucumber'
require 'capybara/poltergeist'

Capybara.app = eval("Rack::Builder.new {( " + File.read(File.dirname(__FILE__) + '/../../config.ru') + "\n )}")
Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist
