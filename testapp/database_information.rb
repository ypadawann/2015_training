
require 'rubygems'
require 'active_record'
require 'mysql2'

ActiveRecord::Base.establish_connection(
  adapter: "mysql2",
  host:    "localhost",
  username: "root",
  password: "password",
  database: "test_db",
)

# id: integer, name: varchar
class User < ActiveRecord::Base
end

class Department < ActiveRecord::Base
  validates :no, uniqueness: true 
end

class Timecard < ActiveRecord::Base
end
