require 'capybara'
require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'database_cleaner'
require 'database_cleaner/cucumber'
require 'active_record'

ENV['RACK_ENV'] ||= 'test'
DatabaseCleaner.strategy = :truncation

Capybara.app = eval("Rack::Builder.new {( " + File.read(File.dirname(__FILE__) + '/../../config.ru') + "\n )}")
Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist

before do
  DatabaseCleaner.start
end

after do |scenario|
  DatabaseCleaner.clean
end
