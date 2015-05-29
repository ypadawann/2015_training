class CreateTimecards < ActiveRecord::Migration
  def change
    create_table :timecards do |t|
      t.date :day
      t.integer :user_id
      t.time :attendance
      t.time :leaving
    end
    add_foreign_key(:timecards, :users, column: 'user_id')
  end
end
