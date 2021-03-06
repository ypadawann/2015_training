_RACK_ENV = ENV['RACK_ENV'] || 'test'

require 'active_record'
if _RACK_ENV == 'production'
  require 'mysql2'
end
require 'yaml'


config = YAML.load_file('./config/database.yml')

ActiveRecord::Base.establish_connection(config[_RACK_ENV])

module Model
  class User < ActiveRecord::Base
    self.primary_key = :id

    validates :id, presence: {
      message: '社員番号を入力して下さい。' }
    validates :id, uniqueness: {
      message: 'その社員番号は既に登録されています。' }
    validates :id, numericality: {
      only_integer: true,
      greater_than: 0, less_than: 100_000,
      message: '社員番号は5桁以下の正の数字で入力して下さい。' }
    validates :name, presence: {
      message: '名前を入力して下さい。' }
    validates :name, length: {
      maximum: 50,
      message: '名前は50字以下で入力して下さい。' }
    belongs_to :department
    validates :department, presence: {
      message: '所属を選択して下さい。' }
    validates_format_of :enter,
      with: /\A\d{4}-\d\d?-\d\d?\z/,
      message: '入社年月日の形式が不適切です。'
  end

  class Department < ActiveRecord::Base
    validates :name, presence: {
      message: '部署名を入力して下さい。' }
    validates :name, uniqueness: {
      message: 'その部署名は既に登録されています。' }
    validates :name, length: {
      maximum: 50,
      message: '部署名は50字以下で入力して下さい。' }
    has_many :user
  end

  class Timecard < ActiveRecord::Base
    validates :day, presence: {
      message: '日付を入力して下さい。' }
    validates :user_id, presence: true
    validates :prearranged_holiday, length: {
      maximum: 15,
      message: '振替休暇予定日は15字以下で入力して下さい。' }
    validates :holiday_acquisition, length: {
      maximum: 15,
      message: '振替休暇取得日は15字以下で入力して下さい。' }
    validates :etc, length: {
      maximum: 50,
      message: '備考欄は50字以下で入力して下さい。' }

    class TimeValidator < ActiveModel::Validator
      FORMAT = /\A\d\d?:(\d\d)\z/

      def self.invalid_format?(time)
        return false if time.blank?
        m = FORMAT.match(time)
        m.nil? || m[1].to_i >= 60
      end

      def validate(record)
        record.errors[:attendance] << '出勤時間の形式が不適切です。' if
          TimeValidator.invalid_format?(record[:attendance])
        record.errors[:leaving] << '退勤時間の形式が不適切です。' if
          TimeValidator.invalid_format?(record[:leaving])
      end
    end
    validates_with TimeValidator
  end

  class Admin < ActiveRecord::Base
    self.primary_key = :id

    validates :id, presence: {
      message: 'IDを入力して下さい。' }
    validates :id, uniqueness: {
      message: 'そのIDは既に使われています。' }
    validates :id, length: {
      maximum: 50,
      message: 'IDは50字以下で入力して下さい。' }
    validates :password, presence: {
      message: 'パスワードを入力して下さい。' }
  end
end
