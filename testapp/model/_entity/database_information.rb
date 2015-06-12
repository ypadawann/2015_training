
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
    validates :id, uniqueness: {
      message: 'その社員番号は既に登録されています。' }
    validates :id, numericality: {
      only_integer: true, greater_than: 0, less_than: 100_000 }
      #message: '社員番号は5桁以下の正の数字で入力して下さい。' }
    validates :name, presence: true
    validates :name, length: { maximum: 50,
      message: '氏名は50字以下で入力して下さい。' }
    belongs_to :department
    validates :department, presence: true
    validates :enter, presence: true
  end

  class Department < ActiveRecord::Base
    validates :name, presence: true
    validates :name, uniqueness: {
      message: 'その部署名は既に登録されています。' }
    validates :name, length: { maximum: 50,
      message: '部署名は50字以下で入力して下さい。' }
    has_many :user
  end

  class Timecard < ActiveRecord::Base
    validates :day, presence: true
    validates :user_id, presence: true
    validates :prearranged_holiday, length: { maximum: 15,
      message: '振替休暇予定日は15字以下で入力して下さい。' }
    validates :holiday_acquisition, length: { maximum: 15,
      message: '振替休暇取得日は15字以下で入力して下さい。' }
    validates :etc, length: { maximum: 50,
      message: '備考欄は50字以下で入力して下さい。' }

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
    validates :id, uniqueness: {
      message: 'そのIDは既に使われています。' }
    validates :id, length: { maximum: 50,
      message: 'IDは50字以下で入力して下さい。' }
    validates :password, presence: true
  end
end
