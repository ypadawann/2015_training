
require 'active_record'
require 'mysql2'
require 'yaml'

config = YAML.load_file('./config/database.yml')

ActiveRecord::Base.establish_connection(config[ENV['RACK_ENV']])

class User < ActiveRecord::Base
  validates :id, presence: true
  validates :id, uniqueness: true
  validates :id, numericality: {
    only_integer: true, greater_than: 0, less_than: 10_000 }
  validates :name, presence: true
  validates :name, length: { maximum: 50 }
  belongs_to :department
  validates :department, presence: true
end

class Department < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { maximum: 50 }
  has_many :user
end

class Timecard < ActiveRecord::Base
end
