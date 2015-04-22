
require 'rubygems'
require 'active_record'
require 'mysql2'

ActiveRecord::Base.establish_connection(
  adapter: "mysql2",
  host:    "localhost",
  username: "ko",
  password: "hemmi",
  database: "test",
)

# id: integer, name: varchar
class User < ActiveRecord::Base
  self.table_name = 'test'
end
