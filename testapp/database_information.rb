
require 'active_record'
require 'mysql2'

ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  host:    'localhost',
  username: 'root',
  password: 'password',
  database: 'test_db'
)

class User < ActiveRecord::Base
  validates :id, presence: true
  validates :id, uniqueness: true
  validates :id, numericality: {
    only_integer: true, greater_than: 0, less_than: 10_000 }
  validates :name, presence: true
  validates :name, length: { maximum: 50 }
end

class Department < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { maximum: 50 }
end

class Timecard < ActiveRecord::Base
end
