
require 'active_record'
require 'mysql2'
require 'yaml'

db_env = ENV['RACK_ENV'] || 'test'

config = YAML.load_file('./config/database.yml')

ActiveRecord::Base.establish_connection(config[db_env])

module Model
  class User < ActiveRecord::Base
    self.primary_key = :id

    validates :id, presence: true
    validates :id, uniqueness: true
    validates :id, numericality: {
      only_integer: true, greater_than: 0, less_than: 10_000 }
    validates :name, presence: true
    validates :name, length: { maximum: 50 }
    belongs_to :department
    validates :department, presence: true
    validates :enter, presence: true
  end

  class Department < ActiveRecord::Base
    validates :name, presence: true
    validates :name, uniqueness: true
    validates :name, length: { maximum: 50 }
    has_many :user
  end

  class Timecard < ActiveRecord::Base
    validates :day, presence: true
    validates :user_id, presence: true
    validates :attendance, length: { maximum: 10 }
    validates :leaving, length: { maximum: 10 }

    class TimeValidator < ActiveModel::Validator
      FORMAT = /\A\d\d?:\d\d\Z/
      def validate(record)
        record.errors[:attendance] << '出勤時間の形式が不適切です。' if
          record[:attendance].present? && FORMAT.match(record[:attendance]).nil?
        record.errors[:leaving] << '退勤時間の形式が不適切です。' if
          record[:leaving].present? && FORMAT.match(record[:leaving]).nil?
      end
    end
    validates_with TimeValidator
  end

  class Admin < ActiveRecord::Base
    self.primary_key = :id

    validates :id, presence: true
    validates :id, uniqueness: true
    validates :id, length: { maximum: 50 }
    validates :password, presence: true
  end
end
