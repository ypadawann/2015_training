
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

class Dep < ActiveRecord::Base
end

class Oms < ActiveRecord::Base
end
